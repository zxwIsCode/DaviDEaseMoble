//
//  ContactViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/12.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "ContactViewController.h"

#import "EMSearchBar.h"
#import "UserProfileManager.h"
#import "AddFriendViewController.h"


@interface ContactViewController ()

@property(nonatomic,strong)EMSearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *sectionTitles;
@property (strong, nonatomic) NSMutableArray *contactsSource;

@end

@implementation ContactViewController

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.showRefreshHeader =YES;
//    
//    _contactsSource = [NSMutableArray array];
//    _sectionTitles = [NSMutableArray array];
//    
//    self.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
//    [self.view addSubview:self.searchBar];
//    
//    self.tableView.frame = CGRectMake(0, self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height);
//    
//    // 环信UIdemo中有用到Parse, 加载用户好友个人信息
//    [[UserProfileManager sharedInstance] loadUserProfileInBackgroundWithBuddy:self.contactsSource saveToLoacal:YES completion:NULL];
    
    [self creatRightBarButtonItem];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self reloadApplyView];
}
#pragma mark - Private Methods

-(void)creatRightBarButtonItem {

    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addPeople:)];
    self.navigationItem.rightBarButtonItem =rightItem;
    
}
-(void)reloadApplyView {
    DDLog(@"收到一条添加好友的请求");
}
#pragma mark - Action Methods

-(void)addPeople:(UIBarButtonItem *)item {
    AddFriendViewController *addFriendVC =[[AddFriendViewController alloc]init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
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
