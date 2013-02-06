//
//  THChecklistTableViewController.h
//  THChecklistTableView
//
//  Created by Tang Han on 30/1/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THChecklistItemCell.h"
#import "THChecklistItem.h"

@class THChecklistTableViewController;
@protocol THChecklistTableViewControllerDelegate
- (void)checklistTableViewController:(THChecklistTableViewController *)controller willExitWithData:(NSMutableArray *)data;
- (THChecklistItem *)checklistItem;
- (NSString *)checkedImage;
- (NSString *)uncheckedImage;
@end

@interface THChecklistTableViewController : UITableViewController<UITextFieldDelegate,UITextInputTraits,THChecklistItemCellDelegate>
@property (nonatomic,weak)id<THChecklistTableViewControllerDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *data;
@end
