//
//  SafeKeyboardView.h
//  TestBySunny
//
//  Created by bfec on 16/4/1.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SafeKeyboardView;
@protocol SafeKeyboardViewDelegate <NSObject>

- (void)safeKeyboardView:(SafeKeyboardView *)keyView andDidSelectNum:(NSInteger)num isCancel:(BOOL)cancel;

@end

@interface SafeKeyboardView : UIView

@property (nonatomic,weak) id<SafeKeyboardViewDelegate> delegate;

+ (id)show;

@end
