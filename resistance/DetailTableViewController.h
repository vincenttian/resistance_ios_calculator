//
//  DetailTableViewController.h
//  resistance
//
//  Created by Tian, Vincent on 8/14/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *namesArray;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
