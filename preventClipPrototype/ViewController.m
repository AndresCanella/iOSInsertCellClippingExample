//
//  ViewController.m
//  preventClipPrototype
//
//  Created by andres Canella on 8/1/14.
//  Copyright (c) 2014 reactapp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    UILabel* infoLb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 150.0f, self.view.bounds.size.width, self.view.bounds.size.height - 150.0f)];
    [infoLb setText:@"Setup:\nWe have clear cells with views that extrend beyound regular cell area. Green extends out upwards. Red extends out downwards.\n\nProblem:\nWhen a cell is inserted, the cells already on the table animate to make space and acomodate for the new cell. Durring the duration of this animation all the views that extend out of the regular cell area are cliped, and return to normal when the animation is done. The problem is the clipping.\n\nUsage:\nTap cell to insert cell at location."];
    [infoLb setNumberOfLines:20];
    [infoLb setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:infoLb];
    
    self.tb = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tb setBackgroundColor:[UIColor clearColor]];
    [self.tb setDataSource:self];
    [self.tb setDelegate:self];
    [self.tb setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tb];
    self.cells = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//TB
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"somecell"];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"somecell"];
            
            UIView* cellSubView = [[UIView alloc] initWithFrame:cell.bounds];
            [cellSubView setBackgroundColor:[UIColor clearColor]];
            [cellSubView setClipsToBounds:NO];
            [cell addSubview:cellSubView];
            
            UIView* bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 49.5f, cell.bounds.size.width, 0.5f)];
            [bottomLine setBackgroundColor:[UIColor lightGrayColor]];
            [cellSubView addSubview:bottomLine];
            
            UIView* extendOutOfCellUpView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, -10.0f, 20.0f, 30.0f)];
            [extendOutOfCellUpView setBackgroundColor:[UIColor greenColor]];
            [cellSubView addSubview:extendOutOfCellUpView];

            UIView* extendOutOfCellDownView = [[UIView alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 60.0f, 30.0f, 20.0f, 30.0f)];
            [extendOutOfCellDownView setBackgroundColor:[UIColor redColor]];
            [cellSubView addSubview:extendOutOfCellDownView];
        }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    

    [cell.layer setZPosition:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cells;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //insert new row at tap location
    [tableView beginUpdates];
    self.cells++;
    [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [tableView endUpdates];
}

@end