//
//  NSOCell.m
//  NSOperationProject
//
//  Created by Марина Звягина on 20.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "FDACell.h"

NSString *const FDACellIdentifier = @"FDACellIdentifier";

@interface FDACell ()
@property (nonatomic, strong) UIImageView * pictureImage;
@end


@implementation FDACell


- (instancetype)initWithUrl: (NSString *)url {
    self = [super init];
    if (self){
        [self createSubviews];
        [self loadImage:url];
    }
    return self;
}

-(void) loadImage: (NSString *) url {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:url];
                       __block NSData *imageData;
                       
                       dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                     ^{
                                         imageData = [NSData dataWithContentsOfURL:imageURL];
                                         dispatch_sync(dispatch_get_main_queue(), ^{
                                             __strong typeof(self) strongSelf = weakSelf;
                                             if (strongSelf) {
                                                 strongSelf.pictureImage.image = [UIImage imageWithData:imageData];
                                             }
                                         });
                                     });
                   });
}

-(void)createSubviews {
    self.pictureImage = [UIImageView new];
    [self addSubview:self.pictureImage];
}

@end
