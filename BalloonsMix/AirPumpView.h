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

@property (nonatomic) NSString *identification;
@property (nonatomic, weak) id <AirPumpViewDelegate> delegate;

- (void)setUpAirPumpWithID:(NSString *)identification andImage:(UIImage *)airPumpImage;

@end

@protocol AirPumpViewDelegate <NSObject>

- (void)didTapOnAirPump:(UIView *)airPumpView;

@end
