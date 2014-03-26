//
//  PersistAndFetchUserData.h
//  Reminder
//
//  Created by Roberto on 3/19/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface PersistAndFetchUserData : NSObject

-(void) persistData:(NSDictionary *)data;
-(User *) fetchUserData:(NSString *)userID;


@end
