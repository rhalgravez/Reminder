//
//  AddReminderTableViewController.h
//  Reminder
//
//  Created by Roberto on 3/23/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reminder;
@protocol AddReminderDelegate;

//@protocol AddReminderDelegate <NSObject>
//-(void)addReminder:(Reminder *)reminder;
//-(void)reloadReminder;
//@end



@interface AddReminderTableViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSString *currentUser;

//@property(assign) id<AddReminderDelegate> delegate;

- (IBAction)donePressed:(UIBarButtonItem *)sender;
- (IBAction)cancelPressed:(UIBarButtonItem *)sender;
- (IBAction)pickerStartDateChanged:(UIDatePicker *)sender;
- (IBAction)pickerEndDateChanged:(UIDatePicker *)sender;


@end
