//
//  ViewController.m
//  day21
//
//  Created by David Weissler on 1/2/17.
//  Copyright © 2017 David Weissler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) NSMutableString *originalString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day21];
    
}

- (void)day21 {
    self.originalString = @"fbgdceah".mutableCopy;
    
    NSArray<NSString *> *inputArray = [self inputAsArray];
    for (NSInteger i = (NSInteger)inputArray.count - 1; i >= 0; i--) {
        NSString *inputLine = inputArray[i];
        NSArray<NSString *> *parsedLine = [inputLine componentsSeparatedByString:@" "];
        if ([parsedLine[0] isEqualToString:@"swap"]) {
            if ([parsedLine[1] isEqualToString:@"position"]) {
                // swap position X with position Y
                NSUInteger pos1 = [self numberFromString:parsedLine[2]].unsignedIntegerValue;
                NSUInteger pos2 = [self numberFromString:parsedLine[5]].unsignedIntegerValue;
                [self swapPosition:pos1 position:pos2];
            }
            else {
                // swap letter X with letter Y
                NSString *swapLetter1 = parsedLine[2];
                NSString *swapLetter2 = parsedLine[5];
                [self swapLetter:swapLetter1 withLetter:swapLetter2];
            }
        }
        
        if ([parsedLine[0] isEqualToString:@"rotate"]) {
            if ([parsedLine[1] isEqualToString:@"based"]) {
                // rotate based on position of letter X
                [self rotateBasedOnLetter:parsedLine.lastObject];
            }
            else {
                // rotate left/right X steps
                NSInteger amt =  [self numberFromString:parsedLine[2]].integerValue;
                if ([parsedLine[1] isEqualToString:@"left"]) {
                    amt *= -1;
                }
                [self rotateByAmount:amt];
            }
        }
        
        if ([parsedLine[0] isEqualToString:@"reverse"]) {
            // reverse positions X through Y
            NSUInteger pos1 = [self numberFromString:parsedLine[2]].unsignedIntegerValue;
            NSUInteger pos2 = [self numberFromString:parsedLine[4]].unsignedIntegerValue;
            [self reversePositions:pos1 throughPosition:pos2];
        }
        
        if ([parsedLine[0] isEqualToString:@"move"]) {
            // move position X to position Y
            NSUInteger pos1 = [self numberFromString:parsedLine[5]].unsignedIntegerValue;
            NSUInteger pos2 = [self numberFromString:parsedLine[2]].unsignedIntegerValue;
            [self movePosition:pos1 position:pos2];
        }
        NSLog(@"%@: %@", inputLine, self.originalString);
    }
    
    NSLog(@"new string: %@", self.originalString);
}

#pragma mark - Challenge Helper Methods

- (void)swapPosition:(NSUInteger)pos1 position:(NSUInteger)pos2 {
    NSRange range1 = NSMakeRange(pos1, 1);
    NSRange range2 = NSMakeRange(pos2, 1);
    NSString *letter1 = [self.originalString substringWithRange:range1];
    NSString *letter2 = [self.originalString substringWithRange:range2];
    [self.originalString replaceCharactersInRange:range1 withString:letter2];
    [self.originalString replaceCharactersInRange:range2 withString:letter1];
}

- (void)swapLetter:(NSString *)letter1 withLetter:(NSString *)letter2 {
    for (NSUInteger i = 0; i < self.originalString.length; ++i) {
        NSString *currentLetter = [self.originalString substringWithRange:NSMakeRange(i, 1)];
        if ([currentLetter isEqualToString:letter1]) {
            [self.originalString replaceCharactersInRange:NSMakeRange(i, 1) withString:letter2];
        }
        else if ([currentLetter isEqualToString:letter2]) {
            [self.originalString replaceCharactersInRange:NSMakeRange(i, 1) withString:letter1];
        }
    }
}

- (void)reversePositions:(NSUInteger)position1 throughPosition:(NSUInteger)position2 {
    NSUInteger rangeLen = position2 - position1 + 1;
    NSString *subStrToReverse = [self.originalString substringWithRange:NSMakeRange(position1, rangeLen)];
    NSMutableString *reversedString = @"".mutableCopy;
    
    [subStrToReverse enumerateSubstringsInRange:NSMakeRange(0,subStrToReverse.length)
                                 options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                              usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                  [reversedString appendString:substring];
                              }];
    
    [self.originalString replaceCharactersInRange:NSMakeRange(position1, rangeLen) withString:reversedString];
}

- (void)movePosition:(NSUInteger)pos1 position:(NSUInteger)pos2 {
    NSString *letterToMove = [self.originalString substringWithRange:NSMakeRange(pos1, 1)];
    if (pos1 < pos2) {
        [self.originalString insertString:letterToMove atIndex:pos2 + 1];
        [self.originalString deleteCharactersInRange:NSMakeRange(pos1, 1)];
    } else {
        [self.originalString insertString:letterToMove atIndex:pos2];
        [self.originalString deleteCharactersInRange:NSMakeRange(pos1+1, 1)];
    }
}

- (void)rotateByAmount:(NSInteger)amt {
    NSMutableString *newString = @"".mutableCopy;
    for (NSInteger i = 0; i < self.originalString.length; ++i) {
        NSInteger pos = (amt + i) % (NSInteger)self.originalString.length;
        pos = pos >= 0 ? pos : pos + self.originalString.length;
        NSString *newLetter = [self.originalString substringWithRange:NSMakeRange(pos, 1)];
        [newString appendString:newLetter];
    }
    self.originalString = newString;
}

- (void)rotateBasedOnLetter:(NSString *)letter {
    NSInteger idx = (NSInteger)[self.originalString rangeOfString:letter].location;
    if (idx == 0) {
        [self rotateByAmount:1];
        return;
    }
    
    NSInteger extra = idx % 2 == 0 ? 4 : 0;
    extra++;
    idx /= 2;
    idx += extra;
    
    [self rotateByAmount:idx];
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
