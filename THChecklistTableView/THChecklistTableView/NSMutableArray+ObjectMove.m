//
//  NSMutableArray+ObjectMove.m
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import "NSMutableArray+ObjectMove.h"

@implementation NSMutableArray (ObjectMove)
- (void)moveObjectFromIndex:(NSUInteger)indexFrom toIndex:(NSUInteger)indexTo {
    if (indexTo != indexFrom) {
        id objectToMove = [self objectAtIndex:indexFrom];
        [self removeObjectAtIndex:indexFrom];
        if (indexTo >= [self count]) {
            [self addObject:objectToMove];
        }else {
            [self insertObject:objectToMove atIndex:indexTo];
        }
    }
}
@end
