#//
//  MasterBalloonView.m
//  BalloonsMix
//
//  Created by Stephanie Ta on 19.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "MasterBalloonView.h"

@interface MasterBalloonView ()

- (void)initMasterBalloonView;

@end


@implementation MasterBalloonView

- (void)initMasterBalloonView {
    
    // Set up idea view
    
    self.ideaViewOne = [[IdeaView alloc] init];
    self.ideaViewOne.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.ideaViewOne];
    
    self.ideaViewTwo = [[IdeaView alloc] init];
    self.ideaViewTwo.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.ideaViewTwo];
    
    self.ideaViewThree = [[IdeaView alloc] init];
    self.ideaViewThree.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.ideaViewThree];
    
    // Layout idea views
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_ideaViewOne, _ideaViewTwo, _ideaViewThree);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ideaViewOne][_ideaViewThree(==_ideaViewOne)]|" options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.ideaViewTwo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_ideaViewOne(==_ideaViewTwo)][_ideaViewTwo(==_ideaViewOne)]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_ideaViewThree(==_ideaViewTwo)][_ideaViewTwo(==_ideaViewThree)]|" options:0 metrics:nil views:views]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMasterBalloonView];
    }
    return self;
}

@end
