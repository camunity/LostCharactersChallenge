//
//  Character.m
//  LostCharactersChallenge
//
//  Created by Jose Garcia on 3/31/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Character.h"


@implementation Character

@dynamic actor;
@dynamic age;
@dynamic gender;
@dynamic haircolor;
@dynamic passenger;

- (instancetype)initWithNSManagedObject:(NSManagedObject *)character {
    self = [super init];
    if (self) {
        self.actor = [character valueForKey:@"actor"];
        self.passenger = [character valueForKey:@"passenger"];
    }

    return self;
}


@end
