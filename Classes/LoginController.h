//
//  LoginController.h
//  BNS
//
//  Created by Chenghaojun on 7/16/2011.
//  Copyright 2011 深圳趋势互联科技有限公司. All rights reserved.
//


#import "RegisterController.h"
#import "iToast.h"
#import "CHStatusBar.h"

@interface LoginController : UIViewController <RegisterDelegate, UITextFieldDelegate> {
	IBOutlet UIScrollView *scrlviewLogin;
	IBOutlet UIButton *btnTab2Register;
	IBOutlet UITextField *txtfldUsername;
	IBOutlet UITextField *txtfldPassword;
	IBOutlet UIButton *btnRemeberUsernamePassword;
	IBOutlet UIButton *btnLogin;
	
	UITextField *activeField;
	//是否记住密码
	BOOL rememberUsernamePassword;
}

//tab：切换
-(IBAction) tab2Register: (id) sender;
-(IBAction) login: (id) sender;
-(IBAction) remeberUsernamePassword: (id) sender;


@end
