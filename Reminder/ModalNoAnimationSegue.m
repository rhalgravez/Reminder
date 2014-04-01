//
//  ModalNoAnimationSegue.m
//  Reminder
//
//  Created by Roberto on 3/28/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "ModalNoAnimationSegue.h"

@implementation ModalNoAnimationSegue

- (void)perform
{
    // Add your own animation code here.
    
//    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
    
     [[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:nil];
}

@end
