//
//  SafeKeyboardView.m
//  TestBySunny
//
//  Created by bfec on 16/4/1.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "SafeKeyboardView.h"

@implementation SafeKeyboardView

+ (id)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    SafeKeyboardView *keyboardView = [[SafeKeyboardView alloc] initWithFrame:CGRectMake(0, keyWindow.frame.size.height - 260, keyWindow.frame.size.width, 260)];
    [keyWindow addSubview:keyboardView];
    return keyboardView;
}

- (id)init
{
    if (self = [super init])
    {
        [self commitInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commitInit];
    }
    return self;
}

- (void)commitInit
{
    //logoView
    UIButton *logoView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:logoView];
    logoView.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    logoView.backgroundColor = [UIColor whiteColor];
    [logoView setImage:[UIImage imageNamed:@"icon-jp-safe"] forState:UIControlStateNormal];
    [logoView setTitleColor:[UIColor colorWithWhite:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    [logoView setTitle:@"我的钱包" forState:UIControlStateNormal];
    logoView.titleLabel.font = [UIFont systemFontOfSize:14.0];
    logoView.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
    //keyBoardView
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",
                           @"6",@"7",@"8",@"9",@"0"]];
    
    
    

    //Begin  添加混淆计算
    NSMutableArray *mixArray = [NSMutableArray array];
    for (NSInteger n = [tempArray count]; n > 0; n--)
    {
//        srandom((unsigned)time(0));
//        int randomInt = (int)(rand() / (float)RAND_MAX * n);
        int randomInt = arc4random() % n;
        [mixArray addObject:tempArray[randomInt]];
        [tempArray removeObjectAtIndex:randomInt];
    }
    //End  添加混淆计算
    
    
    
    for (int i = 0 ; i < 12; i++)
    {
        UIButton *numBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:numBt];
        
        NSInteger column = 3;
        
        CGFloat w = self.bounds.size.width / 3;
        CGFloat h = 55;
        CGFloat x = (i % column) * w;
        CGFloat y = (i / column) * h + 40;
        
        numBt.frame = CGRectMake(x, y, w, h);
        [numBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        numBt.titleLabel.font = [UIFont systemFontOfSize:27.0];
        
       
        if (i == 9 || i == 11)
        {
            numBt.tag = i + 1;
            [numBt setBackgroundColor:[UIColor colorWithWhite:237/255.0 alpha:1.0]];
            if (i == 11)
                [numBt setImage:[UIImage imageNamed:@"icon-jp-close"] forState:UIControlStateNormal];
        }
        else
        {
            if (i == 10)
            {
                numBt.tag = [mixArray[i - 1] integerValue];
                [numBt setTitle:mixArray[i - 1] forState:UIControlStateNormal];
                [numBt setTitle:mixArray[i - 1] forState:UIControlStateHighlighted];
            }
            else
            {
                numBt.tag = [mixArray[i] integerValue];
                [numBt setTitle:mixArray[i] forState:UIControlStateNormal];
                [numBt setTitle:mixArray[i] forState:UIControlStateHighlighted];
            }
            [numBt setBackgroundColor:[UIColor whiteColor]];
        }
//        else if (i == 10)
//        {
//            [numBt setTitle:tempArray[i - 1] forState:UIControlStateNormal];
//            [numBt setTitle:tempArray[i - 1] forState:UIControlStateHighlighted];
//            [numBt setBackgroundColor:[UIColor whiteColor]];
//            numBt.tag = 0;
//        }
//        else
//        {
//            [numBt setTitle:tempArray[i] forState:UIControlStateNormal];
//            [numBt setTitle:tempArray[i] forState:UIControlStateHighlighted];
//            [numBt setBackgroundColor:[UIColor whiteColor]];
//        }
        
        [numBt addTarget:self action:@selector(numBtTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    //partLine
    UILabel *verticalPartLine = [[UILabel alloc] init];
    [self addSubview:verticalPartLine];
    verticalPartLine.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    verticalPartLine.backgroundColor = [UIColor colorWithWhite:217/255.0 alpha:1.0];
    
    
    for (int i = 1; i < 3; i++)
    {
        UILabel *verticalPartLine = [[UILabel alloc] init];
        [self addSubview:verticalPartLine];
        verticalPartLine.frame = CGRectMake(self.frame.size.width / 3 * i, CGRectGetMaxY(logoView.frame), 0.5, self.frame.size.height - 40);
        verticalPartLine.backgroundColor = [UIColor colorWithWhite:217/255.0 alpha:1.0];
    }
    
    for (int i = 0; i < 4; i++)
    {
        UILabel *horiztalPartLine = [[UILabel alloc] init];
        [self addSubview:horiztalPartLine];
        horiztalPartLine.frame = CGRectMake(0, ( self.frame.size.height - 40 ) / 4 * i + 40, self.frame.size.width, 0.5);
        horiztalPartLine.backgroundColor = [UIColor colorWithWhite:217/255.0 alpha:1.0];
    }
    
    
}

- (void)numBtTouch:(UIButton *)bt
{
    if (bt.tag == 10) return;
    if ([self.delegate respondsToSelector:@selector(safeKeyboardView:andDidSelectNum:isCancel:)])
    {
        if (bt.tag == 12)
            [self.delegate safeKeyboardView:self andDidSelectNum:bt.tag isCancel:YES];
        else
            [self.delegate safeKeyboardView:self andDidSelectNum:bt.tag isCancel:NO];
    }
}

@end
