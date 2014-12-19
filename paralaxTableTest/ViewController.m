//
//  ViewController.m
//  paralaxTableTest
//
//  Created by Chris Milne on 12/19/14.
//  Copyright (c) 2014 ideo. All rights reserved.
//

#import "ViewController.h"

#define INITIAL_X_OFFSET 1024

@interface ViewController ()
    @property CGPoint originalPoint;
    @property (strong, nonatomic) NSArray *z_Values;
@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.z_Values = [[NSArray alloc] initWithObjects:
                     [NSNumber numberWithFloat:1.0],
                     [NSNumber numberWithFloat:1.5],
                     [NSNumber numberWithFloat:2.0], nil];
    
    NSLog(@"zValuesCount: %lu", (unsigned long)self.z_Values.count);
    
    [self.scrollView setContentSize:CGSizeMake(1024*3, 768)];
    [self.scrollView setContentOffset:CGPointMake(INITIAL_X_OFFSET, 0)];
    
    self.redView.center     = CGPointMake(INITIAL_X_OFFSET+512, 768/2.0+0);
    self.blueView.center    = CGPointMake(INITIAL_X_OFFSET+512, 768/2.0+20);
    self.greenView.center   = CGPointMake(INITIAL_X_OFFSET+512, 768/2.0+40);
    
    self.originalPoint = CGPointMake(self.blueView.center.x, self.blueView.center.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollviewDidScroll::offset: %f", scrollView.contentOffset.x);
    
    [self setViewCenter:self.blueView usingOffset:scrollView.contentOffset.x];
    [self setViewCenter:self.greenView usingOffset:scrollView.contentOffset.x];
    [self setViewCenter:self.redView usingOffset:scrollView.contentOffset.x];
}

- (void)setViewCenter:(UIView*)thisView usingOffset:(float)offset {
    CGFloat offsetDiff = (INITIAL_X_OFFSET-offset) / [[self.z_Values objectAtIndex:(thisView.tag)] floatValue];
    NSLog(@"  setViewCenter %ld: %f", (long)thisView.tag, offsetDiff);
    
    thisView.center = CGPointMake(self.originalPoint.x + offsetDiff, thisView.center.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
