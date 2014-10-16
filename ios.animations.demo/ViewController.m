//
//  ViewController.m
//  ios.animations.demo
//
//  Created by Langwan on 14-10-16.
//  Copyright (c) 2014年 langwan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onMove:(id)sender {
    [self.viewA.layer removeAllAnimations];
    [self.viewB.layer removeAllAnimations];
    [UIView animateWithDuration:1.0f
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGRect frame = self.viewA.frame;
                         frame.origin.x += 200;
                         self.viewA.frame = frame;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0f animations:^{
                             CGRect frame = self.viewA.frame;
                             frame.origin.x -= 200;
                             self.viewA.frame = frame;
                         }];
                     }];
}


-(IBAction)onAlpha:(id)sender {
    [self.viewA.layer removeAllAnimations];
    [self.viewB.layer removeAllAnimations];
    [UIView animateWithDuration:1.0f
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.viewA.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0f animations:^{
                             self.viewA.alpha = 1.0f;
                         }];
                     }];
}

-(IBAction)onRotate:(id)sender {
    [self.viewA.layer removeAllAnimations];
    [self.viewB.layer removeAllAnimations];
    CABasicAnimation* rotationAnimation;
    CGFloat duration = 1.0f;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.viewA.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (IBAction)onScaling:(id)sender {
    [self.viewA.layer removeAllAnimations];
    [self.viewB.layer removeAllAnimations];
    [UIView animateWithDuration:0.2f
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.viewA.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2f animations:^{
                             self.viewA.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }];
                     }];
}

- (IBAction)onColor:(id)sender {
    [self.viewA.layer removeAllAnimations];
    [self.viewB.layer removeAllAnimations];
    UIColor* color = self.viewA.backgroundColor;
    [UIView animateWithDuration:1.0f
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.viewA.backgroundColor = [UIColor yellowColor];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0f animations:^{
                             self.viewA.backgroundColor = color;
                         }];
                     }];
}

- (IBAction)onPath:(id)sender {
    [self.viewA.layer removeAllAnimations];
    [self.viewB.layer removeAllAnimations];
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 5.0;
    pathAnimation.repeatCount = 1;
    CGRect frame = self.viewB.frame;
    
    CGMutablePathRef aPath=CGPathCreateMutable();
    CGPathMoveToPoint(aPath, nil, frame.origin.x, frame.origin.y);
    CGPathAddLineToPoint(aPath, nil, frame.origin.x + frame.size.width, frame.origin.y);
    CGPathAddLineToPoint(aPath, nil, frame.origin.x + frame.size.width, frame.origin.y + frame.size.height);
    CGPathAddLineToPoint(aPath, nil, frame.origin.x, frame.origin.y + frame.size.height);
    CGPathAddLineToPoint(aPath, nil,frame.origin.x, frame.origin.y);
    
    pathAnimation.path = aPath;
    [self.viewA.layer addAnimation:pathAnimation forKey:@"position"];
}

-(IBAction)onFrame:(id)sender {
    [self.viewA.layer removeAllAnimations];
    [self.viewB.layer removeAllAnimations];
    
    CGRect oldFrame = self.viewA.frame;
    UIColor* oldColorA = self.viewA.backgroundColor;
     UIColor* oldColorB = self.viewB.backgroundColor;
    [UIView animateKeyframesWithDuration:(CGFloat)3 delay:0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:(CGFloat)0/4 relativeDuration:(CGFloat)1/4  animations:^{
            CGRect frame = self.viewA.frame;
            frame.origin.y = self.viewB.frame.origin.y + self.viewB.frame.size.height;
            self.viewA.frame = frame;
            //self.viewA.alpha = 1.0f;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:(CGFloat)1/4 relativeDuration:(CGFloat)2/4  animations:^{
            self.viewA.backgroundColor = oldColorB;
            self.viewB.backgroundColor = oldColorA;
        }];
        [UIView addKeyframeWithRelativeStartTime:(CGFloat)3/4 relativeDuration:(CGFloat)1/4  animations:^{
            self.viewA.backgroundColor = oldColorA;
            self.viewA.frame = oldFrame;
            self.viewB.backgroundColor = oldColorB;
        }];
    } completion:nil];
    
}

@end
