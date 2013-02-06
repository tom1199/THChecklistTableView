//
//  MyDataModal.h
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataModal : NSObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)float price;
@property (nonatomic,assign)unsigned int rating;
@property (nonatomic,assign)BOOL hasAccomplished;

@end
