//
//  UserViewController.h
//  Reminder
//
//  Created by Roberto on 3/13/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController

@property (nonatomic, strong) NSString *currentUser;

- (IBAction)logout:(id)sender;
@end
