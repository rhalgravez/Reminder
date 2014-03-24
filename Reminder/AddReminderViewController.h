//
//  AddReminderViewController.h
//  Reminder
//
//  Created by Roberto on 3/20/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddReminderViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

- (IBAction)donePressed:(UIBarButtonItem *)sender;
- (IBAction)cancelPressed:(UIBarButtonItem *)sender;
- (IBAction)pickerStartDateChanged:(UIDatePicker *)sender;
//- (IBAction)pickerEndDateChanged:(UIDatePicker *)sender;


@end
