//
//  XDTabBar.h
//  TabbarTest
//
//  Created by 赵旭东 on 2016/12/29.
//  Copyright © 2016年 赵旭东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDTabBar;

@protocol DidSelectedPlusButtonDelegate <NSObject>

-(void)didSelectedPlusButton:(XDTabBar *)tabbar;

@end

@interface XDTabBar : UITabBar

@property (nonatomic,assign)id <DidSelectedPlusButtonDelegate> Delegate;

+(instancetype)tabBar;

@end
