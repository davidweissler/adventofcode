//
//  ViewController.m
//  day22
//
//  Created by David Weissler on 1/2/17.
//  Copyright © 2017 David Weissler. All rights reserved.
//

#import "ViewController.h"

@interface Node : NSObject

@property (nonatomic) NSString *nodeId;
@property (nonatomic) NSNumber *used;
@property (nonatomic) NSNumber *available;

- (NSComparisonResult)compareUsedWithNode:(Node *)node;
- (NSComparisonResult)compareAvailWithNode:(Node *)node;

@end

@implementation Node

- (NSComparisonResult)compareUsedWithNode:(Node *)node {
    return [self.used compare:node.used];
}

- (NSComparisonResult)compareAvailWithNode:(Node *)node {
    return [self.available compare:node.available];
}

@end

@interface ViewController ()

@property (nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day22];
}

- (void)day22 {
    NSArray<NSString *> *input = [self inputAsArray];
    NSMutableArray<Node *> *nodeArray = @[].mutableCopy;
    for (NSString *inputLine in input) {
        NSArray<NSString *> *parsedLine = [inputLine componentsSeparatedByString:@" "];
        Node *node = [Node new];
        node.nodeId = [NSString stringWithFormat:@"%@%@", parsedLine[0], parsedLine[1]];
        node.used = [self numberFromString:parsedLine[3]];
        node.available = [self numberFromString:parsedLine[4]];
        [nodeArray addObject:node];
    }
    
    NSArray *sortedUsed = [nodeArray sortedArrayUsingSelector:@selector(compareUsedWithNode:)];
    NSArray *sortedAvail = [nodeArray sortedArrayUsingSelector:@selector(compareAvailWithNode:)];
    
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
