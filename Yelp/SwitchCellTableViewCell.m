//
//  SwitchCellTableViewCell.m
//  Yelp
//
//  Created by Puneet Makkar on 9/17/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SwitchCellTableViewCell.h"

@interface SwitchCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

- (IBAction)switchValueChanged:(id)sender;

@end

@implementation SwitchCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) setToggleInteraction:(BOOL) isEnabled {
    [self.toggleSwitch setUserInteractionEnabled:isEnabled];
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate switchCell:self didUpdateValue:self.toggleSwitch.on];
}


- (void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.toggleSwitch setOn:on animated:animated];
}

@end