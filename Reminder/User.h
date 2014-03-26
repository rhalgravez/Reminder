//
//  User.h
//  Reminder
//
//  Created by Roberto on 3/25/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *userID;
@property(nonatomic, strong) NSString *first_name;
@property(nonatomic, strong) NSString *last_name;
@property(nonatomic, strong) NSString *email;

@end
