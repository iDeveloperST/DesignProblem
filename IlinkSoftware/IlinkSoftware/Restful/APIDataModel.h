//
//  APIDataModel.h
//  IlinkSoftware
//
//  Created by Lakshmanan on 06/03/18.
//  Copyright © 2018 Lakshmanan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@interface APIDataModel : NSObject

@property (nonatomic) BOOL isDownloading;

- (nullable instancetype)initWithDownload;
- (void)downloadFileAtURL:(nullable NSURL *)url;

- (void)getCurrentWeatherByLocation:(nullable NSString*)location withCompletionHandler:(nullable void (^)(NSDictionary *_Nullable data, NSError * _Nullable error))completionHandler;

@end
