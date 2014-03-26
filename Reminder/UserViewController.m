//
//  UserViewController.m
//  Reminder
//
//  Created by Roberto on 3/13/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "UserViewController.h"
#import "PersistAndFetchUserData.h"
#import "User.h"

@interface UserViewController ()

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;


@end

@implementation UserViewController

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
    PersistAndFetchUserData *fetchUser =[[PersistAndFetchUserData alloc]init];
    User *userProfile = [[User alloc]init];
    
    userProfile = [fetchUser fetchUserData:_currentUser];
    
    [FBProfilePictureView class];
    
    self.profilePictureView.profileID = userProfile.userID;
    self.emailLabel.text = userProfile.email;
    self.usernameLabel.text = userProfile.username;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", userProfile.first_name, userProfile.last_name];
    
    NSLog(@"%@", _currentUser);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    
    
    
//    [self dismissViewControllerAnimated:YES completion:^{
    
        NSLog(@"Permissions:%@", [[FBSession activeSession] permissions]);
        [[FBSession activeSession] closeAndClearTokenInformation];
        
        [self performSegueWithIdentifier:@"backToLoginViewController" sender:nil];
//    }];
    
    
}
@end
