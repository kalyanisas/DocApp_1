//
//  AutoSizeCell.m
//  roundedLabels
//
//  Created by Kalyani on 21/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "AutoSizeCell.h"

#import "AutoSizeCell.h"

@implementation AutoSizeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 0;
        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
      [self.textLabel sizeToFit ];
        
        
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.textLabel }]];
         [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[bodyLabel]-6-|" options:0 metrics:nil views:@{ @"bodyLabel": self.textLabel }]];
  
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
   self.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.textLabel.frame);
    
}

@end
