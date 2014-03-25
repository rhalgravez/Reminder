//
//  ReminderViewController.m
//  Reminder
//
//  Created by Roberto on 3/13/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "ReminderViewController.h"
#import "AddReminderTableViewController.h"
#import "EditReminderViewController.h"
#import "PersistAndFetchReminderData.h"
#import "Reminder.h"

@interface ReminderViewController ()//<AddReminderDelegate>
{
    NSMutableArray *remindersArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PersistAndFetchReminderData *fetchReminders = [[PersistAndFetchReminderData alloc]init];
    remindersArray = (NSMutableArray*)[fetchReminders fetchReminders:_currentUser];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    PersistAndFetchReminderData *fetchReminders = [[PersistAndFetchReminderData alloc]init];
    remindersArray = (NSMutableArray*)[fetchReminders fetchReminders:_currentUser];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToRecentReminders:(UIStoryboardSegue *)segue
{
    //AddReminderViewController *addReminder = [segue sourceViewController];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addReminderSegue"]) {

        UINavigationController *navigationController = segue.destinationViewController;
        AddReminderTableViewController *addReminderTVC = (AddReminderTableViewController *)[navigationController.viewControllers objectAtIndex:0];
        addReminderTVC.currentUser = self.currentUser;
//        addReminderTVC.delegate =self ;

    }
    
    if ([segue.identifier isEqualToString:@"editReminderSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        EditReminderViewController *editReminderVC = segue.destinationViewController;
//        AddReminderTableViewController *addReminderTVC = (AddReminderTableViewController *)[navigationController.viewControllers objectAtIndex:0];
        editReminderVC.selectedReminder = [remindersArray objectAtIndex:indexPath.row];
        
//        addReminderTVC.delegate =self ;
        
    }
}



#pragma mark - TableViewDataSource Protocole 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [remindersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ReminderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Reminder *reminder = [remindersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = reminder.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, y, h:mm a"];
//    NSLog(@"Todays date is %@",[formatter stringFromDate:[reminder startDate]]);
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Start:%@  End:%@",[formatter stringFromDate:[reminder startDate]], [formatter stringFromDate:[reminder endDate]]];
//    NSLog(@"ObjectID:%@",[reminder.objectID description]);
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    PersistAndFetchReminderData *fetchReminders = [[PersistAndFetchReminderData alloc]init];
    Reminder *reminderToDelete= [[Reminder alloc] init];
    reminderToDelete = [remindersArray objectAtIndex:indexPath.row];
    [fetchReminders deleteReminder:[reminderToDelete objectID]];
    [remindersArray removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload
    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Reminder *selectedReminder = [[Reminder alloc]init];
    selectedReminder = [remindersArray objectAtIndex:indexPath.row];
    
}

//- (IBAction)addUser:(id)sender
//{
    //------Save user
//    NSManagedObjectContext *context = [self managedObjectContext];
//    // Create a new managed object for ModalUser
//    NSManagedObject *userTable = [NSEntityDescription insertNewObjectForEntityForName:@"UserTable" inManagedObjectContext:context];
//    //Save the value in the corresponding attribute
//    [userTable setValue:@"0004" forKey:@"userID"];
//    [userTable setValue:@"Username4" forKey:@"username"];
//    [userTable setValue:@"firstName4" forKey:@"first_name"];
//    [userTable setValue:@"lastName4" forKey:@"last_name"];
//    [userTable setValue:@"email4@email.com" forKey:@"email"];
//    
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
    //------End save user
    
    //------Save reminder for a specific user
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSError *error = nil;
//    //NSLog(@"facebookID:%@", userID);
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"UserTable" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSString *userID= @"0004";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@",userID];
//    [fetchRequest setPredicate:predicate];
//    
//    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
//    NSManagedObject *managedObject = [array objectAtIndex:0];
//    //NSLog(@"Username:%@",[managedObject valueForKey:@"username"]);
//    //FLEUser *fetchUser = [[FLEUser alloc]init];
////    for (NSManagedObject *facebookUser in array) {
////        NSLog(@"Username:%@",[facebookUser valueForKey:@"username"]);
////
////        //[context save:&error];
////    }
//    
//    NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
//    mmddccyy.timeStyle = NSDateFormatterNoStyle;
//    mmddccyy.dateFormat = @"MM/dd/yyyy";
//    NSDate *d1 = [mmddccyy dateFromString:@"12/11/2012"];
//    NSDate *d2 = [mmddccyy dateFromString:@"12/12/2012"];
//    
//    NSManagedObject *reminderTable = [NSEntityDescription insertNewObjectForEntityForName:@"ReminderTable" inManagedObjectContext:context];
//    //Save the value in the corresponding attribute
//    [reminderTable setValue:@"titulo2-4" forKey:@"title"];
//    [reminderTable setValue:@"ejemplo de nota 2-4" forKey:@"notes"];
//    [reminderTable setValue:d1 forKey:@"startDate"];
//    [reminderTable setValue:d2 forKey:@"endDate"];
//    
//    [reminderTable setValue:managedObject forKey:@"user"];
//    
//
//    //NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
    //-----end save reminder for specif user
    
    //------delete specific user (must delete its reminders)
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSError *error = nil;
//    //NSLog(@"facebookID:%@", userID);
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"UserTable" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSString *userID = @"0002";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@",userID];
//    [fetchRequest setPredicate:predicate];
//    
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    
//    //FLEUser *fetchUser = [[FLEUser alloc]init];
//    for (NSManagedObject *facebookUser in fetchedObjects) {
//        //NSLog(@"Username:%@",[facebookUser valueForKey:@"facebookUsername"]);
//        [context deleteObject:facebookUser];
//        [context save:&error];
//    }
    //------end delete specific user
    
    //------fetch all reminders from specif user
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSError *error = nil;
//    //NSLog(@"facebookID:%@", userID);
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"UserTable" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSString *userID= @"0004";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID = %@",userID];
//    [fetchRequest setPredicate:predicate];
//    
//
//    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
//    NSLog(@"TAMANIO:%d",[array count]);
//    
//    NSMutableSet *reminders = [[NSMutableSet alloc]init];
//    
//    for (NSManagedObject *managedObject in array) {
//        NSLog(@"REMINDERS: %@",[[managedObject valueForKey:@"reminders"] valueForKey:@"title"]);
//        NSLog(@"REMINDERS: %@",[[managedObject valueForKey:@"reminders"] valueForKey:@"notes"]);
//        NSLog(@"REMINDERS: %@",[[managedObject valueForKey:@"reminders"] valueForKey:@"startDate"]);
//        NSLog(@"REMINDERS: %@",[[managedObject valueForKey:@"reminders"] valueForKey:@"endDate"]);
//        reminders = [managedObject valueForKey:@"reminders"];
//    }
//    NSMutableArray *marray = (NSMutableArray*)[reminders allObjects];
//    NSManagedObject *object = [marray objectAtIndex:1];
//    NSLog(@"NSSet:%@", [object valueForKey:@"notes"]);
//    //------end fetch all reminders from specific user
//    
//}

#pragma mark - Core Data
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
//#pragma mark - Add reminder delegate methods
//
//-(void)addReminder:(Reminder *)reminder{
//    
//    NSLog(@"Simon Jalo");
//    
//}
//
//-(void)reloadReminder{
//    
//}
@end
