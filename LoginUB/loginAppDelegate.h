//
//  loginAppDelegate.h
//  LoginUB
//
//  Created by Felix Kurniawan on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginAppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *cek;
    
}

extern NSString *const FBSessionStateChangedNotification;

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic)NSString *cek;

-(void)loginWithFacebook;
- (void)openSession;


@end
