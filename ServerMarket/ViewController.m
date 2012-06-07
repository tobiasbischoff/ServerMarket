//
//  ViewController.m
//  ServerMarket
//
//  Created by Bischoff Tobias on 04.06.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "ViewController.h"
#import "jsonData.h"
#import "MBProgressHUD.h"
#import "SVWebViewController.h"
#import "SSPullToRefresh.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize pullToRefreshView,loaded;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //create navbartitle with custom font
    UILabel * navtitle = [[UILabel alloc] initWithFrame:CGRectMake(00, 0, 320, 45)];
    navtitle.backgroundColor = [UIColor clearColor];
    navtitle.textColor = [UIColor whiteColor];
    navtitle.text = @"ServerMarket";
    [navtitle setTextAlignment:UITextAlignmentCenter];
    navtitle.font = [UIFont fontWithName:@"Billabong" size:28];
    self.navigationItem.titleView = navtitle;
    
    //init pulltorefresh stuff
    self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.tableView delegate:self];
    pullToRefreshView.contentView = [[SSPullToRefreshSimpleContentView alloc] initWithFrame:CGRectZero];
    
    //create notificationcenter object and listen for fail
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(fail:) name:@"fail" object:nil];

}

- (void)fail:(NSNotification *)note {
    //gets called on load error from jsondata via nc
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We couldn't load the Data from the Web! Please connect to the Internets - it also may be that heroku, apify or hetzner is down."  delegate:self cancelButtonTitle:@"Never mind" otherButtonTitles: nil];
    [alert show];

}

-(void)viewDidAppear:(BOOL)animated
{
    //if there is no data onscreen, get some
    if (!loaded) {
    loaded = TRUE;
    jsonData * jsd = [[jsonData alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        hetznerdata = [jsd getHetzner];
        [[self tableView] reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    }
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [hetznerdata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //tell custom cell high to the tableview
    return 84;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get current entry from data array
    NSDictionary * eintrag = [hetznerdata objectAtIndex:[indexPath row]];
    
    //create or fetch custom cell from nib
    static NSString *CellIdentifier = @"MarketCell";
    MarketCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MarketCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    //fill the labels
    cell.order_cpu_label.text = [eintrag objectForKey:@"order_cpu"];
    cell.order_cpu_benchmark_label.text = [eintrag objectForKey:@"order_cpu_benchmark"];
    cell.order_ram_label.text = [eintrag objectForKey:@"order_ram"];
    cell.order_hd_label.text = [eintrag objectForKey:@"order_hd"];
    cell.order_price_label.text = [eintrag objectForKey:@"order_price"];
    cell.order_nextreduce_label.text = [eintrag objectForKey:@"order_nextreduce"];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
   //user tapped a cell, launch the minibrowser
    SVWebViewController *bvc = [[SVWebViewController alloc] initWithAddress:@"https://robot.your-server.de/order/market"];
    [[self navigationController] pushViewController:bvc animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.pullToRefreshView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation = UIInterfaceOrientationPortrait);
}

- (void)refresh {
    //gets called by pulltorefresh
    
    [self.pullToRefreshView startLoading];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        jsonData * jsd = [[jsonData alloc] init];
        hetznerdata = [jsd getHetzner];
        [[self tableView] reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.pullToRefreshView finishLoading];
        });
    });


   
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self refresh];
}

@end
