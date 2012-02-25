//
//  MasterViewController.h
//  PhotoWheelPrototype
//
//  Created by Mark Nichols on 2/25/12.
//  Copyright (c) 2012 Mark H. Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableOrderedSet *data;

@end
