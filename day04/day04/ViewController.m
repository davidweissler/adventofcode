//
//  ViewController.m
//  day04
//
//  Created by David Weissler on 12/12/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>

@interface LetterCount : NSObject

@property (nonatomic) NSNumber *counter;
@property (nonatomic) NSString *letter;

@end

@implementation LetterCount

@end

@interface ViewController ()

@property (nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day4];
}

- (void)day4 {
    NSArray<NSString *> *inputArray = [self inputAsArray];
    
    NSUInteger sectorIdTotal = 0;
    
    NSMutableDictionary *realRooms = @{}.mutableCopy;
    for (NSString *roomLine in inputArray) {
        NSString *newRoomLine = roomLine.copy;
        // strip out dashes

        NSString *checksum = [newRoomLine substringWithRange:NSMakeRange(newRoomLine.length - 7, 7)];
        newRoomLine = [newRoomLine stringByReplacingOccurrencesOfString:checksum withString:@""];
        checksum = [checksum stringByReplacingOccurrencesOfString:@"[" withString:@""];
        checksum = [checksum stringByReplacingOccurrencesOfString:@"]" withString:@""];

        NSString *sectorIdString = [newRoomLine substringWithRange:NSMakeRange(newRoomLine.length - 3, 3)];
        newRoomLine = [newRoomLine stringByReplacingOccurrencesOfString:sectorIdString withString:@""];

        NSMutableDictionary *letterCountDict = @{}.mutableCopy;
        for (NSUInteger i = 0; i < newRoomLine.length; ++i) {
            char letter = [newRoomLine characterAtIndex:i];
            if (letter == '-') {
                continue;
            }
            NSString *letterString = [NSString stringWithFormat:@"%c", letter];

            LetterCount *count = letterCountDict[letterString];
            if (!count) {
                count = [[LetterCount alloc] init];
                count.letter = letterString;
                count.counter = @0;
            }
            count.counter = @(count.counter.integerValue + 1);
            letterCountDict[letterString] = count;
        }

        NSMutableArray *finalCount = [letterCountDict allValues].mutableCopy;
        NSArray<LetterCount *> *sortedArray = [finalCount sortedArrayUsingComparator:^NSComparisonResult(LetterCount *p1, LetterCount *p2){
            if (p1.counter.integerValue != p2.counter.integerValue) {
                return p1.counter.integerValue < p2.counter.integerValue;
            }
            else {
                return [p1.letter compare:p2.letter];
            }
        }];

        BOOL isReal = YES;
        for (NSUInteger i = 0; i < checksum.length; ++i) {
            char chkChar = [checksum characterAtIndex:i];
            NSString *checksumString = [NSString stringWithFormat:@"%c", chkChar];

            if (![sortedArray[i].letter isEqualToString:checksumString]) {
                isReal = NO;
            }
        }

        if (isReal) {
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *num = [f numberFromString:sectorIdString];
            sectorIdTotal += num.integerValue;
            realRooms[newRoomLine] = num;
        }
    }
    NSLog(@"Total: %lu", (unsigned long)sectorIdTotal);
}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return  output;

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
