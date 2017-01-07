//
//  XLLoginViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 17/1/5.
//  Copyright © 2017年 李保东. All rights reserved.
//

#import "XLLoginViewController.h"


@interface XLLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)  UITextField *usernameTextField;
@property (nonatomic, strong)  UITextField *passwordTextField;

@property (nonatomic, strong)  UIButton *registerBtn;
@property (nonatomic, strong)  UIButton *loginBtn;

@end

@implementation XLLoginViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.loginBtn];
    
    // 点击空白处隐藏键盘，停止编辑
    [self setupForDismissKeyboard];
    
    _usernameTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    NSString *username = [LZDataBaseTool lastLoginUsername];
    if (username && username.length > 0) {
        _usernameTextField.text = username;
    }
    
    self.title = NSLocalizedString(@"AppName", @"EaseMobDemo");

    
    
    //    _usernameTextField.text = @"h18";
    _usernameTextField.text = @"o22";
    //    _usernameTextField.text = @"g14";
    _passwordTextField.text = @"123456";
    
//    self.view.backgroundColor =[UIColor redColor];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat btnH =40 *kAppScale;
    CGFloat btnW =100 *kAppScale;
    CGFloat textFeildW =200 *kAppScale;
    CGFloat textFeildH =30 *kAppScale;
    CGFloat allViewX =SCREEN_WIDTH *0.5;
    CGFloat viewSpacing =10 *kAppScale;
    
    self.usernameTextField.center =CGPointMake(allViewX, 100*kAppScale);
    self.passwordTextField.center =CGPointMake(allViewX, CGRectGetMidY(self.usernameTextField.frame) +textFeildH +viewSpacing);
    
    self.registerBtn.center =CGPointMake(allViewX, CGRectGetMidY(self.passwordTextField.frame)+textFeildH +2*viewSpacing);
    self.loginBtn.center =CGPointMake(allViewX, CGRectGetMidY(self.registerBtn.frame) +btnH +viewSpacing);
    
    self.usernameTextField.bounds =CGRectMake(0, 0, textFeildW, textFeildH);
    self.passwordTextField.bounds =CGRectMake(0, 0, textFeildW, textFeildH);
    self.registerBtn.bounds =CGRectMake(0, 0, btnW, btnH);
    self.loginBtn.bounds =CGRectMake(0, 0, btnW, btnH);

    
    self.usernameTextField.backgroundColor =[UIColor lightGrayColor];
    self.passwordTextField.backgroundColor =[UIColor lightGrayColor];
    self.registerBtn.backgroundColor =[UIColor blueColor];
    self.loginBtn.backgroundColor =[UIColor blueColor];
}

#pragma mark - Private Methods

//判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    if (username.length == 0 || password.length == 0) {
        ret = YES;
        [EMAlertView showAlertWithTitle:NSLocalizedString(@"prompt", @"Prompt")
                                message:NSLocalizedString(@"login.inputNameAndPswd", @"Please enter username and password")
                        completionBlock:nil
                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                      otherButtonTitles:nil];
    }
    
    return ret;
}
#pragma mark - 继承父类
-(CMNavType)getNavType {
    return CMNavTypeNone;
}

#pragma mark - Action Methods
-(void)loginBtnClick:(UIButton *)btn {

    if (![self isEmpty]) {
        [self.view endEditing:YES];
        //支持是否为中文
        if ([self.usernameTextField.text isChinese]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"login.nameNotSupportZh", @"Name does not support Chinese")
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                  otherButtonTitles:nil];
            
            [alert show];
            
            return;
        }
        /*
         #if !TARGET_IPHONE_SIMULATOR
         //弹出提示
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"login.inputApnsNickname", @"Please enter nickname for apns") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
         [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
         UITextField *nameTextField = [alert textFieldAtIndex:0];
         nameTextField.text = self.usernameTextField.text;
         [alert show];
         #elif TARGET_IPHONE_SIMULATOR
         [self loginWithUsername:_usernameTextField.text password:_passwordTextField.text];
         #endif
         */
        [self loginWithUsername:_usernameTextField.text password:_passwordTextField.text];
    }
    
}


//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
    //异步登陆账号
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself hideHud];
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:NO];
                
                //获取数据库中数据
                [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    // iOS专用，数据迁移到SDK3.0
                    [[EMClient sharedClient] migrateDatabaseToLatestSDK];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 异步获取用户加入的群组信息
                        [[ChatDemoHelper shareHelper] asyncGroupFromServer];
                        // 异步获取所有的会话信息
                        [[ChatDemoHelper shareHelper] asyncConversationFromDB];
                        // 从服务器获取用户的推送属性
                        [[ChatDemoHelper shareHelper] asyncPushOptions];
                        [MBProgressHUD hideAllHUDsForView:weakself.view animated:YES];
                        //发送自动登陆状态通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                        
                        //保存最近一次登录用户名
                        [LZDataBaseTool saveLastLoginUsername];
                    });
                });
            } else {
                switch (error.code)
                {
                        //                    case EMErrorNotFound:
                        //                        TTAlertNoTitle(error.errorDescription);
                        //                        break;
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                        break;
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                        break;
                    case EMErrorUserAuthenticationFailed: //账号或密码错误的单独情况，就需要展示服务器返回的具体错误
                        TTAlertNoTitle(error.errorDescription);
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                        break;
                    case EMErrorServerServingForbidden:
                        TTAlertNoTitle(NSLocalizedString(@"servingIsBanned", @"Serving is banned"));
                        break;
                    default:
                        TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                        break;
                }
            }
        });
    });
}

-(void)registerBtnClick:(UIButton *)btn {
    if (![self isEmpty]) {
        //隐藏键盘
        [self.view endEditing:YES];
        //判断是否是中文，但不支持中英文混编
        if ([self.usernameTextField.text isChinese]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login.nameNotSupportZh", @"Name does not support Chinese")
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                                  otherButtonTitles:nil];
            
            [alert show];
            
            return;
        }
        [self showHudInView:self.view hint:NSLocalizedString(@"register.ongoing", @"Is to register...")];
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 注册的代码
            EMError *error = [[EMClient sharedClient] registerWithUsername:weakself.usernameTextField.text password:weakself.passwordTextField.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself hideHud];
                if (!error) { // 注册成功
                    TTAlertNoTitle(NSLocalizedString(@"register.success", @"Registered successfully, please log in"));
                }else{
                    switch (error.code) {
                        case EMErrorServerNotReachable:
                            TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                            break;
                        case EMErrorUserAlreadyExist:
                            TTAlertNoTitle(NSLocalizedString(@"register.repeat", @"You registered user already exists!"));
                            break;
                        case EMErrorNetworkUnavailable:
                            TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                            break;
                        case EMErrorServerTimeout:
                            TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                            break;
                        case EMErrorServerServingForbidden:
                            TTAlertNoTitle(NSLocalizedString(@"servingIsBanned", @"Serving is banned"));
                            break;
                        default:
                            TTAlertNoTitle(NSLocalizedString(@"register.fail", @"Registration failed"));
                            break;
                    }
                }
            });
        });
    }

}


#pragma mark - Setter & Getter
-(UITextField *)usernameTextField {
    if (!_usernameTextField) {
        _usernameTextField =[[UITextField alloc]init];
        _usernameTextField.placeholder =@"请输入账号";
        
    }
    return _usernameTextField;
}
-(UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField =[[UITextField alloc]init];
        _passwordTextField.placeholder =@"请输入密码";
    }
    return _passwordTextField;
}

-(UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
-(UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}


@end
