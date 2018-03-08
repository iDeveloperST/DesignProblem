//
//  FirstViewController.m
//  IlinkSoftware
//
//  Created by Lakshmanan on 06/03/18.
//  Copyright © 2018 Lakshmanan. All rights reserved.
//
/*
 http://speedtest.ftp.otenet.gr/files/test1Gb.db
 */

#import "FirstViewController.h"
#import "APIDataModel.h"

@interface FirstViewController ()

@property (nonatomic, strong) APIDataModel *dataModel;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveUpdateProgress:)
                                                 name:@"updateProgress"
                                               object:nil];
    self.dataModel = [[APIDataModel alloc] initWithDownload];
}

-(void)receiveUpdateProgress:(NSNotification*)notifyObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *progress = (NSNumber*)notifyObject.object;
        [self.progressView setProgress:[progress floatValue] animated:YES];
    });
}

-(IBAction)startDownload:(id)sender
{
    if (!self.dataModel.isDownloading && _downloadURLText.text.length > 5) {
        [self.dataModel downloadFileAtURL:[NSURL URLWithString:_downloadURLText.text]];
    }
}

#pragma mark UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
