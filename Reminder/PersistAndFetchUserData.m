//
//  PersistAndFetchUserData.m
//  Reminder
//
//  Created by Roberto on 3/19/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "PersistAndFetchUserData.h"


@implementation PersistAndFetchUserData

-(void) persistData:(NSDictionary *)data
{
    if (![self didUserAlreadyExist:[data objectForKey:@"id"]]) {
        
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *userTable = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"UserTable"
                                      inManagedObjectContext:context];
        
        [userTable setValue:[data objectForKey:@"id"] forKey:@"userID"];
        [userTable setValue:[data objectForKey:@"username"] forKey:@"username"];
        [userTable setValue:[data objectForKey:@"email"] forKey:@"email"];
        [userTable setValue:[data objectForKey:@"first_name"] forKey:@"first_name"];
        [userTable setValue:[data objectForKey:@"last_name"] forKey:@"last_name"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Couldn't save: %@", [error localizedDescription]);
        }else{
            NSLog(@"User saved.");
        }
    }else{
        NSLog(@"User already exist.");
    }
    
    

}

-(BOOL) didUserAlreadyExist:(NSString *)userID
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"UserTable" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@",userID];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
    //NSManagedObject *managedObject = [array objectAtIndex:0];
    if ([array count]!=0) {
        return YES;
    }
    
    return NO;
}

-(User *) fetchUserData:(NSString *)userID
{
    User *user = [[User alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"UserTable" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@",userID];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
    
    NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    managedObject = (NSManagedObject*)[array objectAtIndex:0];
    
    user.userID = [managedObject valueForKey:@"userID"];
    user.username = [managedObject valueForKey:@"username"];
    user.first_name = [managedObject valueForKey:@"first_name"];
    user.last_name = [managedObject valueForKey:@"last_name"];
    user.email = [managedObject valueForKey:@"email"];
    
    return user;
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
