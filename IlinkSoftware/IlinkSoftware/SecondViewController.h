//
//  SecondViewController.h
//  IlinkSoftware
//
//  Created by Lakshmanan on 06/03/18.
//  Copyright © 2018 Lakshmanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *cityTextField;
@property (nonatomic, weak) IBOutlet UILabel *cityName;
@property (nonatomic, weak) IBOutlet UILabel *humidity;
@property (nonatomic, weak) IBOutlet UILabel *temperature;

@end

