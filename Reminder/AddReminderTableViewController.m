//
//  AddReminderTableViewController.m
//  Reminder
//
//  Created by Roberto on 3/23/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "AddReminderTableViewController.h"
#import "Reminder.h"
#import "PersistAndFetchReminderData.h"

#define kStartDatePickerIndex 2
#define kEndDatePickerIndex 4
#define kDatePickerCellHeight 164

@interface AddReminderTableViewController ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (assign) BOOL startDatePickerIsShowing;
@property (assign) BOOL endDatePickerIsShowing;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell *startDatePickerCell;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *endDatePickerCell;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

@property(weak, nonatomic) IBOutlet UITableViewCell *notesCell;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (weak, nonatomic) IBOutlet UISwitch *postInFacebookSwitch;

@property (strong, nonatomic) NSDate *selectedDate;

@property (strong, nonatomic) UITextField *activeTextField;

@end

@implementation AddReminderTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupStartDateLabel];
    [self setupEndDateLabel];
    
    [self.startDatePicker setMinimumDate:[NSDate date]];
    [self.endDatePicker setMinimumDate:[[NSDate date] dateByAddingTimeInterval:60]];
    
    _notesTextView.text = @"Add a comment...";
    _notesTextView.textColor = [UIColor lightGrayColor];
    
    //no se que pedo con este metodo
    [self signUpForKeyboardNotifications];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupStartDateLabel
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *defaultDate = [NSDate date];
   
    self.startDateLabel.text = [self.dateFormatter stringFromDate:defaultDate];
    self.startDateLabel.textColor = [self.tableView tintColor];
    
    self.selectedDate = defaultDate;
}

-(void) setupEndDateLabel
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *defaultDate = [NSDate date];
    
    self.endDateLabel.text = [self.dateFormatter stringFromDate:defaultDate];
    self.endDateLabel.textColor = [self.tableView tintColor];
    
    self.selectedDate = defaultDate;
}

- (void)signUpForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)keyboardWillShow {
    
//    if (self.startDatePickerIsShowing){
    
        [self hideDatePickerCell];
//    }
    
//    if (self.endDatePickerIsShowing) {
        [self hideEndDatePickerCell];
//    }
}

#pragma mark - Table view methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = self.tableView.rowHeight;
    //NSLog(@"%f", height);
    if (indexPath.row == kStartDatePickerIndex){
        
        height = self.startDatePickerIsShowing ? kDatePickerCellHeight : 0.0f;
        
    }
    
    if (indexPath.row == kEndDatePickerIndex){
        
        height = self.endDatePickerIsShowing ? kDatePickerCellHeight : 0.0f;
        
    }
    
    if (indexPath.row == 5){
        
        height =  kDatePickerCellHeight;
        
    }
    
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1){
        
        if (self.startDatePickerIsShowing){
            
            [self hideDatePickerCell];
            
        }else {
            
            [self.activeTextField resignFirstResponder];
            
            [self showDatePickerCell];
        }
    }
    
    if (indexPath.row == 3) {
        if (self.endDatePickerIsShowing){
            
            [self hideEndDatePickerCell];
            
        }else {
            
            [self.activeTextField resignFirstResponder];
            
            [self showEndDatePickerCell];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showDatePickerCell {
    
    self.startDatePickerIsShowing = YES;
    
    [self hideEndDatePickerCell];
    
    [self.tableView beginUpdates];
    
    
    
    self.startDatePicker.hidden = NO;
    self.startDatePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.startDatePicker.alpha = 1.0f;
        
    }];
    
    [self.tableView endUpdates];
}

- (void)showEndDatePickerCell {
    
    self.endDatePickerIsShowing = YES;
    
    [self hideDatePickerCell];
    
    [self.tableView beginUpdates];
    
    
    
    self.endDatePicker.hidden = NO;
    self.endDatePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.endDatePicker.alpha = 1.0f;
        
    }];
    
    [self.tableView endUpdates];
}

- (void)hideDatePickerCell {
    
    self.startDatePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.startDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.startDatePicker.hidden = YES;
                     }];
}

