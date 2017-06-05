

- (void)showMenu:(UIButton *)sender{
//添加选项集合
NSArray *menuItems =
@[

[KxMenuItem menuItem:@"ACTION MENU 1234456"
image:nil
target:nil
action:NULL],

[KxMenuItem menuItem:@"Share this"
image:[UIImage imageNamed:@"action_icon"]
target:self
action:@selector(pushMenuItem:)],

[KxMenuItem menuItem:@"Check this menu"
image:nil
target:self
action:@selector(pushMenuItem:)],

[KxMenuItem menuItem:@"Reload page"
image:[UIImage imageNamed:@"reload"]
target:self
action:@selector(pushMenuItem:)],

[KxMenuItem menuItem:@"Search"
image:[UIImage imageNamed:@"search_icon"]
target:self
action:@selector(pushMenuItem:)],

[KxMenuItem menuItem:@"Go home"
image:[UIImage imageNamed:@"home_icon"]
target:self
action:@selector(pushMenuItem:)],
];

//设置对应选项的style
KxMenuItem *first = menuItems[0];
first.foreColor = [UIColor blueColor];
first.alignment = NSTextAlignmentCenter;
//背景渐变色
KxMenu.tintColor = [UIColor redColor];

//展示菜单
[KxMenu showMenuInView:self.view
fromRect:sender.frame
menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
NSLog(@"%@", sender);
}
