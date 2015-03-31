//
//  LCCListViewController.m
//  LostCharactersChallenge
//
//  Created by Cameron Flowers on 3/31/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "LCCListViewController.h"
#import "AppDelegate.h"
#import "LCCTableViewCell.h"

@interface LCCListViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSManagedObjectContext *moc;
@property NSArray *lostCharacters;
@property (strong, nonatomic) IBOutlet UITableView *charactersTableView;

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
    [self load];
    if (self.lostCharacters.count == 0) {
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
}

- (IBAction)addCharacter:(UITextField *)sender {
}


//
//    [lostCharacter setValue:(id) forKey:@"gender"];
//    [lostCharacter setValue:(id) forKey:@"age"];
//    [lostCharacter setValue:(id) forKey: @"hair color"];


- (void)load {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Character"];
//    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    NSSortDescriptor * sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"prowess" ascending:YES];
//    if (self.prowessToggle) {
//        request.predicate = [NSPredicate predicateWithFormat:@"prowess >= 5"];
//    } else {
//        request.predicate = [NSPredicate predicateWithFormat:@"prowess <= 5"];
//    }

    //request.sortDescriptors = @[sortDescriptor, sortDescriptor2];

    self.lostCharacters = [self.moc executeFetchRequest:request error:nil];

    //[self.warriorTableView reloadData];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.lostCharacters.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSManagedObject *character = self.lostCharacters[indexPath.row];
    LCCTableViewCell *cell = [self.charactersTableView dequeueReusableCellWithIdentifier:@"CharacterCellID"];
    cell.passengerLabel.text = [character valueForKey:@"passenger"];
    cell.actorLabel.text = [character valueForKey:@"actor"];

    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSMutableArray *cellIndicesToBeDeleted = [[NSMutableArray alloc] init];
        for (int i = 0; i < [tableView numberOfRowsInSection:0]; i++) {
            NSIndexPath *path = [NSIndexPath indexPathWithIndex:i];
            if ([[tableView cellForRowAtIndexPath:path] accessoryType] ==
                UITableViewCellAccessoryCheckmark) {
                [cellIndicesToBeDeleted addObject:path];
            }
        }
        [tableView deleteRowsAtIndexPaths:cellIndicesToBeDeleted
                         withRowAnimation:UITableViewRowAnimationLeft];
        [cellIndicesToBeDeleted removeAllObjects];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {

    if (self.editing) {
        self.editing = false;
        [self.charactersTableView setEditing:NO animated:YES];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }

    else
    {
        self.editing = true;
        [self.charactersTableView setEditing:YES animated:YES];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }

}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    self.charactersTableView.allowsMultipleSelectionDuringEditing = editing;
    [super setEditing:editing animated:animated];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


@end
