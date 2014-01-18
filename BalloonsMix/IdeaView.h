//
//  IdeaView.h
//  BalloonsMix
//
//  Created by Stephanie Ta on 19.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BalloonView.h"


@interface IdeaView : UIView

@property (nonatomic, strong) BalloonView *balloonView;

@property (nonatomic, strong) NSLayoutConstraint *balloonWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *balloonHeightConstraint;

- (CGPoint)calculateNewIdeaPosition;
- (void)drawDotAtPoint:(CGPoint)point withImage:(UIImage *)image;

@end
