//
//  GroupCell.m
//  Yelp
//
//  Created by Puneet Makkar on 9/18/15.
//  Copyright © 2015 codepath. All rights reserved.
//


#import "GroupCell.h"

@implementation GroupCell

- initWithSectionLabel:(NSString*)sectionLabel rowLabels:(NSArray*)rowLabels yelpFilterName:(NSString*)filterName yelpFilterValues:(NSArray *)filterValues {
    self = [super init];
    if (self) {
        self.isExpanded = NO;
        self.sectionLabel = sectionLabel;
        self.rowLabels = rowLabels;
        self.yelpFilterName = filterName;
        self.selectedIndex = 0;
        self.filterValues = filterValues;
    }
    return self;
}

- (BOOL) isRowOn:(NSInteger)row {
    if (self.isExpanded) {
        return row == self.selectedIndex;
    } else {
        return YES;
    }
}

- (NSString*)labelForRow:(NSInteger) row {
    if (self.isExpanded) {
        return self.rowLabels[row];
    } else {
        return self.rowLabels[self.selectedIndex];
    }
}

- (NSInteger)numRows {
    if (self.isExpanded) {
        return self.rowLabels.count;
    } else {
        return 1;
    }
}

@end
