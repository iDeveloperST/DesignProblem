//
//  APIDataModel.m
//  IlinkSoftware
//
//  Created by Lakshmanan on 06/03/18.
//  Copyright © 2018 Lakshmanan. All rights reserved.
//

#import "APIDataModel.h"

@interface APIDataModel () <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (strong, nonatomic) NSURLSession *session;
@property (nonatomic) float progressValue;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation APIDataModel


#pragma mark Weather API

- (void)getCurrentWeatherByLocation:(NSString*)location withCompletionHandler:(void (^)(NSDictionary *_Nullable data, NSError * _Nullable error))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=7803898af1987af729d552643b71dbbc", location];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSError *jsonError;
        NSData *objectData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&jsonError];
        completionHandler(json, error);
    }] resume];
}


#pragma mark Download API

- (instancetype)initWithDownload {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        self.isDownloading = NO;
    }
    return self;
}

- (void)downloadFileAtURL:(NSURL *)url {
    if (!self.isDownloading) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDownloadTask *downloadTask;
        downloadTask = [self.session downloadTaskWithRequest:request];
        [downloadTask resume];
        [self startTimer];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    [self stopTimer];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.progressValue = (double)totalBytesWritten/(double)totalBytesExpectedToWrite;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    [self stopTimer];
}

#pragma mark Timer

- (void)startTimer {
    self.isDownloading = YES;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0f
                                                  target:self
                                                selector:@selector(updateProgressValue:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)stopTimer {
    self.isDownloading = NO;
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = nil;
}

- (void)updateProgressValue:(NSTimer *)timer {
    NSNumber *progress = [[NSNumber alloc] initWithFloat:self.progressValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProgress" object:progress];
}


@end
