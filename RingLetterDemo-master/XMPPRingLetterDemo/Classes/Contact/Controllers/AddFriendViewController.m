//
//  AddFriendViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/14.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendTableViewCell.h"

@interface AddFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)NSMutableArray *dataSourceArray;

@property(nonatomic,strong)UITextField *textFeild;



@end

@implementation AddFriendViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.headerView addSubview:self.textFeild];
    
    
    
    [self creatRightBarButtonItem];
    
    self.dataSourceArray =@[@"123",@"23"];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.headerView.frame =CGRectMake(0, 64, SCREEN_WIDTH, 60);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT -CGRectGetMaxY(self.headerView.frame));
    self.textFeild.frame =CGRectMake(10, 10, SCREEN_WIDTH - 20, 40);
    
    // 设置颜色调试
    self.headerView.backgroundColor =[UIColor yellowColor];
}
#pragma mark - Private Methods
-(void)creatRightBarButtonItem {
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(searchPeople:)];
    self.navigationItem.rightBarButtonItem =rightItem;
    
}
// 判断搜索的对象是否存在于本地好友列表中
-(BOOL)isMyFriendExits:(NSString *)searchText {
    NSArray *userList =[[EMClient sharedClient].contactManager getContacts];
    for (NSString *userName in userList) {
        if ([userName isEqualToString:searchText]) {
            return YES;
        }
    }
    return NO;
}
// 添加该好友的理由
-(void)showAddRequestReson:(NSIndexPath *)indexPath {
    UIAlertController *alerCon =[UIAlertController alertControllerWithTitle:@"提示" message:@"添加的理由：" preferredStyle:UIAlertControllerStyleAlert];
    [alerCon addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"输入添加的理由";
        textField.delegate =self;
    }];
    UIAlertAction *sendAction =[UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *messageText =alerCon.textFields[0];
        if (messageText.text.length ==0) {
            mAlertView(@"提示", @"请输入您的添加理由");
            return ;
        }else {
            EMError *error =[[EMClient sharedClient].contactManager addContact:self.dataSourceArray[indexPath.row] message:messageText.text];
            if (error) {
                [self showHint:@"发送添加好友请求失败!"];
            }else {
                [self showHint:@"发送添加好友请求成功!"];
            }
        }
        
    }];
    
    UIAlertAction *cancleAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alerCon addAction:sendAction];
    [alerCon addAction:cancleAction];
}

#pragma mark - Action Methods
-(void)searchPeople:(UIBarButtonItem *)item {
    [self.textFeild resignFirstResponder];
    if (self.textFeild.text.length ==0) {// 输入内容为空
        mAlertView(@"提示", @"请输入合适的内容");
        return;
        
    }else {
        NSString *currentUserName =[[EMClient sharedClient] currentUsername];
        if ([self.textFeild.text isEqualToString:currentUserName]) {// 输入的是自己的账号
            mAlertView(@"提示", @"您输入的是自己的账号，请重新输入");
            return;
        }else {// 输入的内容是否为曾经发送过的请求
//            NSArray *applyArray =[app]
//            return;
        }
        // 默认不是自己的账号且没有向对应的账号发送过请求的话，就直接支持添加
        [self.dataSourceArray removeAllObjects];
        [self.dataSourceArray addObject:self.textFeild.text];
        [self.tableView reloadData];
        
    }
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//  UITableViewCell *cell =  [tableView updateWithTableView:tableView];
    static NSString *cellId =@"AddFriendCellId";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.imageView.backgroundColor =[UIColor redColor];
    cell.textLabel.text =self.dataSourceArray[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self isMyFriendExits:self.dataSourceArray[indexPath.row]]) {
        mAlertView(@"提示", @"您要添加的好友已经存在");
        return;
    }
    [self showAddRequestReson:indexPath];
}

#pragma mark - UITextFeildDelegate

#pragma mark - Setter & Getter

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView =[[UITableView alloc]init];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle =UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray =[NSMutableArray array];
    }
    return _dataSourceArray;
}
-(UIView *)headerView {
    if (!_headerView) {
        _headerView =[[UIView alloc]init];
    }
    return _headerView;
}
-(UITextField *)textFeild {
    if (!_textFeild) {
        _textFeild =[[UITextField alloc]init];
        _textFeild.layer.borderColor =[UIColor lightGrayColor].CGColor;
        _textFeild.layer.borderWidth =0.5;
        _textFeild.layer.cornerRadius =5;
        _textFeild.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textFeild.leftViewMode = UITextFieldViewModeAlways;
        _textFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFeild.font = [UIFont systemFontOfSize:15.0];
        _textFeild.backgroundColor = [UIColor whiteColor];
        _textFeild.placeholder =@"输入要查找的好友";
        _textFeild.returnKeyType =UIReturnKeyDone;
        _textFeild.delegate =self;
        
    }
    return _textFeild;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
