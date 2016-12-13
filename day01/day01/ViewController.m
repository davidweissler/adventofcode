//
//  ViewController.m
//  day01
//
//  Created by David Weissler on 12/12/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day1];
}

- (void)day1 {
    NSString *input = [self inputAsArray][0];
    
    NSArray<NSString *> *inputArray = [input componentsSeparatedByString:@", "];
    CGPoint location = CGPointZero;
    NSString *previousMove = @"";
    
    NSMutableSet *visitedPoints = [NSMutableSet set];
    CGPoint firstPlaceVisited = CGPointZero;
    BOOL found = NO;
    
    for (NSString *command in inputArray) {
        NSString *direction = [command substringToIndex:1];
        NSString *distanceStr = [command stringByReplacingOccurrencesOfString:direction withString:@""];
        NSNumber *distance = [self numberFromString:distanceStr];
        
        CGPoint previousLocation = location;
        
        // First Move or Up
        if ([previousMove isEqualToString:@""] || [previousMove isEqualToString:@"up"]) {
            if ([direction isEqualToString:@"L"]) {
                location.x -= distance.integerValue;
                previousMove = @"left";
            } else {
                location.x += distance.integerValue;
                previousMove = @"right";
            }
        }
        // Right
        else if ([previousMove isEqualToString:@"right"]) {
            if ([direction isEqualToString:@"L"]) {
                location.y += distance.integerValue;
                previousMove = @"up";
            } else {
                location.y -= distance.integerValue;
                previousMove = @"down";
            }
        }
        // Left
        else if ([previousMove isEqualToString:@"left"]) {
            if ([direction isEqualToString:@"L"]) {
                location.y -= distance.integerValue;
                previousMove = @"down";
            } else {
                location.y += distance.integerValue;
                previousMove = @"up";
            }
        }
        // Down
        else if ([previousMove isEqualToString:@"down"]) {
            if ([direction isEqualToString:@"L"]) {
                location.x += distance.integerValue;
                previousMove = @"right";
            } else {
                location.x -= distance.integerValue;
                previousMove = @"left";
            }
        }
        
        if (!found) {
            if (previousLocation.x == location.x) {
                // moving along Y axis
                if (previousLocation.y < location.y) {
                    for (NSInteger i = previousLocation.y + 1; i <= location.y; i++) {
                        NSValue *pointAsValue = [NSValue valueWithCGPoint:CGPointMake(location.x, i)];
                        if (!found && [visitedPoints containsObject:pointAsValue]) {
                            firstPlaceVisited = pointAsValue.CGPointValue;
                            found = YES;
                        } else {
                            [visitedPoints addObject:pointAsValue];
                        }
                    }
                }
                else {
                    for (NSInteger i = location.y; i < previousLocation.y; i++) {
                        NSValue *pointAsValue = [NSValue valueWithCGPoint:CGPointMake(location.x, i)];
                        if (!found && [visitedPoints containsObject:pointAsValue]) {
                            firstPlaceVisited = pointAsValue.CGPointValue;
                            found = YES;
                        } else {
                            [visitedPoints addObject:pointAsValue];
                        }
                    }
                }
            }
            else {
                // moving along X axis
                if (previousLocation.x < location.x) {
                    for (NSInteger i = previousLocation.x + 1; i <= location.x; i++) {
                        NSValue *pointAsValue = [NSValue valueWithCGPoint:CGPointMake(i, location.y)];
                        if (!found && [visitedPoints containsObject:pointAsValue]) {
                            firstPlaceVisited = pointAsValue.CGPointValue;
                            found = YES;
                        } else {
                            [visitedPoints addObject:pointAsValue];
                        }
                    }
                }
                else {
                    for (NSInteger i = location.x; i < previousLocation.x; i++) {
                        NSValue *pointAsValue = [NSValue valueWithCGPoint:CGPointMake(i, location.y)];
                        if (!found && [visitedPoints containsObject:pointAsValue]) {
                            firstPlaceVisited = pointAsValue.CGPointValue;
                            found = YES;
                        } else {
                            [visitedPoints addObject:pointAsValue];
                        }
                    }
                }
            }
        }
    }
    
    NSLog(@"result: %f", fabs(location.x) + fabs(location.y));
    NSLog(@"visitedTwice: %f", fabs(firstPlaceVisited.x) + fabs(firstPlaceVisited.y));
}

#pragma mark - Common Helper Methods

// NSString -> NSNumber
- (NSNumber *)numberFromString:(NSString *)input {
    if (!self.numberFormatter) {
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return [self.numberFormatter numberFromString:input];
}

// txt --> NSArray<NSString *>
- (NSArray<NSString *> *)inputAsArray {
    NSString *filePath = @"input";
    NSString *fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:fileRoot
                                                       encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray<NSString *> *allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:
                                                   [NSCharacterSet newlineCharacterSet]].mutableCopy;
    [allLinedStrings removeLastObject];
    return allLinedStrings.copy;
}

@end
