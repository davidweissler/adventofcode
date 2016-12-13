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
@property (nonatomic) NSMutableArray<NSMutableArray<NSString *> *> *currentState;
@property (nonatomic) NSUInteger stepCount;
@end

@implementation Node

@end

@interface ViewController ()
@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) NSMutableSet *seenSet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day11];
}

- (NSMutableArray<NSMutableArray<NSString *> *> *)inputArray {
    return @[@[@"A", @"a", @".", @".", @".", @".", @".", @".", @".", @"."].mutableCopy,
             @[@".", @".", @"B", @".", @"C", @".", @"D", @".", @"E", @"."].mutableCopy,
             @[@".", @".", @".", @"b", @".", @"c", @".", @"d", @".", @"e"].mutableCopy,
             @[@".", @".", @".", @".", @".", @".", @".", @".", @".", @"."].mutableCopy].mutableCopy;
    
}

- (void)day11 {
    self.seenSet = [NSMutableSet set];
    
    NSMutableArray<NSMutableArray<NSString *> *> *initialState = [self inputArray];
    
    Node *rootNode = [Node new];
    rootNode.floor = 0;
    rootNode.stepCount = 0;
    rootNode.currentState = initialState;
    
    printf("Root state: \n");
    [self printArray:initialState];
    printf("\n");
    
    NSMutableArray *nodeQueue = @[rootNode].mutableCopy;
    while (nodeQueue.count > 0) {
        Node *node = nodeQueue.firstObject;
        [self printArray:node.currentState];
        BOOL isFinalState = [self isFinalStateForArray:node.currentState.lastObject];
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

- (NSString *)nodeAsString:(Node *)node {
    NSMutableString *nodeString = @"".mutableCopy;
    for (NSArray<NSString*> *floor in node.currentState) {
        [floor componentsJoinedByString:@""];
        [nodeString appendString:[floor componentsJoinedByString:@""]];
    }
    return nodeString;
}

- (BOOL)isFinalStateForArray:(NSMutableArray<NSString *> *)array {
    if ([array[0] isEqualToString:@"A"] &&
        [array[1] isEqualToString:@"a"] &&
        [array[2] isEqualToString:@"B"] &&
        [array[3] isEqualToString:@"b"] &&
        [array[4] isEqualToString:@"C"] &&
        [array[5] isEqualToString:@"c"] &&
        [array[6] isEqualToString:@"D"] &&
        [array[7] isEqualToString:@"d"] &&
        [array[8] isEqualToString:@"E"] &&
        [array[9] isEqualToString:@"e"]) {
        return YES;
    }
    return NO;
}

- (NSMutableArray<Node *> *)newStatesForNode:(Node *)node {
    NSMutableSet<Node *> *possibleNodes = [NSMutableSet set];
    NSUInteger currentFloor = node.floor;
    
    for (NSUInteger i = 0; i < node.currentState[0].count; i++) {
        NSMutableString *firstElement = node.currentState[currentFloor][i].mutableCopy;
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
            NSMutableArray<NSMutableArray<NSString *> *> *newState = @[].mutableCopy;
            // copy initial state to new state
            for (NSArray *floor in node.currentState) {
                NSMutableArray *newFloor = @[].mutableCopy;
                for (NSString *e in floor) {
                    [newFloor addObject:e.mutableCopy];
                }
                [newState addObject:newFloor];
            }
            
            Node *newNode = [Node new];
            NSUInteger newFloor = node.floor + offset.integerValue;
            newNode.floor = newFloor;
            newNode.stepCount = node.stepCount + 1;
            newState[newFloor][i] = firstElement;
            newState[currentFloor][i] = @".";
            newNode.currentState = newState;
            [possibleNodes addObject:newNode];
            if (i < node.currentState[0].count - 1) {
                for (NSUInteger j = i + 1; j < node.currentState[0].count; j++) {
                    NSMutableString *secondElement = node.currentState[currentFloor][j].mutableCopy;
                    if ([secondElement isEqualToString:@"."]) {
                        continue;
                    }
                    
                    Node *newNode2 = [Node new];
                    newNode2.floor = newFloor;
                    newNode2.stepCount = node.stepCount + 1;
                    NSMutableArray<NSMutableArray<NSString *> *> *newState2 = @[].mutableCopy;
                    for (NSArray *floor in node.currentState) {
                        NSMutableArray *newFloor = @[].mutableCopy;
                        for (NSString *e in floor) {
                            [newFloor addObject:e.mutableCopy];
                        }
                        [newState2 addObject:newFloor];
                    }
                    
                    newState2[newFloor][i] = firstElement;
                    newState2[newFloor][j] = secondElement;
                    newState2[currentFloor][i] = @".";
                    newState2[currentFloor][j] = @".";
                    newNode2.currentState = newState2;
                    [possibleNodes addObject:newNode2];
                }
            }
        }
    }
    
    NSMutableArray<Node *> *nextNodes = @[].mutableCopy;
    [possibleNodes enumerateObjectsUsingBlock:^(Node * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self isStateValid:obj.currentState]) {
            NSString *nodeAsString = [[self nodeAsString:obj] stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)obj.floor]];
            if (![self.seenSet containsObject:nodeAsString]) {
                [self.seenSet addObject:nodeAsString];
                [nextNodes addObject:obj];
            }
        }
    }];
    return nextNodes;
}


- (void)printArray:(NSArray<NSArray<NSString *> *> *)array {
    for (NSArray *floor in array) {
        for (NSString *element in floor) {
            printf("%c ", [element characterAtIndex:0]);
        }
        printf("\n");
    }
    printf("\n");
}

- (NSUInteger)moveableItemsOnFloor:(NSArray<NSString *> *)floor {
    NSUInteger counter = 0;
    for (NSString *element in floor) {
        if (![element isEqualToString:@"."]) {
            counter++;
        }
    }
    return counter;
}

- (BOOL)isStateValid:(NSArray<NSArray<NSString *> *> *)stateArray {
    NSSet *cautionSet = [NSSet setWithArray:@[@"a", @"b", @"c", @"d", @"e"]];
    for (NSArray<NSString *> *floor in stateArray) {
        for (NSString *floorElement in floor) {
            if ([cautionSet containsObject:floorElement]) {
                if (![self safeForElement:floorElement floor:floor]) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (BOOL)safeForElement:(NSString *)element floor:(NSArray<NSString *> *)floor {
    NSString *floorString = [floor componentsJoinedByString:@""];
    
    if (![floorString containsString:element]) {
        return YES;
    }
    
    if ([floorString containsString:element.uppercaseString]) {
        return YES;
    }
    
    NSSet *dangerSet = [NSSet setWithArray:@[@"A", @"B", @"C", @"D", @"E"]];
    for (NSString *floorElement in floor) {
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
