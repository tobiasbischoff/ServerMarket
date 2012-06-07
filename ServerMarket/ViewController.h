//
//  ViewController.h
//  ServerMarket
//
//  Created by Bischoff Tobias on 04.06.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketCell.h"
#import "SSPullToRefresh.h"

@interface ViewController : UITableViewController <UITableViewDataSource, SSPullToRefreshViewDelegate>
{
    NSMutableArray *hetznerdata;

    

}

- (void)refresh;
- (void)fail:(NSNotification *)note;

@property (nonatomic, strong) SSPullToRefreshView * pullToRefreshView;
@property (nonatomic) BOOL loaded;
@end
