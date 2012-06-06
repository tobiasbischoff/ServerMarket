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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel * navtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    navtitle.backgroundColor = [UIColor clearColor];
    navtitle.textColor = [UIColor whiteColor];
    navtitle.text = @"ServerMarket";
    [navtitle setTextAlignment:UITextAlignmentCenter];
    navtitle.font = [UIFont fontWithName:@"Billabong" size:28];
    self.navigationItem.titleView = navtitle;
    
	// [[self navigationItem] setTitle:@"Server Market"];
}

-(void)viewDidAppear:(BOOL)animated
{
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [hetznerdata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //nachsehen ob es eine reusable cell gibt
    UITableViewCell * cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    
    //gab es keine, machen wir eine
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
    }
    
    NSDictionary * eintrag = [hetznerdata objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[eintrag objectForKey:@"order_cpu"]];
    
    return cell;
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
