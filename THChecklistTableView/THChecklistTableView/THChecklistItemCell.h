//
//  THChecklistItemCell.h
//  THChecklistTableView
//
//  Created by Tang Han on 30/1/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THChecklistItemCellDefault;

@protocol THChecklistItemCellDelegate
- (void)cell:(THChecklistItemCellDefault *)cell checkboxValueDidChangeWithValue:(BOOL)value;
@end

@interface THChecklistItemCellDefault : UITableViewCell
@property (nonatomic,weak)id<THChecklistItemCellDelegate>delegate;
@property (nonatomic,strong)UIImageView *checkboxImageView;
@property (nonatomic,strong)UIImage *uncheckImage;
@property (nonatomic,strong)UIImage *checkImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,assign)BOOL isChecked;

- (id)initWithUncheckImage:(UIImage *)aUncheckImage
                checkImage:(UIImage *)aCheckImage
           reuseIdentifier:(NSString *)aIdentifier;
@end