//
//  MarketCell.h
//  ServerMarket
//
//  Created by Bischoff Tobias on 06.06.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketCell : UITableViewCell
{
    IBOutlet UILabel * order_cpu_label;
    IBOutlet UILabel * order_cpu_benchmark_label;
    IBOutlet UILabel * order_ram_label;
    IBOutlet UILabel * order_hd_label;
    IBOutlet UILabel * order_price_label;
    IBOutlet UILabel * order_nextreduce_label;
}

@property (nonatomic, strong) UILabel * order_cpu_label;
@property (nonatomic, strong) UILabel * order_cpu_benchmark_label;
@property (nonatomic, strong) UILabel * order_ram_label;
@property (nonatomic, strong) UILabel * order_hd_label;
@property (nonatomic, strong) UILabel * order_price_label;
@property (nonatomic, strong) UILabel * order_nextreduce_label;

@end
