//
//  NameEditorViewController.m
//  PhotoWheelPrototype
//
//  Created by Mark Nichols on 2/25/12.
//  Copyright (c) 2012 Mark H. Nichols. All rights reserved.
//

#import "NameEditorViewController.h"

@implementation NameEditorViewController

@synthesize nameTextField = _nameTextField;
@synthesize delegate = _delegate;
@synthesize indexPath = _indexPath;

- (id)initWithDefaultNib
{
    self = [super initWithNibName:@"NameEditorViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Action methods

- (IBAction)cancel:(id)sender
{
    id<NameEditorViewControllerDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(nameEditorViewControllerDidCancel:)]) {
        [delegate nameEditorViewControllerDidCancel:self];
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)done:(id)sender
{
    id<NameEditorViewControllerDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(nameEditorViewControllerDidFinish:)]) {
        [delegate nameEditorViewControllerDidFinish:self];
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end
