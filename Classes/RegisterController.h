//
//  RegisterController.h
//  BNS
//
//  Created by Chenghaojun on 7/16/2011.
//  Copyright 2011 深圳趋势互联科技有限公司. All rights reserved.
//


//注册结果
@interface RegisterResult : NSObject {
	NSString *username;
	NSString *password;
	BOOL isSuc;
	NSString *message;
}


@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, retain) NSString *message;
@property(nonatomic) BOOL isSuc;


@end


//因为RegisterController 是model view，注册成功失败的信息通过协议进行传递
//调用方只需要实现 RegisterDelegate 即可
@protocol RegisterDelegate <NSObject> 
	- (void) recipeRegisterController:(UIViewController *) registerController result:(RegisterResult *)registerResult;
@end


//注册controller
@interface RegisterController : UIViewController {
	IBOutlet UIScrollView *scrlviewRegister;
	IBOutlet UIButton *btnTab2Login;
	IBOutlet UITextField *txtfldUsername;
	IBOutlet UITextField *txtfldPassword;
	IBOutlet UITextField *txtfldPasswordRepeat;
	IBOutlet UIButton *btnRegister;
	
	NSObject<RegisterDelegate> *delegate;
}


@property(nonatomic, retain) NSObject<RegisterDelegate> *delegate;


-(IBAction) doTab2Login: (id) sender;
-(IBAction) doRegister: (id) sender;


@end