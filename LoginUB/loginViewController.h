//
//  loginViewController.h
//  LoginUB
//
//  Created by Felix Kurniawan on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UITextField *user;
@property (strong, nonatomic) IBOutlet UITextField *pass;



-(IBAction)loginPressed:(id)sender;
-(IBAction)loginWithFB:(id)sender;

-(void)doSegue;

@end
