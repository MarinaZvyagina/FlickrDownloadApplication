//
//  ViewController.h
//  FlickrDownloadApplication
//
//  Created by Марина Звягина on 31.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDADataBase.h"

@interface ViewController : UIViewController

-(instancetype) initWithPicturesManager:(id<FDADataBase>) picturesManager;

@end

