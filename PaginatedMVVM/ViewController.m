//
//  ViewController.m
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "ViewController.h"
#import "SimulationRepository.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static void *observationContext = &observationContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    PaginatedInteractor *paginatedInteractor = [[PaginatedInteractor alloc] initWithRepository:SimulationRepository.shared andList:[[EntityList alloc] init]];
    _viewModel = [[PaginatedViewModel alloc] initWithPaginatedInteractor: paginatedInteractor];
    
    [self.viewModel addObserver:self forKeyPath:@"localObjects" options:0 context:observationContext];
}

- (void)dealloc
{
    if (_viewModel != nil) {
        [self.viewModel removeObserver:self forKeyPath:@"localObjects"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Key-Value Observation

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == observationContext) {
        NSIndexSet *indices = [change objectForKey:NSKeyValueChangeIndexesKey];
        NSKeyValueChange kind = [[change objectForKey:NSKeyValueChangeKindKey] unsignedIntegerValue];
        if (kind == NSKeyValueChangeInsertion) {
            dispatch_sync(dispatch_get_main_queue(), ^(void){
                [self.tableView beginUpdates];
                [indices enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                [self.tableView endUpdates];
            });
        } else if (kind == NSKeyValueChangeRemoval) {
            dispatch_sync(dispatch_get_main_queue(), ^(void){
                [self.tableView beginUpdates];
                [indices enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                [self.tableView endUpdates];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark Table View Stuff

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.textLabel setText:(NSString *) [self.viewModel objectByIndex:indexPath.row]];
    return cell;
}

@end
