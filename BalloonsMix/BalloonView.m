//
//  BalloonView.m
//  BalloonsMix
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "BalloonView.h"

@interface BalloonView ()

@property (nonatomic, strong) UIImageView *gasImageView;
- (void)initBallon;

@end

@implementation BalloonView

- (void)initBallon {
    self.gasImageView = [[UIImageView alloc] init];
    self.gasImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.gasImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_gasImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_gasImageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_gasImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_gasImageView)]];
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

- (void)setUpGasBackgroundWithImage:(UIImage *)gasImage {
    [self.gasImageView setImage:gasImage];
}

@end
