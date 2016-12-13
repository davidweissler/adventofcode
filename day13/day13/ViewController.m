//
//  ViewController.m
//  day13
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
    [self day13];
}

- (void)day13 {
    NSUInteger input = 1352;
    NSUInteger row = 100;
    NSUInteger col = 100;
    NSMutableArray<NSMutableArray <NSString *> *> *maze = @[].mutableCopy;
    for (NSUInteger i = 0; i < row; i++) {
        NSMutableArray *row = @[].mutableCopy;
        [maze addObject:@[].mutableCopy];
        for (NSUInteger j = 0; j < col; j++) {
            [row addObject:@""];
        }
        [maze addObject:row];
    }

    
    for (NSUInteger i = 0; i < row; i++) {
        for (NSUInteger j = 0; j < col; j++) {
            NSUInteger result = [self equationForX:j y:i] + input;
            NSString *binary = [self intToBinary:result];
            binary = [binary stringByReplacingOccurrencesOfString:@"0" withString:@""];
            NSUInteger oneCount = binary.length;
            maze[i][j] = oneCount % 2 == 0 ? @"." : @"#";
        }
    }


    for (NSUInteger i = 0; i < row; i++) {
        for (NSUInteger j = 0; j < col; j++) {
            if ((i == 1 && j == 1) || (i == 39 && j == 31)) {
                printf("0");
//                printf("%c", [maze[i][j] characterAtIndex:0]);
            } else {
                printf("%c", [maze[i][j] characterAtIndex:0]);
            }
            
        }
        printf("\n");
    }
}

- (NSUInteger)equationForX:(NSUInteger)x y:(NSUInteger)y {
    return x*x + 3*x + 2*x*y + y + y*y;
}

- (NSString *)intToBinary:(int)number
{
    // Number of bits
    int bits =  sizeof(number) * 8;
    
    // Create mutable string to hold binary result
    NSMutableString *binaryStr = [NSMutableString string];
    
    // For each bit, determine if 1 or 0
    // Bitwise shift right to process next number
    for (; bits > 0; bits--, number >>= 1)
    {
        // Use bitwise AND with 1 to get rightmost bit
        // Insert 0 or 1 at front of the string
        [binaryStr insertString:((number & 1) ? @"1" : @"0") atIndex:0];
    }
    
    return (NSString *)binaryStr;
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
