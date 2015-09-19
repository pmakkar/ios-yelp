 //
//  BusinessCellTableViewCell.m
//  Yelp
//
//  Created by Puneet Makkar on 9/17/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BusinessCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;


@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation BusinessCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLable.preferredMaxLayoutWidth = self.nameLable.frame.size.width;
    self.thumbImageView.layer.cornerRadius = 3;
    self.thumbImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setBusiness:(Business *)business {
    _business = business;
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:self.business.imageUrl]];
    self.nameLable.text = self.business.name;
    [self.ratingImageView setImageWithURL:[NSURL URLWithString:self.business.ratingImageUrl]];
    self.ratingLabel.text = [NSString stringWithFormat:@"%ld Reviews", self.business.numReviews];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi", self.business.distance];
    self.addressLabel.text = self.business.address;
    self.categoryLabel.text = self.business.categories;
}

-(void) layoutSubviews {
    self.nameLable.preferredMaxLayoutWidth = self.nameLable.frame.size.width;
    
}

@end
