//
//  THChecklistItem.m
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import "THChecklistItem.h"
@implementation THChecklistItem
-(id)init {
    if ([self isMemberOfClass:[THChecklistItem class]]) {
        @throw [NSException exceptionWithName:@"THChecklistItem Invalid Instantiation"
                                       reason:@"You must subclass THChecklistItem and provide the content to display."
                                     userInfo:nil];
    }
    return [super init];
}
- (NSString *)title {
    NSAssert(0, @"THChecklistItem: method must be implement in subclass");
    return nil;
}
- (void)setTitle:(NSString *)title {
    NSAssert(0, @"THChecklistItem: method must be implement in subclass");
    //Abstract to modify your data modal here
    
}
- (BOOL)isIsChecked {
    NSAssert(0, @"THChecklistItem: method must be implement in subclass");
    return NO;
}
- (void)setIsChecked:(BOOL)isChecked {
    NSAssert(0, @"THChecklistItem: method must be implement in subclass");
    //Abstract to modify your data modal here

}
@end
