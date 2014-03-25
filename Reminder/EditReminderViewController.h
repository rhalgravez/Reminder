//
//  EditReminderViewController.h
//  Reminder
//
//  Created by Roberto on 3/25/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reminder;

@interface EditReminderViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic, strong) Reminder *selectedReminder;

- (IBAction)saveChanges:(UIBarButtonItem *)sender;


- (IBAction)pickerStartDateChanged:(UIDatePicker *)sender;
- (IBAction)pickerEndDateChanged:(UIDatePicker *)sender;

@end
