//
//  MasterViewController.h
//  resistance
//
//  Created by Tian, Vincent on 8/12/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailTableViewController;

@interface MasterViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) DetailTableViewController *detailViewController;

@property UITextField *headerTextField;


@end

