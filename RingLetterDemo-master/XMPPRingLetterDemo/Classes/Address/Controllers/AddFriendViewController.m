//
//  AddFriendViewController.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 17/1/9.
//  Copyright © 2017年 李保东. All rights reserved.
//

#import "AddFriendViewController.h"
#import "ApplyViewController.h"
#import "InvitationManager.h"


@interface AddFriendViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@end

@implementation AddFriendViewController

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.title = NSLocalizedString(@"friend.add", @"Add friend");
    self.view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    
    [self.view addSubview:self.headerView];
    
    self.dataSource = [NSMutableArray array];
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.headerView.frame)) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableView];
//    
//    UIView *footerView = [[UIView alloc] init];
//    footerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
//    self.tableView.tableFooterView = footerView;
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    searchButton.accessibilityIdentifier = @"search_contact";
    [searchButton setTitle:NSLocalizedString(@"search", @"Search") forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:32 / 255.0 green:134 / 255.0 blue:158 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:searchButton]];
    
    //    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    //    backButton.accessibilityIdentifier = @"back";
    //    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    //    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self.view addSubview:self.textField];
    // Do any additional setup after loading the view.
}

#pragma mark - Action Methods

- (void)searchAction
{
    [_textField resignFirstResponder];
    if(_textField.text.length > 0)
    {
#warning 由用户体系的用户，需要添加方法在已有的用户体系中查询符合填写内容的用户
#warning 以下代码为测试代码，默认用户体系中有一个符合要求的同名用户
        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
        if ([_textField.text isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notAddSelf", @"can't add yourself as a friend") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        //判断是否已发来申请
        NSArray *applyArray = [[ApplyViewController shareController] dataSource];
        if (applyArray && [applyArray count] > 0) {
            for (ApplyEntity *entity in applyArray) {
                ApplyStyle style = [entity.style intValue];
                BOOL isGroup = style == ApplyStyleFriend ? NO : YES;
                if (!isGroup && [entity.applicantUsername isEqualToString:_textField.text]) {
                    NSString *str = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatInvite", @"%@ have sent the application to you"), _textField.text];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:str delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    return;
                }
            }
        }
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:_textField.text];
//        [self.tableView reloadData];
    }
}



#pragma mark - UITableView Delegate

#pragma mark - Setter & Getter

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        _textField.accessibilityIdentifier = @"contact_name";
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = NSLocalizedString(@"friend.inputNameToSearch", @"input to find friends");
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        [_headerView addSubview:_textField];
    }
    
    return _headerView;
}

@end
