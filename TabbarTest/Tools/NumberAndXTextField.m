//
//  NumberAndXTextField.m
//  啊实打实大
//
//  Created by 赵旭东 on 2017/5/9.
//  Copyright © 2017年 Addict. All rights reserved.
//

#import "NumberAndXTextField.h"
#define XBUTTON_MODIFY_TAG 8
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

static CGFloat _keyboardHeight = 0;

@implementation NumberAndXTextField

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - textField delegate functions

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"keyboard begin edit");
    
    //choose which keyboard
    
    //delay some seconds because button appears after the keyboard, this method works but not well T_T
    [self performSelector:@selector(addXButtonToKeyboard) withObject:nil afterDelay:0.1];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //when the keyboard hide, remove the Xbutton
    [self removeXButtonFromKeyBoard];
}

#pragma mark - modify method:add button and callback

- (void)addXButtonToKeyboard{
    [self addXButtonToKeyboardWithSelector:@selector(onXButtonClicked)
                                 normalImg:[UIImage imageNamed:@"Xbutton_normal.png"]
                              highlightImg:[UIImage imageNamed:@"Xbutton_highlight.png"]];
}

- (void)addXButtonToKeyboardWithSelector:(SEL)button_callback normalImg:(UIImage *)normal_icon highlightImg:(UIImage *)highlight_icon{
    //create the XButton
    UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xButton.tag = XBUTTON_MODIFY_TAG;
    xButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/3-3, _keyboardHeight/4); //the half size of the original image
    xButton.adjustsImageWhenDisabled = NO;
    
    [xButton setImage:normal_icon forState:UIControlStateNormal];
    [xButton setImage:highlight_icon forState:UIControlStateHighlighted];
    [xButton addTarget:self action:button_callback forControlEvents:UIControlEventTouchUpInside];
    
    //add to keyboard
    NSInteger cnt = [[UIApplication sharedApplication] windows].count;
    UIWindow *keyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:cnt - 1];
    xButton.frame = CGRectMake(0, SCREEN_HEIGHT-_keyboardHeight/4+1, SCREEN_WIDTH/3-3, _keyboardHeight/4);
    [keyboardWindow addSubview:xButton];
    
}

//when XButton clicked, textField add 'X' char
- (void)onXButtonClicked{
    self.text = [self.text stringByAppendingString:@"X"];
}

//remove XButton from keyboard when the keyboard hide
- (void)removeXButtonFromKeyBoard{
    NSInteger cnt = [[UIApplication sharedApplication] windows].count;
    UIWindow *keyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:cnt - 1];
    [[keyboardWindow viewWithTag:XBUTTON_MODIFY_TAG] removeFromSuperview];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyboardHeight = keyboardRect.size.height;
}


@end
