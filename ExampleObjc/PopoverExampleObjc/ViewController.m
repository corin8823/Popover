//
//  ViewController.m
//  PopoverExampleObjc
//
//  Created by corin8823 on 4/6/16.
//  Copyright © 2016 corin8823. All rights reserved.
//

#import "ViewController.h"
#import "Popover-swift.h"

@interface ViewController ()

@property (strong, nonatomic) Popover *popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tappedRightBarButton:(id)sender {
    CGPoint point = CGPointMake(self.view.frame.size.width - 60, 55);
    UIView *aView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 180)];
    Popover *popover = [[Popover alloc] init];
    [popover show:aView point:point];
}

- (IBAction)tappedLeftBottomButton:(id)sender {
    CGFloat width = self.view.frame.size.width / 4;
    UIView *aView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, width, width)];
    Popover *popover = [[Popover alloc] initWithShowHandler:^{
        NSLog(@"didShowHandler");
    } dismissHandler:^{
        NSLog(@"didDismissHandler");

    }];
    popover.cornerRadius = width / 2;
    popover.popoverType = PopoverTypeUp;
    [popover show: aView fromView:self.leftBottomButton];
}

- (IBAction)tappedRigthButtomButton:(id)sender {
    CGFloat width = self.view.frame.size.width / 4;
    UIView *aView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, width, width)];
    Popover *popover = [[Popover alloc] init];
    popover.popoverType = PopoverTypeUp;
    [popover show: aView fromView:self.rightButtomButton];
}

@end
