//
//  MasterViewController.m
//  PhotoWheelPrototype
//
//  Created by Mark Nichols on 2/25/12.
//  Copyright (c) 2012 Mark H. Nichols. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize data = _data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.title = NSLocalizedString(@"Photo Albums", @"Photo Albums title");
    
    // instantiate the data store
    [self setData:[[NSMutableOrderedSet alloc] init]];
    [[self data] addObject:@"A Sample Photo Album"];
    [[self data] addObject:@"Another Sample Album"];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                            inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionMiddle]; 
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                       target:self 
                                                       action:@selector(add:)];
    [[self navigationItem] setRightBarButtonItem:addButton];
    
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
}

- (void)add:(id)sender
{

    NameEditorViewController *newController = [[NameEditorViewController alloc] initWithDefaultNib];
    [newController setDelegate:self];
    [newController setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentModalViewController:newController animated:YES];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[self data] count];
    return count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // Display the detail disclosure button when the table is in edit mode
        [cell setEditingAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        
        // Allow reordering of cells
        [cell setShowsReorderControl:YES];
    }

    // Configure the cell.
    NSString *text = [[self data] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:text];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self data] removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
   
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NameEditorViewController *newController = [[NameEditorViewController alloc] initWithDefaultNib];
    [newController setDelegate:self];
    [newController setEditing:YES];
    [newController setIndexPath:indexPath];
    NSString *name = [[self data] objectAtIndex:[indexPath row]];
    [newController setDefaultNameText:name];
    [newController setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentModalViewController:newController animated:YES];
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[self data] exchangeObjectAtIndex:[fromIndexPath row]
                     withObjectAtIndex:[toIndexPath row]];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [[self data] objectAtIndex:[indexPath row]];
    [[self detailViewController] setDetailItem:name];
    
}

#pragma mark - NameEditorViewControllerDelegate

- (void) nameEditorViewControllerDidFinish:(NameEditorViewController *)controller
{
    NSString *newName = [[controller nameTextField] text];
    if (newName && [newName length] > 0 ) {
        if ([controller isEditing]) {
            [[self data] replaceObjectAtIndex:[[controller indexPath] row]
                                   withObject:newName];
        } else {
            [[self data] addObject:newName];
        }
        [[self tableView] reloadData];
    }
}

- (void) nameEditorViewControllerDidCancel:(NameEditorViewController *)controller
{
    NSLog(@"%s", __PRETTY_FUNCTION__);  
}
@end
