//
//  ViewController.m
//  day19
//
//  Created by David Weissler on 12/31/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"

@interface Node : NSObject

@property (nonatomic) Node *nextNode;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger position;
@end

@implementation Node

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day19];
}

- (void)day19 {
    
    NSUInteger elvesCount = 5; // test input
    elvesCount = 3004953; // part 1 input
    
    // Create all nodes
    Node *first = [Node new];
    first.count = 1;
    first.position = 1;
    
    Node *current = first;
    
    for (NSUInteger i = 1; i < elvesCount; i++) {
        Node *next = [Node new];
        next.count = 1;
        next.position = current.position + 1;
        current.nextNode = next;
        
        if (i == elvesCount - 1) {
            next.nextNode = first;
        }
        current = next;
    }
    
    // Start the game
    current = first;
    Node *halfwayElf = current.nextNode;
    Node *preHalfwarElf = nil;
    NSUInteger oppositeElfPosition = elvesCount/2;
    for (NSUInteger i = 1; i < oppositeElfPosition; i++) {
        if (i == oppositeElfPosition - 1) {
            preHalfwarElf = halfwayElf;
        }
        halfwayElf = halfwayElf.nextNode;
    }
    
    while (halfwayElf != current) {
        // NSLog(@"%lu steals %lu", current.position, halfwayElf.position);
        preHalfwarElf.nextNode = halfwayElf.nextNode;
        halfwayElf = halfwayElf.nextNode;
        
        elvesCount--;
        
        if (elvesCount % 2 == 0) {
            halfwayElf = halfwayElf.nextNode;
            preHalfwarElf = preHalfwarElf.nextNode;
        }
        
        current = current.nextNode;
    }
    
    NSLog(@"last node position: %lu", current.position);
}

@end
