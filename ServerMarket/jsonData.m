//
//  jsonData.m
//  ServerMarket
//
//  Created by Bischoff Tobias on 05.06.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "jsonData.h"


@implementation jsonData

- (NSArray *)getHetzner
{
    NSURL * url = [NSURL URLWithString:@"http://apify.heroku.com/api/hetznermarket.json"];
    NSData * webdata = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    NSMutableArray * json = [[NSMutableArray alloc] init ];
    
    if (webdata) {
                        json = [NSJSONSerialization 
                          JSONObjectWithData:webdata 
                          
                          options:kNilOptions 
                          error:&error];
    } else {
        NSMutableArray * data = [[NSMutableArray alloc] init];
        
        NSNotification *note = [NSNotification notificationWithName:@"fail" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:note];
        
        return data;
    }
    
    if (!error) {
        NSMutableArray * data = [[NSMutableArray alloc] initWithArray:json];
        [data removeObjectAtIndex:0];
        [data removeObjectAtIndex:0];
        
        return data;
        
    } else {
        NSMutableArray * data = [[NSMutableArray alloc] init];
        
        NSNotification *note = [NSNotification notificationWithName:@"fail" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:note];
        
        return data;
    }
    
  
}

@end
