//
//  THChecklistItemCell.m
//  THChecklistTableView
//
//  Created by Tang Han on 30/1/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import "THChecklistItemCell.h"
#import <QuartzCore/QuartzCore.h>

#define TITLE_LABEL_LEFT_MARGIN    0.0f
#define TITLE_LABEL_RIGHT_MARGIN    44.0f
#define CHECKBOX_RIGHT_MARGIN   0

static CGRect checkboxImageBoundMax = {0,0,44.0f,44.0f};
@interface THChecklistItemCellDefault()
@property (nonatomic,strong)UIView *maskView;
@end

@implementation THChecklistItemCellDefault

- (id)initWithUncheckImage:(UIImage *)aUncheckImage checkImage:(UIImage *)aCheckImage reuseIdentifier:(NSString *)aIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aIdentifier];
    if (self) {
        self.uncheckImage = aUncheckImage;
        self.checkImage = aCheckImage;
        
        //set UITableViewCell default textLabel to dummy string to aviod Delete button fade out issue when it exit edit mode
        self.textLabel.text = @"dummy";
        [self.textLabel setHidden:YES];
        
        //layout subview
        _checkboxImageView = [[UIImageView alloc]initWithImage:self.uncheckImage];
        _checkboxImageView.center = CGPointMake(checkboxImageBoundMax.size.width/2, checkboxImageBoundMax.size.height/2);
        _checkboxImageView.userInteractionEnabled = YES;
        
            //add tap gesture to image view
        UITapGestureRecognizer *tapGrgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchOnImageView:)];
        tapGrgr.numberOfTapsRequired = 1;
        [_checkboxImageView addGestureRecognizer:tapGrgr];
        [self.contentView addSubview:_checkboxImageView];   // add to content view so it will follow content view as it entering edit mode
        
        CGRect titleLabelRect = CGRectMake(checkboxImageBoundMax.size.width + TITLE_LABEL_LEFT_MARGIN,
                                           0,
                                           self.frame.size.width - checkboxImageBoundMax.size.width - TITLE_LABEL_LEFT_MARGIN - TITLE_LABEL_RIGHT_MARGIN,
                                           44.0f);
        _titleLabel = [[UILabel alloc]initWithFrame:titleLabelRect];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_titleLabel];
        
        //apply mask on top of the content to display
        CGRect maskFrame = self.bounds;
        maskFrame = CGRectInset(maskFrame, 5.0f, 5.0f);
        _maskView = [[UIView alloc]initWithFrame:maskFrame];
        _maskView.userInteractionEnabled = NO;
        [_maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
        [self.contentView addSubview:_maskView];
        [_maskView setHidden:YES];
        
        _isChecked = NO;
    }
    return self;
}
- (void)setIsChecked:(BOOL)isChecked {
    if (_isChecked != isChecked) {
        _isChecked = isChecked;
        
        //update UI
        if (_isChecked) {
            self.checkboxImageView.image = self.checkImage;
        }else {
            self.checkboxImageView.image = self.uncheckImage;
        }
    }
    
    if (isChecked == self.maskView.isHidden) {
        [self.maskView setHidden:!isChecked];
    }
}
- (void)toggleCheckBoxValue {
    if (_isChecked) {
        _isChecked = NO;
        self.checkboxImageView.image = self.uncheckImage;
        [self.maskView setHidden:YES];
        [self.delegate cell:self checkboxValueDidChangeWithValue:_isChecked];
    }else if (!_isChecked) {
        _isChecked = YES;
        self.checkboxImageView.image = self.checkImage;
        [self.maskView setHidden:NO];
        [self.delegate cell:self checkboxValueDidChangeWithValue:_isChecked];
    }
}

- (void)touchOnImageView:(id)sender {
    [self toggleCheckBoxValue];
}
@end
