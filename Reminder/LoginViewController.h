//
//  LoginViewController.h
//  Reminder
//
//  Created by Roberto on 3/13/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) NSString *currentUser;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;



- (IBAction)login:(id)sender;

@end
