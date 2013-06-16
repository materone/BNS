//
//  main.m
//  BNS
//
//  Created by Chenghaojun on 7/16/2011.
//  Copyright 2011 深圳趋势互联科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSAppDelegate.h"

int main(int argc, char *argv[]) {
	NSLog(@"PREFS_MY_CONSTANT is:%@", PREFS_MY_CONSTANT);
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"BNSAppDelegate");
    [pool release];
    return retVal;
}
