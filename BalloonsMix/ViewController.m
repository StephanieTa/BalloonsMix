//
//  ViewController.m
//  BalloonsMix
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "ViewController.h"

#import "AirTubeView.h"
#import "BalloonView.h"
#import "CloudView.h"
#import "IdeaView.h"


@interface ViewController ()

@property (nonatomic, strong) CloudView *cloudView;

@property (nonatomic, strong) AirPumpView *airPumpOne;
@property (nonatomic, strong) AirPumpView *airPumpTwo;
@property (nonatomic, strong) AirPumpView *airPumpThree;

@property (nonatomic, strong) AirTubeView *airTubeLeft;
@property (nonatomic, strong) AirTubeView *airTubeCenter;
@property (nonatomic, strong) AirTubeView *airTubeRight;

@property (nonatomic, strong) BalloonView *masterBalloonView;

@property (nonatomic, strong) NSLayoutConstraint *masterBalloonWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *masterBalloonHeightConstraint;

@property (nonatomic, strong) IdeaView *ideaViewOne;
@property (nonatomic, strong) IdeaView *ideaViewTwo;
@property (nonatomic, strong) IdeaView *ideaViewThree;

@property (nonatomic, strong) NSLayoutConstraint *ideaViewOnePositionCenterX;
@property (nonatomic, strong) NSLayoutConstraint *ideaViewOnePositionCenterY;
@property (nonatomic, strong) NSLayoutConstraint *ideaViewTwoPositionCenterX;
@property (nonatomic, strong) NSLayoutConstraint *ideaViewTwoPositionCenterY;
@property (nonatomic, strong) NSLayoutConstraint *ideaViewThreePositionCenterX;
@property (nonatomic, strong) NSLayoutConstraint *ideaViewThreePositionCenterY;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setNeedsUpdateConstraints];
    
    // Set up cloud view
    
    self.cloudView = [[CloudView alloc] init];
    self.cloudView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cloudView];
    [self.cloudView animateCloudView];
    
    // Set up ground view
    
    UIImageView *grasslandView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grassland.png"]];
    grasslandView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:grasslandView];
    
    // Set up masterBalloon view
    
    self.masterBalloonView = [[BalloonView alloc] init];
    self.masterBalloonView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.masterBalloonView setUpBalloonWithImage:[UIImage imageNamed:@"balloonYellow.png"]];
    [self.cloudView addSubview:self.masterBalloonView];
    
    self.ideaViewOne = [[IdeaView alloc] init];
    self.ideaViewOne.translatesAutoresizingMaskIntoConstraints = NO;
    [self.ideaViewOne.balloonView setUpBalloonWithImage:[UIImage imageNamed:@"purpleBalloon.png"]];
    [self.masterBalloonView addSubview:self.ideaViewOne];
    
    self.ideaViewTwo = [[IdeaView alloc] init];
    self.ideaViewTwo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.ideaViewTwo.balloonView setUpBalloonWithImage:[UIImage imageNamed:@"greenBalloon.png"]];
    [self.masterBalloonView addSubview:self.ideaViewTwo];
    
    self.ideaViewThree = [[IdeaView alloc] init];
    self.ideaViewThree.translatesAutoresizingMaskIntoConstraints = NO;
    [self.ideaViewThree.balloonView setUpBalloonWithImage:[UIImage imageNamed:@"blueBalloon.png"]];
    [self.masterBalloonView addSubview:self.ideaViewThree];
    
    // Set up air tubes
    
    self.airTubeLeft = [[AirTubeView alloc] init];
    self.airTubeLeft.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airTubeLeft drawAirTubeAtPosition:@"Left"];
    [self.view addSubview:self.airTubeLeft];
    
    self.airTubeCenter = [[AirTubeView alloc] init];
    self.airTubeCenter.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airTubeCenter drawAirTubeAtPosition:@"Center"];
    [self.view addSubview:self.airTubeCenter];
    
    self.airTubeRight = [[AirTubeView alloc] init];
    self.airTubeRight.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airTubeRight drawAirTubeAtPosition:@"Right"];
    [self.view addSubview:self.airTubeRight];
    
    // Set up air pumps
    
    self.airPumpOne = [[AirPumpView alloc] init];
    self.airPumpOne.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airPumpOne setUpAirPumpWithImage:[UIImage imageNamed:@"airPumpBottomPurple.png"]];
    self.airPumpOne.delegate = self;
    [self.view addSubview:self.airPumpOne];
    
    self.airPumpTwo = [[AirPumpView alloc] init];
    self.airPumpTwo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airPumpTwo setUpAirPumpWithImage:[UIImage imageNamed:@"airPumpBottomGreen.png"]];
    self.airPumpTwo.delegate = self;
    [self.view addSubview:self.airPumpTwo];
    
    self.airPumpThree = [[AirPumpView alloc] init];
    self.airPumpThree.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airPumpThree setUpAirPumpWithImage:[UIImage imageNamed:@"airPumpBottomBlue.png"]];
    self.airPumpThree.delegate = self;
    [self.view addSubview:self.airPumpThree];
    
    // Layout views
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_cloudView, grasslandView, _masterBalloonView, _airPumpOne, _airPumpTwo, _airPumpThree, _airTubeLeft, _airTubeCenter, _airTubeRight, _ideaViewOne, _ideaViewTwo, _ideaViewThree);
    
    // Background views
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cloudView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cloudView(200.0)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[grasslandView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[grasslandView]|" options:0 metrics:nil views:views]];
    
    // Master balloon view
    [self.cloudView addConstraint: [NSLayoutConstraint constraintWithItem:self.masterBalloonView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.cloudView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self.cloudView addConstraint:[NSLayoutConstraint constraintWithItem:self.masterBalloonView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.cloudView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-20.0f]];
    
    self.masterBalloonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.masterBalloonView
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.0f
                                                                      constant:50.0f];
    self.masterBalloonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.masterBalloonView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0f
                                                                       constant:50.0f];
    [self.cloudView addConstraints:@[self.masterBalloonWidthConstraint, self.masterBalloonHeightConstraint]];
    
    // Idea views / child balloon views
    self.ideaViewOnePositionCenterX = [NSLayoutConstraint constraintWithItem:self.ideaViewOne attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.masterBalloonView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:-self.masterBalloonWidthConstraint.constant/6.0f];
    self.ideaViewOnePositionCenterY = [NSLayoutConstraint constraintWithItem:self.ideaViewOne attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.masterBalloonView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:-self.masterBalloonHeightConstraint.constant/6.0f];
    
    self.ideaViewTwoPositionCenterX = [NSLayoutConstraint constraintWithItem:self.ideaViewTwo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.masterBalloonView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
    self.ideaViewTwoPositionCenterY = [NSLayoutConstraint constraintWithItem:self.ideaViewTwo attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.masterBalloonView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:self.masterBalloonHeightConstraint.constant/6.0f];
    
    self.ideaViewThreePositionCenterX = [NSLayoutConstraint constraintWithItem:self.ideaViewThree attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.masterBalloonView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:self.masterBalloonWidthConstraint.constant/6.0f];
    self.ideaViewThreePositionCenterY = [NSLayoutConstraint constraintWithItem:self.ideaViewThree attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.masterBalloonView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:-self.masterBalloonHeightConstraint.constant/6.0f];
    
    [self.masterBalloonView addConstraints:@[self.ideaViewOnePositionCenterX, self.ideaViewOnePositionCenterY, self.ideaViewTwoPositionCenterX, self.ideaViewTwoPositionCenterY, self.ideaViewThreePositionCenterX, self.ideaViewThreePositionCenterY]];
    
    [self.masterBalloonView addConstraint:[NSLayoutConstraint constraintWithItem:self.ideaViewOne attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:100.0f]];
    [self.masterBalloonView addConstraint:[NSLayoutConstraint constraintWithItem:self.ideaViewOne attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:100.0f]];
    
    [self.masterBalloonView addConstraint:[NSLayoutConstraint constraintWithItem:self.ideaViewTwo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:100.0f]];
    [self.masterBalloonView addConstraint:[NSLayoutConstraint constraintWithItem:self.ideaViewTwo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:100.0f]];

    [self.masterBalloonView addConstraint:[NSLayoutConstraint constraintWithItem:self.ideaViewThree attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:100.0f]];
    [self.masterBalloonView addConstraint:[NSLayoutConstraint constraintWithItem:self.ideaViewThree attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:100.0f]];
    
    // AirPumps
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-85.0-[_airPumpOne(40.0)]-120.0-[_airPumpTwo(_airPumpOne)]-160.0-[_airPumpThree(==_airPumpOne)]" options:(NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop) metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airPumpOne(70.0)]-18.0-|" options:0 metrics:nil views:views]];
    
    // AirTubes
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-65.0-[_airTubeLeft(210.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeLeft(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-225.0-[_airTubeCenter(125.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeCenter(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-290.0-[_airTubeRight(220.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeRight(115.0)]-22.0-|" options:0 metrics:nil views:views]];
}

#pragma mark - airPump delegate methods

- (void)didTapOnAirPump:(UIView *)airPumpView {
    
    // Add idea to balloons and update sizes
    
    void (^completionBlockA)(BOOL) = ^(BOOL finished) {
        CGPoint position = [self.ideaViewOne calculateNewIdeaPosition];
        [self.ideaViewOne drawDotAtPoint:position withImage:[UIImage imageNamed:@"dotPurple.png"]];
        [self updateConstraintsMasterBalloonViewsIdeaView:self.ideaViewOne];
    };
    
    void (^completionBlockB)(BOOL) = ^(BOOL finished) {
        CGPoint position = [self.ideaViewTwo calculateNewIdeaPosition];
        [self.ideaViewTwo drawDotAtPoint:position withImage:[UIImage imageNamed:@"dotGreen.png"]];
        [self updateConstraintsMasterBalloonViewsIdeaView:self.ideaViewTwo];
    };
    
    void (^completionBlockC)(BOOL) = ^(BOOL finished) {
        CGPoint position = [self.ideaViewThree calculateNewIdeaPosition];
        [self.ideaViewThree drawDotAtPoint:position withImage:[UIImage imageNamed:@"dotBlue.png"]];
        [self updateConstraintsMasterBalloonViewsIdeaView:self.ideaViewThree];
    };
    
    // Animate airTubes
    
    if ([airPumpView isEqual:self.airPumpOne]) {
        [self.airTubeLeft animateIdeaAlongAirTubeAtPosition:@"Left" completion:completionBlockA];
    }
    else if ([airPumpView isEqual:self.airPumpTwo]) {
        [self.airTubeCenter animateIdeaAlongAirTubeAtPosition:@"Center" completion:completionBlockB];
    }
    else if ([airPumpView isEqual:self.airPumpThree]) {
        [self.airTubeRight animateIdeaAlongAirTubeAtPosition:@"Right" completion:completionBlockC];
    }
}

#pragma mark - Private method

- (void)updateConstraintsMasterBalloonViewsIdeaView:(IdeaView *)ideaView {
    CGFloat childBalloonTopWidth = self.ideaViewOne.balloonWidthConstraint.constant + self.ideaViewThree.balloonWidthConstraint.constant;
    CGFloat childBalloonBottomWidth = self.ideaViewTwo.balloonWidthConstraint.constant;
    CGFloat childBalloonLeftHeight = self.ideaViewOne.balloonHeightConstraint.constant + self.ideaViewTwo.balloonHeightConstraint.constant;
    CGFloat childBalloonRightHeight = self.ideaViewThree.balloonHeightConstraint.constant + self.ideaViewTwo.balloonHeightConstraint.constant;
    CGFloat masterBalloonWidth = self.masterBalloonWidthConstraint.constant;
    CGFloat masterBalloonHeight = self.masterBalloonHeightConstraint.constant;
    
    // Update Size of masterBalloon
    
    if (childBalloonTopWidth + 20.0f >= masterBalloonWidth) {
        self.masterBalloonWidthConstraint.constant = childBalloonTopWidth + 30.0f;
    }
    if (childBalloonBottomWidth + 20.0f >= masterBalloonWidth) {
        self.masterBalloonWidthConstraint.constant = childBalloonBottomWidth + 30.0f;
    }
    if (childBalloonLeftHeight + 20.0f >= masterBalloonHeight) {
        self.masterBalloonHeightConstraint.constant = childBalloonLeftHeight + 30.0f;
    }
    if (childBalloonRightHeight + 20.0f >= masterBalloonHeight) {
        self.masterBalloonHeightConstraint.constant = childBalloonRightHeight + 30.0f;
    }
    
    // Update Position of child balloons
    
    self.ideaViewOnePositionCenterX.constant = -self.masterBalloonWidthConstraint.constant/6.0f;
    self.ideaViewOnePositionCenterY.constant = -self.masterBalloonHeightConstraint.constant/6.0f;
    
    self.ideaViewTwoPositionCenterY.constant = self.masterBalloonHeightConstraint.constant/6.0f;
    
    self.ideaViewThreePositionCenterX.constant = self.masterBalloonWidthConstraint.constant/6.0f;
    self.ideaViewThreePositionCenterY.constant = -self.masterBalloonHeightConstraint.constant/6.0f;
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
