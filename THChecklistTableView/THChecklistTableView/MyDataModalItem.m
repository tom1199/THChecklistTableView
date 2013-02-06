//
//  MyDataModalItem.m
//  THChecklistTableView
//
//  Created by Tang Han on 3/2/13.
//  Copyright (c) 2013 Tang Han. All rights reserved.
//

#import "MyDataModalItem.h"
#import "MyDataModal.h"

@implementation MyDataModalItem
- (id)initWithDataModal:(MyDataModal *)aDataModal {
    self = [super init];
    if (self) {
        self.dataModal = aDataModal;
    }
    return self;
}
- (NSString *)title {
    return self.dataModal.name;
}
- (void)setTitle:(NSString *)title {
    self.dataModal.name = title;
}
- (NSString *)subtitle {
    return nil;
}
- (void)setSubtitle:(NSString *)subtitle {
    
}
- (BOOL)isChecked {
    return self.dataModal.hasAccomplished;
}
- (void)setIsChecked:(BOOL)isChecked {
    self.dataModal.hasAccomplished = isChecked;
}
@end
