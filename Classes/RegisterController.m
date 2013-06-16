//
//  RegisterController.m
//  BNS
//
//  Created by Chenghaojun on 7/16/2011.
//  Copyright 2011 深圳趋势互联科技有限公司. All rights reserved.
//

#import "RegisterController.h"


@implementation RegisterResult

@synthesize username;
@synthesize password;
@synthesize isSuc;
@synthesize message;

@end


@implementation RegisterController


@synthesize delegate;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	txtfldUsername.returnKeyType = UIReturnKeyNext;
	txtfldPassword.returnKeyType = UIReturnKeyNext;
	txtfldPasswordRepeat.returnKeyType = UIReturnKeyGo;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark view 点击事件
-(IBAction) doTab2Login: (id) sender {
	RegisterResult *registerResult = [[RegisterResult alloc] init];
	registerResult.isSuc = NO;
	registerResult.message = @"没有进行注册操作";

	[self.delegate recipeRegisterController:self result:registerResult];
	[registerResult release];
}

-(IBAction) doRegister: (id) sender {
	//如果注册成功，dissmiss model view and refresh parent.
	RegisterResult *registerResult = [[RegisterResult alloc] init];
	registerResult.isSuc = YES;
	[self.delegate recipeRegisterController:self result:registerResult];
	[registerResult release];
}


@end
