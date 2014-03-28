//
//  LoginViewController.m
//  Reminder
//
//  Created by Roberto on 3/13/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "LoginViewController.h"

#import "ReminderAppDelegate.h"

#import "ReminderAppDelegate.h"
#import "PersistAndFetchUserData.h"
#import "ReminderViewController.h"
#import "PastRemindersViewController.h"
#import "UserViewController.h"

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
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"State:%d", FBSession.activeSession.state);
        NSLog(@"Token:%d", FBSessionStateCreatedTokenLoaded);
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//        
//        [self presentViewController:loginVC animated:NO completion:nil];
        [self openActiveSessionAllowLoginUI:NO];
//        [self performSegueWithIdentifier:@"toTabBarViewController" sender:nil];
    }
    
    
    
    //_currentUser = [[NSString alloc]in]
//    NSLog(@"%@",_currentUser);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(id)sender {
    [self openActiveSessionAllowLoginUI:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ReminderAppDelegate *appDelegate = (ReminderAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentUser = [self currentUser];  //etc.
    
    if ([segue.identifier isEqualToString:@"toTabBarViewController"]) {
        UITabBarController *tabBar = segue.destinationViewController;
        UINavigationController *navigationController = (UINavigationController *)[[tabBar viewControllers] objectAtIndex:0];
        ReminderViewController *reminderVC = (ReminderViewController *)[navigationController.viewControllers objectAtIndex:0];
        reminderVC.currentUser = self.currentUser;

        UINavigationController *navigationController2 = (UINavigationController *)[[tabBar viewControllers] objectAtIndex:1];
        PastRemindersViewController *pastRemindersVC = (PastRemindersViewController *) [navigationController2.viewControllers objectAtIndex:0];
        pastRemindersVC.currentUser = self.currentUser;
        
        UserViewController *userVC = (UserViewController *) [[tabBar viewControllers] objectAtIndex:2];
        userVC.currentUser = self.currentUser;
        
    }
}

-(void) openActiveSessionAllowLoginUI:(BOOL) flag
{
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"] allowLoginUI:flag completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        
        if (!error) {
            
            
            // Retrieve the app delegate
            ReminderAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            //Call the app delegate's sessionStateChanged:state:error method to handle session state changes
            [appDelegate sessionStateChanged:session state:state error:error];
            
            [self makeRequestForUserData];
        }
    }];
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
