//
//  AddReminderViewController.m
//  Reminder
//
//  Created by Roberto on 3/20/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "AddReminderViewController.h"

#define kStartDatePickerIndex 2
#define kEndDatePickerIndex 4
#define kDatePickerCellHeight 164

@interface AddReminderViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *reminderTableView;


@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (assign) BOOL startDatePickerIsShowing;

@property (weak, nonatomic) IBOutlet UITableViewCell *startDatePickerCell;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;

//@property (weak, nonatomic) IBOutlet UITableViewCell *endDatePickerCell;
//@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
//@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (strong, nonatomic) NSDate *selectedDate;

@property (strong, nonatomic) UITextField *activeTextField;
@end

@implementation AddReminderViewController

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
    
    [self setupStartDateLabel];
    
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
    self.startDateLabel.textColor = [self.reminderTableView tintColor];
    
    self.selectedDate = defaultDate;
}

- (void)signUpForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)keyboardWillShow {
    
    if (self.startDatePickerIsShowing){
        
        [self hideDatePickerCell];
    }
}

#pragma mark - Table view methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = tableView.rowHeight;
    //NSLog(@"%f", height);
    if (indexPath.row == kStartDatePickerIndex){
        
        height = self.startDatePickerIsShowing ? kDatePickerCellHeight : 0.0f;
        
    }
    
    if (indexPath.row == kEndDatePickerIndex){
        
        height = self.startDatePickerIsShowing ? kDatePickerCellHeight : 0.0f;
        
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showDatePickerCell {
    
    self.startDatePickerIsShowing = YES;
    
//    [self.reminderTableView beginUpdates];
    
//    [self.reminderTableView endUpdates];
    
    self.startDatePicker.hidden = NO;
    self.startDatePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.startDatePicker.alpha = 1.0f;
        
    }];
}

- (void)hideDatePickerCell {
    
    self.startDatePickerIsShowing = NO;
    
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.startDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.startDatePicker.hidden = YES;
                     }];
}

#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeTextField = textField;
    
}

#pragma mark - Action methods

- (IBAction)donePressed:(UIBarButtonItem *)sender
{
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
}
@end