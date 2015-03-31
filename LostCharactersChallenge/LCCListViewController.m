//
//  LCCListViewController.m
//  LostCharactersChallenge
//
//  Created by Cameron Flowers on 3/31/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "LCCListViewController.h"
#import "AppDelegate.h"

@interface LCCListViewController ()
@property NSManagedObjectContext *moc;
@property NSArray *lostCharacters;

@end

@implementation LCCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;
    [self readData];
}

-(void)readData
{
    //stores the path of the plist file present in the bundle
    NSString *bundlePathofPlist = [[NSBundle mainBundle]pathForResource:@"lost" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:bundlePathofPlist];

    for (NSDictionary *dict in array) {
        NSManagedObject *lostCharacter = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];
        [lostCharacter setValue:dict[@"actor"] forKey:@"actor"];
        [lostCharacter setValue:dict[@"passenger"] forKey:@"passenger"];
        [self.moc save:nil];
        NSLog(@"%@",[lostCharacter valueForKey:@"actor"]);
    }
}


//
//    [lostCharacter setValue:(id) forKey:@"gender"];
//    [lostCharacter setValue:(id) forKey:@"age"];
//    [lostCharacter setValue:(id) forKey: @"hair color"];



//    for(int i =0;i<[dataFromPlist count];i++)
//    {
//        NSLog(@"Mobile handset no %d is %@",i+1,[dataFromPlist objectAtIndex:i]);
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
