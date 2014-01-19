//
//  BalloonView.m
//  BalloonsMix
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "BalloonView.h"

@interface BalloonView ()

@property (nonatomic, strong) UIImageView *balloonImageView;
- (void)initBallon;

@end

@implementation BalloonView

- (void)initBallon {
    self.balloonImageView = [[UIImageView alloc] init];
    self.balloonImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.balloonImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_balloonImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_balloonImageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_balloonImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_balloonImageView)]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initBallon];
        self.backgroundColor = nil;
        self.opaque = NO;
    }
    return self;
}

- (void)setUpBalloonWithImage:(UIImage *)balloonImage {
    [self.balloonImageView setImage:balloonImage];
}

@end
