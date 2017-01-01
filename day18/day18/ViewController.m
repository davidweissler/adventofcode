//
//  ViewController.m
//  day18
//
//  Created by David Weissler on 12/31/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day18];
}

- (void)day18 {
    NSString *input = @".^^.^.^^^^"; // test input
    input = @".^^^.^.^^^^^..^^^..^..^..^^..^.^.^.^^.^^....^.^...^.^^.^^.^^..^^..^.^..^^^.^^...^...^^....^^.^^^^^^^"; // puzzle input
    
    NSUInteger numberOfSafeTiles = 0;
    numberOfSafeTiles += [self numberOfOccurencesOfString:@"." inInput:input];
    
    for (int j = 1; j < 400000; j++) {
        NSMutableString *newLine = @"".mutableCopy;
        for (NSUInteger i = 0; i < input.length; i++) {
            BOOL isLeftTrap = i == 0 ? NO : [[input substringWithRange:NSMakeRange(i-1, 1)] isEqualToString:@"^"];
            BOOL isCenterTrap = [[input substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"^"];
            BOOL isRightTrap = i == input.length - 1 ? NO : [[input substringWithRange:NSMakeRange(i+1, 1)] isEqualToString:@"^"];

            BOOL isCurrentTrap = NO;
            
            if (isLeftTrap && isCenterTrap && !isRightTrap) {
                isCurrentTrap = YES;
            }
            
            if (!isCurrentTrap && isCenterTrap && isRightTrap && !isLeftTrap) {
                isCurrentTrap = YES;
            }
            
            if (!isCurrentTrap && isLeftTrap && !isCenterTrap && !isRightTrap) {
                isCurrentTrap = YES;
            }
            
            if (!isCurrentTrap && isRightTrap && !isLeftTrap && !isCenterTrap) {
                isCurrentTrap = YES;
            }
            
            NSString *newSpot = isCurrentTrap ? @"^" : @".";
            [newLine appendString:newSpot];
        }
        input = newLine;
        numberOfSafeTiles += [self numberOfOccurencesOfString:@"." inInput:input];
    }
    NSLog(@"Number of safe tiles: %lu", numberOfSafeTiles);
}

- (NSUInteger)numberOfOccurencesOfString:(NSString *)check inInput:(NSString *)input {
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < input.length; i++) {
        NSString *testStr = [input substringWithRange:NSMakeRange(i, 1)];
        if ([testStr isEqualToString:check]) {
            count++;
        }
    }
    return count;
}

@end
