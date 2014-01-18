//
//  MasterBalloonView.h
//  BalloonsMix
//
//  Created by Stephanie Ta on 19.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "BalloonView.h"

#import "IdeaView.h"

@interface MasterBalloonView : BalloonView

@property (nonatomic, strong) IdeaView *ideaViewOne;
@property (nonatomic, strong) IdeaView *ideaViewTwo;
@property (nonatomic, strong) IdeaView *ideaViewThree;

@end
