//
//  MarketCell.m
//  ServerMarket
//
//  Created by Bischoff Tobias on 06.06.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "MarketCell.h"

@implementation MarketCell
@synthesize order_hd_label,order_cpu_label,order_ram_label,order_price_label,order_nextreduce_label,order_cpu_benchmark_label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
