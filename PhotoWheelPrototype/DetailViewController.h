//
//  DetailViewController.h
//  PhotoWheelPrototype
//
//  Created by Mark Nichols on 2/25/12.
//  Copyright (c) 2012 Mark H. Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
