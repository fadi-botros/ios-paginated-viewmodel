//
//  ViewController.h
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PaginatedViewModel.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (readonly) PaginatedViewModel *viewModel;

@end

