//
//  NameEditorViewController.h
//  PhotoWheelPrototype
//
//  Created by Mark Nichols on 2/25/12.
//  Copyright (c) 2012 Mark H. Nichols. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NameEditorViewControllerDelegate;

@interface NameEditorViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) id<NameEditorViewControllerDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

-(id)initWithDefaultNib;

@end

@protocol NameEditorViewControllerDelegate <NSObject>
@optional
- (void)nameEditorViewControllerDidFinish:(NameEditorViewController *)controller;
- (void)nameEditorViewControllerDidCancel:(NameEditorViewController *)controller;
@end
