//
//  DetailViewController.m
//  Custom UIViewController transitions
//
//  Created by LiGuicai on 15/7/20.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pop:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
}

- (void)pop:(id)sender {
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = (UIScreenEdgePanGestureRecognizer *)sender;
    CGPoint point = [popRecognizer translationInView:self.view];
    NSLog(@"x = %f  y = %f", point.x, point.y);
    double progress = point.x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    NSLog(@"%f", progress);
    if (popRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"刚开始滑动");
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (popRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"变动");
        [self.interactivePopTransition updateInteractiveTransition:progress];
        
    } else if (popRecognizer.state == UIGestureRecognizerStateEnded || popRecognizer.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"取消or结束");
        
        if (progress > 0.5f) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

@end
