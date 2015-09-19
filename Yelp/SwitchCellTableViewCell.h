//
//  SwitchCellTableViewCell.h
//  Yelp
//
//  Created by Puneet Makkar on 9/17/15.
//  Copyright © 2015 codepath. All rights reserved.
//


#import <UIKit/UIKit.h>

@class SwitchCellTableViewCell;

@protocol SwitchCellTableViewCellDelegate <NSObject>

- (void) switchCell:(SwitchCellTableViewCell *)cell didUpdateValue:(BOOL)value;
@end

@interface SwitchCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<SwitchCellTableViewCellDelegate> delegate;

//- (id) initWithLabel:(NSString*) titleLabel;
- (void) setOn:(BOOL)on animated:(BOOL)animated;
- (void) setToggleInteraction:(BOOL) isEnabled;

@end