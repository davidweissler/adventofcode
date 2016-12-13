//
//  ViewController.m
//  day12
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
    [self day12];
}

- (void)day12 {
    NSArray<NSString *> *inputArray = [self inputAsArray];
    NSString *registerIds = @"abcd";
    NSMutableDictionary<NSString *, NSNumber *> *registers = @{@"a" : @0,
                                                               @"b" : @0,
                                                               @"c" : @0,
                                                               @"d" : @0}.mutableCopy;
    for (NSUInteger i = 0; i < inputArray.count; i++) {
        NSArray<NSString *> *lineArray = [inputArray[i] componentsSeparatedByString:@" "];
        NSString *instr = lineArray[0];
        if ([instr isEqualToString:@"cpy"]) {
            NSString *intOrReg = lineArray[1];
            NSString *resultReg = lineArray[2];
            NSInteger value = 0;
            if ([registerIds containsString:intOrReg]) {
                // register
                value = registers[intOrReg].integerValue;
            } else {
                // integer
                value = [self numberFromString:intOrReg].integerValue;
            }
            registers[resultReg] = @(value);
        }
        else if ([instr isEqualToString:@"inc"]) {
            NSString *resultReg = lineArray[1];
            registers[resultReg] = @(registers[resultReg].integerValue + 1);
        }
        else if ([instr isEqualToString:@"dec"]) {
            NSString *resultReg = lineArray[1];
            registers[resultReg] = @(registers[resultReg].integerValue - 1);
        }
        else if ([instr isEqualToString:@"jnz"]) {
            NSString *intOrReg = lineArray[1];
            NSInteger value = 0;
            if ([registerIds containsString:intOrReg]) {
                // register
                value = registers[intOrReg].integerValue;
            } else {
                // integer
                value = [self numberFromString:intOrReg].integerValue;
            }
            
            if (value != 0) {
                NSInteger jumpAmount = [self numberFromString:lineArray[2]].integerValue;
                i += (jumpAmount - 1); // -1 since for-loop will increment i.
            }
        }
    }
    NSLog(@"register a: %@", registers[@"a"]);
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
