//
//  MyDataModalItem.h
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import "THChecklistItem.h"
@class MyDataModal;
@interface MyDataModalItem : THChecklistItem
@property (nonatomic,strong)MyDataModal *dataModal;
- (id)initWithDataModal:(MyDataModal *)aDataModal;

@end
