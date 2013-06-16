//
//  LoginController.m
//  BNS
//
//  Created by chenghaojun on 7/16/2011.
//  Copyright 2011 深圳趋势互联科技有限公司. All rights reserved.
//

#import "LoginController.h"
#import "CHKeychain.h"


@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// 默认记住密码
	rememberUsernamePassword = YES;
	
	// 设置记住密码的图片
	[btnRemeberUsernamePassword setBackgroundImage:[UIImage imageNamed:@"checkbox_nor.png"] forState:UIControlStateNormal];
	[btnRemeberUsernamePassword setBackgroundImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
	[btnRemeberUsernamePassword setBackgroundImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateHighlighted];
	btnRemeberUsernamePassword.adjustsImageWhenHighlighted = YES;
	btnRemeberUsernamePassword.selected = rememberUsernamePassword;
	
	// 注册输入框的返回键值（蓝色按钮的类型）
	txtfldUsername.returnKeyType = UIReturnKeyNext;
	txtfldPassword.returnKeyType = UIReturnKeyGo;
	txtfldUsername.delegate = self;
	txtfldPassword.delegate = self;
	[txtfldPassword setSecureTextEntry:YES];
	
	NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[CHKeychain load:KEY_USERNAME_PASSWORD];
	txtfldUsername.text = [usernamepasswordKVPairs objectForKey:KEY_USERNAME];
	txtfldPassword.text = [usernamepasswordKVPairs objectForKey:KEY_PASSWORD];
	
	// 注册键盘事件监听器，键盘消失和键盘显示
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];	
}


#pragma mark -
#pragma mark 滚动scrollview 使被隐藏的textfield显示在屏幕正确的位置（软键盘的上方）
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
	NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrlviewLogin.contentInset = contentInsets;
    scrlviewLogin.scrollIndicatorInsets = contentInsets;
	
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
	// 输入项区域被认为定高
	CGPoint activeFieldRect = activeField.frame.origin;
	activeFieldRect.y += 80;
    if (!CGRectContainsPoint(aRect, activeFieldRect) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeFieldRect.y-kbSize.height);
        [scrlviewLogin setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrlviewLogin.contentInset = contentInsets;
    scrlviewLogin.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	switch (textField.returnKeyType) {
		case UIReturnKeyNext:
			[txtfldPassword becomeFirstResponder];
			break;
		case UIReturnKeyGo:
			[textField resignFirstResponder];
			[self login:btnLogin];
			break;
		default:
			break;
	}
	return YES;
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark 委托 是否成功注册的委托方法，注册之后不管是否成功都会调用此方法
- (void) recipeRegisterController:(UIViewController *) registerController result:(RegisterResult *)registerResult {
	if (registerResult.isSuc) {
		NSLog(@"register sucess.");
	} else {
		NSLog(@"register failed, message:%@.", registerResult.message);
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark view 点击事件
-(IBAction) tab2Register: (id) sender {
	RegisterController *registerController = [[RegisterController alloc] initWithNibName:nil bundle:nil];
	registerController.delegate = self;
	[self presentModalViewController:registerController animated:YES];
	[registerController release];
}

-(IBAction) login: (id) sender {
	NSLog(@"in login.");
	if([txtfldUsername.text isEqualToString:@""]){
		[[iToast makeText:@"请输入手机号码"] show];
		return;
	}
	if([txtfldPassword.text isEqualToString:@""]){
		[[iToast makeText:@"请输入密码"] show];
		return;
	}
	CHStatusBar *statusBar = [[CHStatusBar alloc] initWithFrame: CGRectZero];
	[statusBar showWithStatusMessage:@"正在提交信息"];
	
	// TODO 登录成功之后记录密码
	if (rememberUsernamePassword) {
		NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
		[usernamepasswordKVPairs setObject:txtfldUsername.text forKey:KEY_USERNAME];
		[usernamepasswordKVPairs setObject:txtfldPassword.text forKey:KEY_PASSWORD];
		[CHKeychain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
	}else {
		[CHKeychain delete:KEY_USERNAME_PASSWORD];
	}
}

-(IBAction) remeberUsernamePassword: (id) sender {
	NSLog(@"in remeberUsernamePassword.");
	rememberUsernamePassword = (!rememberUsernamePassword);
    [btnRemeberUsernamePassword setSelected:rememberUsernamePassword];
}


#pragma mark -
- (void)dealloc {
	[scrlviewLogin release];
	[btnTab2Register release];
	[txtfldUsername release];
	[txtfldPassword release];
	[btnRemeberUsernamePassword release];
	[btnLogin release];
	[activeField release];
	
    [super dealloc];
}


@end
