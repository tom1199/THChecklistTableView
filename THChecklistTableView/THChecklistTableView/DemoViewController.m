//
//  DemoViewController
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import "DemoViewController.h"
#import "MyDataModalItem.h"
#import "MyDataModal.h"
@interface DemoViewController ()
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#define ITEM_COUNT 30
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
        MyDataModal *dataModal = nil;
        MyDataModalItem *dataModalItem = nil;
        for (int i = 0; i < ITEM_COUNT; i++) {
            dataModal = [[MyDataModal alloc]init];
            dataModal.name = [NSString stringWithFormat:@"Item %d",i];
            dataModal.price = 100 * i;
            dataModal.rating = rand()%5;
            
            dataModalItem = [[MyDataModalItem alloc]initWithDataModal:dataModal];
            [_dataSource addObject:dataModalItem];
        }
    }
    return _dataSource;
}
- (IBAction)pushAcion:(id)sender {
    THChecklistTableViewController *checklistTableViewController = [[THChecklistTableViewController alloc]initWithStyle:UITableViewStylePlain];
    checklistTableViewController.data = self.dataSource;
    checklistTableViewController.delegate = self;
    [self.navigationController pushViewController:checklistTableViewController animated:YES];
}

#pragma THChecklistTableViewControllerDelegate
- (void)checklistTableViewController:(THChecklistTableViewController *)controller willExitWithData:(NSMutableArray *)data {
    self.dataSource = data;
}
- (THChecklistItem *)checklistItem {
    MyDataModal *dataModal = [[MyDataModal alloc]init];    
    return [[MyDataModalItem alloc]initWithDataModal:dataModal];
}
- (NSString *)uncheckedImage {
    return @"checkbox_unchecked.png";
}
- (NSString *)checkedImage {
    return @"checkbox_checked.png";
}
@end
