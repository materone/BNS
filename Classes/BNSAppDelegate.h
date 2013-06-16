//
//  BNSAppDelegate.h
//  BNS
//
//  Created by Chenghaojun on 7/16/2011.
//  Copyright 2011 深圳趋势互联科技有限公司. All rights reserved.
/*
defaults write com.apple.Xcode PBXCustomTemplateMacroDefinitions '{"ORGANIZATIONNAME" = "3gie.cn";}'
defaults write com.apple.Xcode ORGANIZATIONNAME "3gie.cn"
defaults write com.apple.Xcode FULLUSERNAME "Chenghaojun"
defaults write com.apple.Xcode PBXCustomTemplateMacroDefinitions '{FULLUSERNAME = "Chenghaojun" ; }'
*/


@interface BNSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) UIWindow *window;

@end

