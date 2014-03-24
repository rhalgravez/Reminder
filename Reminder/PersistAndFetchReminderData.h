//
//  PersistAndFetchReminderData.h
//  Reminder
//
//  Created by Roberto on 3/20/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Reminder;

@interface PersistAndFetchReminderData : NSObject

-(NSArray *)fetchReminders:(NSString *)userWithID;
-(void)deleteReminder:(NSManagedObjectID *)objectID;
-(void) saveReminder:(Reminder*)newReminder forUserWithID:(NSString *)userWithID;

@end
