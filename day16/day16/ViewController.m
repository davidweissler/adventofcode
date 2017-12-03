//
//  ViewController.m
//  day16
//
//  Created by David Weissler on 12/28/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"

#pragma mark - Disk

@interface Disk : NSObject

@property (nonatomic) NSUInteger diskNo;
@property (nonatomic) NSUInteger positionCount;
@property (nonatomic) NSUInteger currentPosition;

@end

@implementation Disk

- (instancetype)initWithDiskNo:(NSUInteger)diskNo positions:(NSUInteger)positions currentPosition:(NSUInteger)currentPos {
    self = [self init];
    
    self.diskNo = diskNo;
    self.positionCount = positions;
    self.currentPosition = currentPos;
    
    return self;
}

- (void)incrementPosition {
    if (self.diskNo == 6) {
        NSLog(@"");
    }
    if (self.currentPosition == self.positionCount - 1) {
        self.currentPosition = 0;
    } else {
        self.currentPosition++;
    }
}

- (NSUInteger)futurePosition {
    NSUInteger fakeCounter = self.currentPosition;
    for (int i = 0; i < self.diskNo; i++) {
        if (fakeCounter == self.positionCount - 1) {
            fakeCounter = 0;
        } else {
            fakeCounter++;
        }
    }
    return fakeCounter;
}

@end

#pragma mark - View Controller

@interface ViewController ()

@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) NSMutableArray<Disk *> *disks;
@property (nonatomic) NSUInteger time;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *testDict = @{}.mutableCopy;
    testDict[@"test"] = @"val";
    testDict[@"test"] = nil;
    
    [self day16];
}


- (void)day16 {
    NSArray<NSString *> *input = [self inputAsArray];
    
    self.disks = @[].mutableCopy;
    
    for (NSString *inputLine in input) {
        // Clean-up input
        NSString *stripped = [inputLine stringByReplacingOccurrencesOfString:@"." withString:@""];
        stripped = [stripped stringByReplacingOccurrencesOfString:@"#" withString:@""];
        stripped = [stripped stringByReplacingOccurrencesOfString:@"," withString:@""];
        stripped = [stripped stringByReplacingOccurrencesOfString:@"=" withString:@" "];
        
        NSArray *inputLineArray = [stripped componentsSeparatedByString:@" "];
        NSUInteger diskNo = [self numberFromString:inputLineArray[1]].integerValue;
        NSUInteger maxPositions = [self numberFromString:inputLineArray[3]].integerValue;
        NSUInteger currPos = [self numberFromString:inputLineArray.lastObject].integerValue;
        Disk *disk = [[Disk alloc] initWithDiskNo:diskNo positions:maxPositions currentPosition:currPos];
        [self.disks addObject:disk];
    }
    self.time = 0;
    while (![self isAligned]) {
        [self incrementDisks];
        self.time++;
    }
    NSLog(@"Done at time: %lu", (unsigned long)self.time);
}

- (BOOL)isAligned {
    for (Disk *disk in self.disks) {
        if ([disk futurePosition] != 0) {
            return NO;
        }
    }
    
    return YES;
}

- (void)incrementDisks {
    for (Disk *disk in self.disks) {
        [disk incrementPosition];
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
