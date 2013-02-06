//
//  NSMutableArray+ObjectMove.h
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ObjectMove)
- (void)moveObjectFromIndex:(NSUInteger)indexFrom toIndex:(NSUInteger)indexTo;
@end
