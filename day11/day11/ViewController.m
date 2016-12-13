//
//  ViewController.m
//  day11
//
//  Created by David Weissler on 12/12/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"

@interface Node : NSObject

@property (nonatomic) NSUInteger floor;
@property (nonatomic) NSString *currentState;
@property (nonatomic) NSUInteger stepCount;

@end

@implementation Node

@end

@interface ViewController ()
@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) NSMutableSet *seenSet;
@property (nonatomic) NSUInteger floorCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day11Part:2];
}

- (NSMutableString *)inputPart1 {
    return @"Aa..........B.C.D.E....b.c.d.e..........".mutableCopy;
}

- (NSMutableString *)inputPart2 {
    //    return @".............g............................AaBbCcDdEeFfG.".mutableCopy;
    return @"Aa........FfGg..B.C.D.E........b.c.d.e..................".mutableCopy;
}

- (void)day11Part:(NSUInteger)part {
    self.floorCount = part == 1 ? 10 : 14;
    self.seenSet = [NSMutableSet set];
    
    NSMutableString *initialState = part == 1 ? [self inputPart1] : [self inputPart2];
    
    Node *rootNode = [Node new];
    rootNode.floor = 0;
    rootNode.stepCount = 0;
    rootNode.currentState = initialState;
    
    printf("Root state: \n");
    [self printArray:initialState];
    
    NSMutableArray *nodeQueue = @[rootNode].mutableCopy;
    while (nodeQueue.count > 0) {
        Node *node = nodeQueue.firstObject;
        printf("step count: %lu\n", (unsigned long)node.stepCount);
        [self printArray:node.currentState];
        BOOL isFinalState = part == 1 ? [self isFinalStatePart1ForString:node.currentState] : [self isFinalStatePart2ForString:node.currentState];
        if (isFinalState) {
            printf("final state step count: %lu\n", (unsigned long)node.stepCount);
            break;
        }
        NSMutableArray<Node *> *nextNodes = [self newStatesForNode:node];
        for (Node *nextNode in nextNodes) {
            [nodeQueue addObject:nextNode];
        }
        [nodeQueue removeObjectAtIndex:0];
    }
    
    printf("COMPLETED");
}

- (BOOL)isFinalStatePart1ForString:(NSString *)input {
    if ([input isEqualToString:@"..............................AaBbCcDdEe"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isFinalStatePart2ForString:(NSString *)input {
    if ([input isEqualToString:@"..........................................AaBbCcDdEeFfGg"]) {
        return YES;
    }
    return NO;
}

- (NSMutableArray<Node *> *)newStatesForNode:(Node *)node {
    NSMutableSet<Node *> *possibleNodes = [NSMutableSet set];
    NSUInteger currentFloor = node.floor;
    
    for (NSUInteger i = 0; i < self.floorCount; i++) {
        NSMutableString *floorString = [node.currentState substringWithRange:NSMakeRange(currentFloor * self.floorCount, self.floorCount)].mutableCopy;
        NSMutableString *firstElement = [floorString substringWithRange:NSMakeRange(i, 1)].mutableCopy;
        if ([firstElement isEqualToString:@"."]) {
            continue;
        }
        
        NSArray *floorOffset = nil;
        if (node.floor == 0) {
            floorOffset = @[@1];
        } else if (node.floor == 3) {
            floorOffset = @[@(-1)];
        } else {
            floorOffset = @[@1, @(-1)];
        }
        
        for (NSNumber *offset in floorOffset) {
            NSMutableString *newState = node.currentState.mutableCopy;
            Node *newNode = [Node new];
            NSUInteger newFloor = node.floor + offset.integerValue;
            newNode.floor = newFloor;
            newNode.stepCount = node.stepCount + 1;
            [newState replaceCharactersInRange:NSMakeRange(newFloor * self.floorCount + i, 1) withString:firstElement];
            [newState replaceCharactersInRange:NSMakeRange(currentFloor * self.floorCount + i, 1) withString:@"."];
            newNode.currentState = newState;
            [possibleNodes addObject:newNode];
            if (i < self.floorCount - 1) {
                for (NSUInteger j = i + 1; j < self.floorCount; j++) {
                    NSMutableString *secondElement = [floorString substringWithRange:NSMakeRange(j, 1)].mutableCopy;
                    if ([secondElement isEqualToString:@"."]) {
                        continue;
                    }
                    
                    Node *newNode2 = [Node new];
                    newNode2.floor = newFloor;
                    newNode2.stepCount = node.stepCount + 1;
                    NSMutableString *newState2 = node.currentState.mutableCopy;
                    [newState2 replaceCharactersInRange:NSMakeRange(newFloor * self.floorCount + i, 1) withString:firstElement];
                    [newState2 replaceCharactersInRange:NSMakeRange(newFloor * self.floorCount + j, 1) withString:secondElement];
                    [newState2 replaceCharactersInRange:NSMakeRange(currentFloor * self.floorCount + i, 1) withString:@"."];
                    [newState2 replaceCharactersInRange:NSMakeRange(currentFloor * self.floorCount + j, 1) withString:@"."];
                    newNode2.currentState = newState2;
                    [possibleNodes addObject:newNode2];
                }
            }
        }
    }
    
    NSMutableArray<Node *> *nextNodes = @[].mutableCopy;
    [possibleNodes enumerateObjectsUsingBlock:^(Node * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self isStateValid:obj.currentState]) {
            NSString *seenKey = [obj.currentState stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)obj.floor]];
            if (![self.seenSet containsObject:seenKey]) {
                [self.seenSet addObject:seenKey];
                [nextNodes addObject:obj];
            }
        }
    }];
    return nextNodes;
}

- (void)printArray:(NSString *)input {
    for (NSUInteger i = 0; i < 4; i++) {
        for (NSUInteger j = 0; j < self.floorCount; j++) {
            NSUInteger index = i * self.floorCount + j;
            NSString *element = [input substringWithRange:NSMakeRange(index, 1)];
            printf("%c ", [element characterAtIndex:0]);
        }
        printf("\n");
    }
    printf("\n");
}


- (BOOL)isStateValid:(NSString *)state {
    NSSet *cautionSet = self.floorCount == 10 ? [NSSet setWithArray:@[@"a", @"b", @"c", @"d", @"e"]] : [NSSet setWithArray:@[@"a", @"b", @"c", @"d", @"e", @"f", @"g"]];
    for (NSUInteger i = 0; i < 4; i++) {
        NSString *floor = [state substringWithRange:NSMakeRange(i * self.floorCount, self.floorCount)];
        for (NSUInteger j = 0; j < floor.length; j++) {;
            NSString *element = [floor substringWithRange:NSMakeRange(j, 1)];
            if ([cautionSet containsObject:element]) {
                if (![self safeForElement:element floor:floor]) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (BOOL)safeForElement:(NSString *)element floor:(NSString *)floor {
    if (![floor containsString:element]) {
        return YES;
    }
    
    if ([floor containsString:element.uppercaseString]) {
        return YES;
    }
    
    NSSet *dangerSet = self.floorCount == 10 ? [NSSet setWithArray:@[@"A", @"B", @"C", @"D", @"E"]] : [NSSet setWithArray:@[@"A", @"B", @"C", @"D", @"E", @"F", @"G"]];
    for (NSUInteger i = 0; i < floor.length; i++) {
        NSString *floorElement = [floor substringWithRange:NSMakeRange(i, 1)];
        if ([dangerSet containsObject:floorElement]) {
            return NO;
        }
    }
    return YES;
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
