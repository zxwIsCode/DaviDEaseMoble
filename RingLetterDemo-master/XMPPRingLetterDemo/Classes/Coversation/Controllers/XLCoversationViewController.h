//
//  CMCommondViewController.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMBaseViewController.h"

@interface XLCoversationViewController : CMBaseViewController

- (void)refreshDataSource;

- (void)networkChanged:(EMConnectionState)connectionState;



@end
