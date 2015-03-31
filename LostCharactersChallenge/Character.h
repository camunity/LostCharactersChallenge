//
//  Character.h
//  LostCharactersChallenge
//
//  Created by Jose Garcia on 3/31/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Character : NSObject

@property (nonatomic, retain) NSString * actor;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * haircolor;
@property (nonatomic, retain) NSString * passenger;

- (instancetype)initWithNSManagedObject:(NSManagedObject *)character;

@end
