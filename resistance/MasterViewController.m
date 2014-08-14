//
//  MasterViewController.m
//  resistance
//
//  Created by Tian, Vincent on 8/12/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailTableViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController
            
- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.leftBarButtonItem = addButton;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithView:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.navigationItem.rightBarButtonItem.enabled = false;
    
    self.detailViewController = (DetailTableViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    
    self.headerTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 300, 40)];
    [self.headerTextField setBackgroundColor:[UIColor lightGrayColor]];
    [self.headerTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [headerView addSubview:self.headerTextField];
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, 305, 45)];
    text.text = @"Add the names of your players below! You need at least 5 and can have at most 10";
    text.backgroundColor = [UIColor clearColor];
    [headerView addSubview:text];
    
    self.tableView.tableHeaderView = headerView;
    self.headerTextField.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    if (self.headerTextField.text.length == 0) {
        return;
    }
    [self.objects insertObject:[self.headerTextField text] atIndex:0];
    [self.headerTextField setText:@""];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    if ([self.objects count] >= 5) {
        self.navigationItem.rightBarButtonItem.enabled = true;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = false;
    }
    if ([self.objects count] >= 10) {
        self.navigationItem.leftBarButtonItem.enabled = false;
        self.headerTextField.enabled = false;
    }
}

- (void)doneWithView:(id)sender {
    DetailTableViewController *detailView = (DetailTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    detailView.namesArray = self.objects;
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - Text Field delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self insertNewObject:nil];
    return YES;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.navigationItem.leftBarButtonItem.enabled = true;
        self.headerTextField.enabled = true;
        if ([self.objects count] >= 5) {
            self.navigationItem.rightBarButtonItem.enabled = true;
        } else {
            self.navigationItem.rightBarButtonItem.enabled = false;
        }
        if ([self.objects count] >= 10) {
            self.navigationItem.leftBarButtonItem.enabled = false;
            self.headerTextField.enabled = false;
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
