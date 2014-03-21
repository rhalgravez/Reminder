//
//  LoginViewController.m
//  Reminder
//
//  Created by Roberto on 3/13/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "LoginViewController.h"
#import "ReminderAppDelegate.h"
#import "PersistAndFetchUserData.h"
#import "ReminderViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //_currentUser = [[NSString alloc]in]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        
        if (!error) {
            
            [self makeRequestForUserData];
            // Retrieve the app delegate
            ReminderAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            //Call the app delegate's sessionStateChanged:state:error method to handle session state changes
            [appDelegate sessionStateChanged:session state:state error:error];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toTabBarViewController"]) {
        UITabBarController *tabBar = segue.destinationViewController;
        UINavigationController *navigationController = (UINavigationController *)[[tabBar viewControllers] objectAtIndex:0];
        ReminderViewController *reminderVC = (ReminderViewController *)[navigationController.viewControllers objectAtIndex:0];
        reminderVC.currentUser = self.currentUser;
    }
}

-(void) makeRequestForUserData
{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            
//            NSLog(@"user info: %@", result);
            _currentUser = [result objectForKey:@"id"];
            
            PersistAndFetchUserData *persistUserData = [[PersistAndFetchUserData alloc]init];
            [persistUserData persistData:(NSDictionary*)result];
            
            [self performSegueWithIdentifier:@"toTabBarViewController" sender:nil];
            
        } else {
            NSLog(@"makeRequestForUserData>error %@", error.description);
        }
    }];
}
@end
