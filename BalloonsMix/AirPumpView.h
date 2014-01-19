//
//  AirPumpView.h
//  BalloonsMix
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirPumpViewDelegate;

@interface AirPumpView : UIView

@property (nonatomic, weak) id <AirPumpViewDelegate> delegate;

- (void)setUpAirPumpWithImage:(UIImage *)airPumpImage;

@end

@protocol AirPumpViewDelegate <NSObject>

- (void)didTapOnAirPump:(UIView *)airPumpView;

@end
