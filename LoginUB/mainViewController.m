//
//  mainViewController.m
//  LoginUB
//
//  Created by Felix Kurniawan on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mainViewController.h"
#import "loginViewController.h"
#import "loginAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>



@implementation mainViewController
@synthesize label1=_label1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)doLogout {
    [FBSession.activeSession closeAndClearTokenInformation];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)populateUserDetails 
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, 
           NSDictionary<FBGraphUser> *user, 
           NSError *error) {
             if (!error) {
                 NSString *temp=[[NSString alloc]initWithFormat:@"Hello FBuser, %@",user.name];
                 _label1.text = temp;
                 //self.userProfileImage.profileID = user.id;
             }
         }];      
    }
}

-(void)viewWillAppear:(BOOL)animated {
    //logViewController* cek;
    //_label1.text=cek.user.text;
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    } else {

        loginAppDelegate *appDelegate = (loginAppDelegate *)[[UIApplication sharedApplication] delegate];
        _label1.text=appDelegate.cek;
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
