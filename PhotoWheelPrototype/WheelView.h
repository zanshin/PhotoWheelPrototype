//
//  WheelView.h
//  PhotoWheelPrototype
//
//  Created by Mark Nichols on 2/27/12.
//  Copyright (c) 2012 Mark H. Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WheelViewDataSource;
@class WheelViewCell;

@interface WheelView : UIView
@property (nonatomic, strong) IBOutlet id<WheelViewDataSource> dataSource;
@end

@protocol WheelViewDataSource <NSObject>
@required
- (NSInteger)wheelViewNumberOfCells:(WheelView *)wheelView;
- (WheelViewCell *)wheelView:(WheelView *)wheelView cellAtIndex:(NSInteger) index;
@end

@interface WheelViewCell : UIView
@end

