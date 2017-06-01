//
//  NSODataBase.h
//  NSOperationProject
//
//  Created by Марина Звягина on 20.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FDADataBase <NSObject>

-(NSArray <NSString *>*)getPictures: (NSString *)phrase;

@end
