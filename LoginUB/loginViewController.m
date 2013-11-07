//
//  loginViewController.m
//  LoginUB
//
//  Created by Felix Kurniawan on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

#import "loginViewController.h"
#import "loginAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>


@implementation loginViewController
@synthesize user = _user;
@synthesize pass = _pass;
@synthesize dataLabel = _dataLabel;
@synthesize image1 = _image1;

- (IBAction)loginWithFB:(id)sender{
    loginAppDelegate *appDelegate = (loginAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate openSession];
}

- (IBAction)loginPressed:(id)sender {
    [_pass resignFirstResponder];
    [_user resignFirstResponder];
    
    NSString *ur=[[NSString alloc]initWithFormat:@"http://kopisore.elasticbeanstalk.com/rest/todo/s.json?id=%@&password=%@", _user.text,_pass.text];
    //NSLog(ur);
    
    NSURL *verified=[[NSURL alloc]initWithString:ur];
    
    _dataLabel.text=@"Contacting Server...";
    _image1.alpha=1;
    
    dispatch_async(kBgQueue, ^{ NSData* data = [NSData dataWithContentsOfURL: verified];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];     
    });
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData
                          options:kNilOptions 
                          error:&error];
    
    if(json!=NULL) {
        
        NSDictionary* users = [json objectForKey:@"user"];
        
        
        NSString* name = [users objectForKey:@"name"];
        loginAppDelegate *appDelegate = (loginAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.cek=[NSString stringWithFormat:@"Hello, %@", name];
        
        
        _dataLabel.text = [NSString stringWithFormat:@"Hello, %@", name];
        _image1.alpha=0;
        
        [self performSegueWithIdentifier: @"trans" sender: self];
        
    } else {
        _dataLabel.text = [NSString stringWithFormat:@"Wrong Login"];
        _image1.alpha=0;
        
    }
    
}

- (void)doSegue  {
    [self performSegueWithIdentifier: @"trans" sender: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateChanged:) name:FBSessionStateChangedNotification object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self performSegueWithIdentifier: @"trans" sender: self];
    } else {
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _user.text=@"";
    _pass.text=@"";
    _dataLabel.text=@"";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
