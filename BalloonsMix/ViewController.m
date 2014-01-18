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
#import "MasterBalloonView.h"


@interface ViewController ()

@property (nonatomic, strong) AirPumpView *airPumpOne;
@property (nonatomic, strong) AirPumpView *airPumpTwo;
@property (nonatomic, strong) AirPumpView *airPumpThree;

@property (nonatomic, strong) AirTubeView *airTubeLeft;
@property (nonatomic, strong) AirTubeView *airTubeCenter;
@property (nonatomic, strong) AirTubeView *airTubeRight;

@property (nonatomic, strong) MasterBalloonView *masterBalloonView;
@property (nonatomic, strong) CloudView *cloudView;

@property (nonatomic, strong) NSLayoutConstraint *masterBallonPositionYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *masterBalloonWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *masterBalloonHeightConstraint;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up cloud view
    
    self.cloudView = [[CloudView alloc] init];
    self.cloudView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cloudView];
    [self.cloudView animateCloudView];
    
    // Set up ground view
    
    UIImageView *groundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenBG.png"]];
    groundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:groundView];
    
    // Set up masterBalloon view
    
    self.masterBalloonView = [[MasterBalloonView alloc] init];
    self.masterBalloonView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cloudView addSubview:self.masterBalloonView];
    
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
    self.airPumpOne.delegate = self;
    [self.view addSubview:self.airPumpOne];
    
    self.airPumpTwo = [[AirPumpView alloc] init];
    self.airPumpTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.airPumpTwo.delegate = self;
    [self.view addSubview:self.airPumpTwo];
    
    self.airPumpThree = [[AirPumpView alloc] init];
    self.airPumpThree.translatesAutoresizingMaskIntoConstraints = NO;
    self.airPumpThree.delegate = self;
    [self.view addSubview:self.airPumpThree];
    
    // Layout views
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_cloudView, groundView, _masterBalloonView, _airPumpOne, _airPumpTwo, _airPumpThree, _airTubeLeft, _airTubeCenter, _airTubeRight);
    
    // Background views
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cloudView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cloudView(200.0)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[groundView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[groundView]|" options:0 metrics:nil views:views]];
    
    // Master balloon view with child balloons
    [self.cloudView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.masterBalloonView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.cloudView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0f
                                   constant:0]];
    
    self.masterBalloonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.masterBalloonView
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.0f
                                                                      constant:20.0f];
    
    self.masterBalloonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.masterBalloonView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0f
                                                                       constant:20.0f];

    self.masterBallonPositionYConstraint = [NSLayoutConstraint constraintWithItem:self.masterBalloonView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.cloudView attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0f
                                                                     constant:-30.0f];
    [self.cloudView addConstraints:@[self.masterBalloonWidthConstraint, self.masterBalloonHeightConstraint, self.masterBallonPositionYConstraint]];

    
    // AirPumps
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40.0-[_airPumpOne(40.0)]-120.0-[_airPumpTwo(_airPumpOne)]-160.0-[_airPumpThree(==_airPumpOne)]" options:(NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop) metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airPumpOne(70.0)]-20.0-|" options:0 metrics:nil views:views]];
    
    // AirTubes
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20.0-[_airTubeLeft(210.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeLeft(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-180.0-[_airTubeCenter(125.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeCenter(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-245.0-[_airTubeRight(220.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeRight(115.0)]-22.0-|" options:0 metrics:nil views:views]];
}

#pragma mark - airPump delegate methods

- (void)didTapOnAirPump:(UIView *)airPumpView {
    
    void (^completionBlockA)(BOOL) = ^(BOOL finished) {
        CGPoint position = [self.masterBalloonView.ideaViewOne calculateNewIdeaPosition];
        [self.masterBalloonView.ideaViewOne drawDotAtPoint:position withImage:[UIImage imageNamed:@"blueDot.png"]];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self updateConstraintsMasterBalloonViewsIdeaView:self.masterBalloonView.ideaViewOne];
        }];
    };
    
    void (^completionBlockB)(BOOL) = ^(BOOL finished) {
        CGPoint position = [self.masterBalloonView.ideaViewTwo calculateNewIdeaPosition];
        [self.masterBalloonView.ideaViewTwo drawDotAtPoint:position withImage:[UIImage imageNamed:@"redDot.png"]];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self updateConstraintsMasterBalloonViewsIdeaView:self.masterBalloonView.ideaViewTwo];
        }];
    };
    
    void (^completionBlockC)(BOOL) = ^(BOOL finished) {
        CGPoint position = [self.masterBalloonView.ideaViewThree calculateNewIdeaPosition];
        [self.masterBalloonView.ideaViewThree drawDotAtPoint:position withImage:[UIImage imageNamed:@"greenDot.png"]];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self updateConstraintsMasterBalloonViewsIdeaView:self.masterBalloonView.ideaViewThree];
        }];
    };
    
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
    CGFloat childBalloonWidth = ideaView.balloonWidthConstraint.constant;
    CGFloat masterBalloonWidth = self.masterBalloonWidthConstraint.constant;
    if (childBalloonWidth > masterBalloonWidth) {
        self.masterBalloonWidthConstraint.constant = childBalloonWidth;
        self.masterBalloonHeightConstraint.constant = childBalloonWidth;
    }
}

@end
