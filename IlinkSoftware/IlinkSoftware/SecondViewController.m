//
//  SecondViewController.m
//  IlinkSoftware
//
//  Created by Lakshmanan on 06/03/18.
//  Copyright © 2018 Lakshmanan. All rights reserved.
//

#import "SecondViewController.h"
#import "APIDataModel.h"

@interface SecondViewController ()

@property (nonatomic, strong) NSArray *cities;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cities = @[@"Chennai", @"Bangalore", @"Pune"];
}

-(void)getData:(NSString*)city
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        APIDataModel *dataModel = [[APIDataModel alloc] init];
        [dataModel getCurrentWeatherByLocation:city withCompletionHandler:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
            NSDictionary *details = [data objectForKey:@"main"];
            if (details) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.cityName.text = [data objectForKey:@"name"];
                    weakSelf.humidity.text = [NSString stringWithFormat:@"Humidity : %@",[details objectForKey:@"humidity"]];
                    weakSelf.temperature.text = [NSString stringWithFormat:@"Temperature : %@",[details objectForKey:@"temp"]];
                });
            }
        }];
    });
}


#pragma mark UITableView

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Select Your City";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.cities objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *city = [NSString stringWithFormat:@"%@", [self.cities objectAtIndex:indexPath.row]];
    [self getData:city];
}

#pragma mark

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSString *searchCity = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self getData:searchCity];
    [textField setText:@""];
    return YES;
}


@end
