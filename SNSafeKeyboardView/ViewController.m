//
//  ViewController.m
//  SNSafeKeyboardView
//
//  Created by bfec on 16/4/1.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "ViewController.h"
#import "SafeKeyboardView.h"

@interface ViewController ()<UITextFieldDelegate,SafeKeyboardViewDelegate>

@property (nonatomic,weak) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    textField.frame = CGRectMake(100, 100, self.view.frame.size.width - 200, 50);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    self.textField = textField;
    
    
    
    
    
    
    
    
    
    
    //    SafeKeyboardView *keyBoardView = [[SafeKeyboardView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 260, self.view.frame.size.width, 260)];
    //    keyBoardView.delegate = self;
    //    [self.view addSubview:keyBoardView];
    ////    self.view.backgroundColor = [UIColor blackColor];
    //    textField.inputView = keyBoardView;
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    SafeKeyboardView *keyBoardView = [SafeKeyboardView show];
    keyBoardView.delegate = self;
    self.textField.inputView = keyBoardView;
}

#pragma mark - SafeKeyboardViewDelegate
- (void)safeKeyboardView:(SafeKeyboardView *)keyView andDidSelectNum:(NSInteger)num isCancel:(BOOL)cancel
{
    if (cancel)
    {
        NSLog(@"cancel");
        NSString *textStr = self.textField.text;
        if ([textStr isEqualToString:@""] || textStr == nil) return;
        textStr = [textStr substringToIndex:textStr.length - 1];
        self.textField.text = textStr;
    }
    else
    {
        NSLog(@"%ld",(long)num);
        NSString *textStr = self.textField.text == nil ? @"" : self.textField.text;
        textStr = [textStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)num]];
        self.textField.text = textStr;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    
    srand((unsigned)time(0));
    int i = rand() % 5;
    NSLog(@"%d",i);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
