//
//  FilterViewController.h
//  Yelp
//
//  Created by Puneet Makkar on 9/17/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

- (void)filtersViewController:(FilterViewController *)
filtersViewController didChangeFilters:(NSDictionary *)filters;

@end

@interface FilterViewController : UIViewController

@property (nonatomic,weak) id<FilterViewControllerDelegate>
    delegate;

@end
