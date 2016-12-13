//
//  ViewController.m
//  day03
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
    // Do any additional setup after loading the view, typically from a nib.
    [self day3];
}

- (void)day3 {
    NSArray<NSString *> *inputArray = [self inputAsArray];
    
    NSMutableArray<NSMutableArray<NSNumber *> *> *newInputArray = @[].mutableCopy;
    for (NSString *inputRow in inputArray) {
        NSArray<NSString *> *stringsArray = [inputRow componentsSeparatedByString:@" "];
        NSMutableArray *numbersRow = @[].mutableCopy;
        for (NSString *string in stringsArray) {
            if (string.length == 0) {
                // some numbers are separated by 1, 2, or 3 spaces
                continue;
            }
            NSNumber *num = [self numberFromString:string];
            [numbersRow addObject:num];
        }
        [newInputArray addObject:numbersRow];
    }
    
    NSUInteger possibleCount = 0;
    for (NSMutableArray *sidesArray in newInputArray) {
        NSArray<NSNumber *> *sortedSides = [sidesArray sortedArrayUsingSelector: @selector(compare:)];
        if (sortedSides[0].integerValue + sortedSides[1].integerValue > sortedSides[2].integerValue) {
            possibleCount += 1;
        }
    }
    
    NSLog(@"Possible triangles: %lu", (unsigned long)possibleCount);
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
