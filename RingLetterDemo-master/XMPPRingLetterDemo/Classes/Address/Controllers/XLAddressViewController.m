//
//  CMHomeViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "XLAddressViewController.h"
#import "AddFriendViewController.h"


@interface XLAddressViewController ()

@property(nonatomic,strong)NSArray *testArray;

@end

@implementation XLAddressViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor =[UIColor blueColor];
    self.testArray =@[@"QQ",@"爱心",@"爱心人物"];
    [self testNet];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addContactAction)];
    
    
    
    

    // Do any additional setup after loading the view.
}
#pragma mark - Action Methods
- (void)addContactAction
{
    AddFriendViewController *addController = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:addController animated:YES];
}
#pragma mark - Test

-(void)testNet {
    for (int index =0; index <3; index ++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.center =CGPointMake(100 , 200 *index +100);
        button.bounds =CGRectMake(0, 0, 120, 50);
        button.backgroundColor =[UIColor blackColor];
        [button setTitle:self.testArray[index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonQQClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag =index;
        [self.view addSubview:button];
    }
  
    
  
    
}
-(void)buttonQQClick:(UIButton *)btn {
    
    
    switch (btn.tag) {
        case 0:
            // 通过QQ号获得QQ昵称测试
            //[self testQQNet];
            DDLog( @"返回参数无法解析暂不测");
            break;
        case 1:
            // 获得爱心测试列表
            [self testDonationNet];
            break;
        case 2:
            // 获得爱心捐赠列表测试
            [self testPersonNet];
            break;
            
        default:
            break;
    }
    
}
 // 通过QQ号获得QQ昵称测试
-(void)testQQNet {
    // 参数初始化
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    NSDictionary *paramsDic =@{@"qq":@"1824496534"};
    
    // 参数包装
    model.appendUrl =kTestQQGetNickNameURL;
    model.paramDic =[paramsDic mutableCopy];
    // 返回数据处理
    model.callback =^(CMHttpResponseModel *result, NSError *error) {
        
        if (result.state ==CMReponseCodeState_Success) {// 成功,做自己的逻辑
            DDLog(@"%@",result.data);
            
        }else {// 失败,弹框提示
//            mAlertView(@"提示", result.alertMsg);
            [CMHttpStateTools showHtttpStateView:result.state];
            
            DDLog(@"%@",result.error);
        }
        
    };
    // 发送网络请求
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
    
    
}
-(void)testDonationNet {
    
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    
    model.appendUrl =kTestDonationGetListURL;
    model.callback =^(CMHttpResponseModel *result, NSError *error) {
        
        if (result.state ==CMReponseCodeState_Success) {// 成功,做自己的逻辑
            DDLog(@"%@",result.data);

        }else {// 失败,弹框提示
//            mAlertView(@"提示", result.alertMsg);
            [CMHttpStateTools showHtttpStateView:result.state];

            DDLog(@"%@",result.error);
        }
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
    
}
-(void)testPersonNet {
    
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    NSDictionary *paramsDic =@{@"pid":@(10)};
    
    model.appendUrl =kTestDonationGetPersonURL;
    model.paramDic =[paramsDic mutableCopy];
    model.callback =^(CMHttpResponseModel *result, NSError *error) {
        
        if (result.state ==CMReponseCodeState_Success) {// 成功,做自己的逻辑
            DDLog(@"%@",result.data);
        }else {// 失败,弹框提示
//            mAlertView(@"提示", result.alertMsg);
            [CMHttpStateTools showHtttpStateView:result.state];

            DDLog(@"%@",result.error);
        }
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
    
}
#pragma mark - 子类继承

-(CMNavType)getNavType {
    return CMNavTypeAll;
}


@end
