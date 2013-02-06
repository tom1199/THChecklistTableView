//
//  THChecklistItem.h
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THChecklistItem : NSObject
@property (nonatomic,weak)NSString *title;
@property (nonatomic,weak)NSString *subtitle;
@property (nonatomic,assign)BOOL isChecked;
@end
