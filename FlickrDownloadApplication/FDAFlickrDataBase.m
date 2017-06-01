//
//  NSOFlipperDataBase.m
//  NSOperationProject
//
//  Created by Марина Звягина on 20.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "FDAFlickrDataBase.h"

@implementation FDAFlickrDataBase

-(NSArray <NSString *>*)getPictures: (NSString *)phrase{
    if (phrase == nil )
        phrase = @"";
    NSString * string = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&text=Cat&api_key=c55f5a419863413f77af53764f86bd66&format=json&nojsoncallback=1";

    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    
    __block NSData *responseData = [NSURLConnection sendSynchronousRequest:nsurlRequest returningResponse:nil error:nil];
    
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    
    [[session dataTaskWithRequest:nsurlRequest
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    responseData = data;
                }] resume];
    NSMutableArray * result = [NSMutableArray new];
    if (responseData) {
        NSDictionary * JSONObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];

       // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        NSString * str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSDictionary * photos = [JSONObject objectForKey:@"photos"];
        NSDictionary * photo = [photos objectForKey:@"photo"];
        
        for (NSDictionary * object in photo ) {
            NSString *farm_id = [object objectForKey:@"farm"];
            NSString *server_id = [object objectForKey:@"server"];
            NSString *photo_id = [object objectForKey:@"id"];
            NSString *secret = [object objectForKey:@"secret"];
           
            NSString *s0 = @"https://farm";
            NSString *s1 = [s0 stringByAppendingString:farm_id.description];
            NSString *s2 = [s1 stringByAppendingString:@".staticflickr.com/"];
            NSString *s3 = [s2 stringByAppendingString:server_id.description];
            NSString *s4 = [s3 stringByAppendingString:@"/"];
            NSString *s5 = [s4 stringByAppendingString:photo_id.description];
            NSString *s6 = [s5 stringByAppendingString:@"_"];
            NSString *s7 = [s6 stringByAppendingString:secret.description];
            
            NSString *photoString = [s7 stringByAppendingString:@".jpg"];
            
            [result addObject:photoString];
        }
    }
    
    return result;
}


@end
