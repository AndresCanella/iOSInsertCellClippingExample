//
//  ViewController.h
//  preventClipPrototype
//
//  Created by andres Canella on 8/1/14.
//  Copyright (c) 2014 reactapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CusTB;
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView* tb;
@property int cells;
@end