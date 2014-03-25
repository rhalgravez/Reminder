//
//  PersistAndFetchReminderData.m
//  Reminder
//
//  Created by Roberto on 3/20/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "PersistAndFetchReminderData.h"
#import "Reminder.h"

@implementation PersistAndFetchReminderData

-(void) saveReminder:(Reminder*)newReminder forUserWithID:(NSString *)userWithID
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
//    NSLog(@"facebookID:%@", userID);
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"UserTable" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
//    NSString *userID= @"0004";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@",userWithID];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
    NSManagedObject *managedObject = [array objectAtIndex:0];
    
    NSManagedObject *reminderTable = [NSEntityDescription insertNewObjectForEntityForName:@"ReminderTable" inManagedObjectContext:context];
    //Save the value in the corresponding attribute
    [reminderTable setValue:newReminder.title forKey:@"title"];
    [reminderTable setValue:newReminder.note forKey:@"notes"];
    [reminderTable setValue:newReminder.startDate forKey:@"startDate"];
    [reminderTable setValue:newReminder.endDate forKey:@"endDate"];
    
    [reminderTable setValue:managedObject forKey:@"user"];
    
    
    //NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}

-(NSArray *)fetchReminders:(NSString *)userWithID
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserTable" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID = %@",userWithID];
    [fetchRequest setPredicate:predicate];

    NSManagedObject *managedObjectWithSpecificUser = [[context executeFetchRequest:fetchRequest error:&error] objectAtIndex:0];
    NSSet *setWithAllReminders = [managedObjectWithSpecificUser valueForKey:@"reminders"];
 

    NSMutableArray *arrayWithAllTheReminders = (NSMutableArray*)[setWithAllReminders allObjects];
    
    NSMutableArray *listOfReminders = [[NSMutableArray alloc]init];
    for (int i=0; i< [arrayWithAllTheReminders count]; i++) {
        NSManagedObject *manageObject = [arrayWithAllTheReminders objectAtIndex:i];
        Reminder *objectReminder = [[Reminder alloc]init];
        objectReminder.objectID = [manageObject objectID];
        objectReminder.title = [manageObject valueForKey:@"title"];
        objectReminder.note = [manageObject valueForKey:@"notes"];
        objectReminder.startDate = [manageObject valueForKey:@"startDate"];
        objectReminder.endDate = [manageObject valueForKey:@"endDate"];
        [listOfReminders addObject:objectReminder];
    }
    return listOfReminders;
}


-(void)deleteReminder:(NSManagedObjectID *)objectID
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
//    NSLog(@"facebookID:%@", userID);
    
    NSManagedObject *managedObject = [context objectWithID:objectID];
    
    [context deleteObject:managedObject];
    if (![context save:&error]) {
        NSLog(@"Can't delete! %@ %@", error, [error localizedDescription]);
    }
    
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"ReminderTable" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSString *userID = @"0002";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectID == %@",objectID];
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
}

-(void) rewriteReminder:(Reminder*)reminder WithObjectID:(NSManagedObjectID *)objectID
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ReminderTable" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSManagedObject *managedObject = [context objectWithID:objectID];
    
    [managedObject setValue:reminder.title forKey:@"title"];
    [managedObject setValue:reminder.note forKey:@"notes"];
    [managedObject setValue:reminder.startDate forKey:@"startDate"];
    [managedObject setValue:reminder.endDate forKey:@"endDate"];
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