- (void)hideEndDatePickerCell {
    
    self.endDatePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.endDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.endDatePicker.hidden = YES;
                     }];
}

#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeTextField = textField;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Add a comment..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Add a comment...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

#pragma mark - Action methods

- (IBAction)donePressed:(UIBarButtonItem *)sender
{
    
//    [_delegate addReminder:Nil];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d, y, h:mm a"];
    NSDate *date = [[NSDate alloc]init];
    
    Reminder *newReminder = [[Reminder alloc]init];
    newReminder.title = _titleTextField.text;
    newReminder.note = _notesTextView.text;
    
    date = [dateFormat dateFromString:_startDateLabel.text];
    newReminder.startDate = date;
    
    date = [dateFormat dateFromString:_endDateLabel.text];
    newReminder.endDate = date;
    
    
    PersistAndFetchReminderData *saveReminder;
    saveReminder = [[PersistAndFetchReminderData alloc] init];
    [saveReminder saveReminder:newReminder forUserWithID:_currentUser];
    
    if (_postInFacebookSwitch.on) {
        [self postInWall:newReminder];
        
    }
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)cancelPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)pickerStartDateChanged:(UIDatePicker *)sender
{
    self.startDateLabel.text = [self.dateFormatter stringFromDate:sender.date];
    self.selectedDate = sender.date;
}

- (IBAction)pickerEndDateChanged:(UIDatePicker *)sender {
    self.endDateLabel.text = [self.dateFormatter stringFromDate:sender.date];
    self.selectedDate = sender.date;
}



#pragma mark - Facebook Post methods

-(void) postInWall:(Reminder *)reminder
{
    // We will post on behalf of the user, these are the permissions we need:
    NSArray *permissionsNeeded = @[@"publish_actions"];
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
                                  
                                  // Check if all the permissions we need are present in the user's current permissions
                                  // If they are not present add them to the permissions to be requested
                                  for (NSString *permission in permissionsNeeded){
                                      if (![currentPermissions objectForKey:permission]){
                                          [requestPermissions addObject:permission];
                                      }
                                  }
                                  
                                  // If we have permissions to request
                                  if ([requestPermissions count] > 0){
                                      // Ask for the missing permissions
                                      [FBSession.activeSession requestNewPublishPermissions:requestPermissions
                                                                            defaultAudience:FBSessionDefaultAudienceFriends
                                                                          completionHandler:^(FBSession *session, NSError *error) {
                                                                              if (!error) {
                                                                                  // Permission granted, we can request the user information
                                                                                  [self makeRequestToUpdateStatusForReminder:reminder];
                                                                              } else {
                                                                                  // An error occurred, handle the error
                                                                                  // See our Handling Errors guide: https://developers.facebook.com/docs/ios/errors/
                                                                                  NSLog(@"%@", error.description);
                                                                              }
                                                                          }];
                                  } else {
                                      // Permissions are present, we can request the user information
                                      [self makeRequestToUpdateStatusForReminder:reminder];
                                  }
                                  
                              } else {
                                  // There was an error requesting the permission information
                                  // See our Handling Errors guide: https://developers.facebook.com/docs/ios/errors/
                                  NSLog(@"%@",error.description);
                              }
                          }];
}

-(void)makeRequestToUpdateStatusForReminder:(Reminder *) reminder
{
    // NOTE: pre-filling fields associated with Facebook posts,
    // unless the user manually generated the content earlier in the workflow of your app,
    // can be against the Platform policies: https://developers.facebook.com/policy
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *status = [NSString stringWithFormat:@"Reminder: %@ at %@",reminder.title,reminder.startDate];
    [FBRequestConnection startForPostStatusUpdate:status completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // Status update posted successfully to Facebook
            NSLog(@"result: %@", result);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                            message:@"The post is now in your time line!"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
        } else {
            // An error occurred, we need to handle the error
            // See: https://developers.facebook.com/docs/ios/errors
//            NSLog(@"Error Status Update:%@", error.description);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error2"
//                                                            message:@"There was something wrong."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
            NSLog(@"%@", [error description]);
        }
        
    }];
}

@end
