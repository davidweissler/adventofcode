//
//  ViewController.m
//  day02
//
//  Created by David Weissler on 12/12/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"

struct ArrayLoc {
    NSUInteger row;
    NSUInteger column;
};

@interface ViewController ()

@property (nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self day2];
}

- (void)day2 {
    NSArray<NSString *> *inputArray = [self inputAsArray];
    NSArray<NSArray <NSString *> *> *console = @[@[@" ", @" ", @" ", @" ", @" "],
                                                 @[@" ", @"1", @"2", @"3", @" "],
                                                 @[@" ", @"4", @"5", @"6", @" "],
                                                 @[@" ", @"7", @"8", @"9", @" "],
                                                 @[@" ", @" ", @" ", @" ", @" "]];
    struct ArrayLoc location;
    location.row = 2;
    location.column = 2;
    
    NSMutableString *key = @"".mutableCopy;
    
    for (NSString *directions in inputArray) {
        // Parse string
        for (NSUInteger i = 0; i < directions.length; ++i) {
            char direction = [directions characterAtIndex:i];
            struct ArrayLoc testLocation = location;
            if (direction == 'U') {
                testLocation.row -= 1;
            }
            else if (direction == 'D') {
                testLocation.row += 1;
            }
            else if (direction == 'L') {
                testLocation.column -= 1;
            }
            else if (direction == 'R') {
                testLocation.column += 1;
            }
            
            if ([console[testLocation.row][testLocation.column] isEqualToString:@" "]) {
                testLocation = location;
            }
            location = testLocation;
        }
        [key appendString:console[location.row][location.column]];
    }
    NSLog(@"key: %@", key);
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
