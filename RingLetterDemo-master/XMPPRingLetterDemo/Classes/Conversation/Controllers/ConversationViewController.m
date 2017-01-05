//
//  ConversationViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/12.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "ConversationViewController.h"
#import "EMSearchBar.h"

@interface ConversationViewController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource, UISearchBarDelegate>

@property (nonatomic, strong) EMSearchBar           *searchBar;

@end

@implementation ConversationViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showRefreshHeader =YES;
    self.delegate  =self;
    self.dataSource = self;
    
    [self tableViewDidTriggerHeaderRefresh];
    [self.view addSubview:self.searchBar];
    
    self.tableView.frame = CGRectMake(0, self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height);
    
    [self removeEmptyConversationsFromDB];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

#pragma mark - Provate Methods
- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations isDeleteMessages:YES completion:nil];
    }
}
#pragma mark - SubToFather
-(void)refresh
{
    [self refreshAndSortView];
}

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark -EaseConversationListViewControllerDataSource

-(id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController modelForConversation:(EMConversation *)conversation {
    DDLog(@"进入了conversationListViewController：方法");
    return nil;
}

#pragma mark - Setter & Getter
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
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
