//
//  ViewController.m
//  day20
//
//  Created by David Weissler on 12/31/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"

@interface Pair : NSObject
@property (nonatomic) NSUInteger low;
@property (nonatomic) NSUInteger high;
@end

@implementation Pair
@end


@interface ViewController ()

@property (nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day20];
}

- (void)day20 {
    NSArray<NSString *> *input = [self inputAsArray];
    input = [input sortedArrayUsingComparator:^NSComparisonResult(NSString  * _Nonnull obj1, NSString  * _Nonnull obj2) {
        NSArray<NSString *> *objArray1 = [obj1 componentsSeparatedByString:@"-"];
        NSArray<NSString *> *objArray2 = [obj2 componentsSeparatedByString:@"-"];
        
        NSNumber *num1 = [self numberFromString:objArray1[0]];
        NSNumber *num2 = [self numberFromString:objArray2[0]];
        
        if (num1.unsignedIntegerValue < num2.unsignedIntegerValue) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];

    NSMutableArray<Pair *> *merged = @[].mutableCopy;
    for (NSString *inputLine in input) {
        NSArray<NSString *> *lineArray = [inputLine componentsSeparatedByString:@"-"];
        Pair *currentPair = [Pair new];
        currentPair.low = [[self numberFromString:lineArray[0]] unsignedIntegerValue];
        currentPair.high = [[self numberFromString:lineArray[1]] unsignedIntegerValue];
        
        Pair *lastPair = merged.lastObject;
        if (!lastPair) {
            [merged addObject:currentPair];
            continue;
        }
        
        if (currentPair.low > lastPair.high + 1) {
            // [merged addObject:currentPair];
            NSLog(@"lowest free IP: %lu", lastPair.high + 1);
            break;
        } else {
            if (currentPair.high > lastPair.high) {
                lastPair.high = currentPair.high;
            }
        }
    }
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
