//
//  ViewController.m
//  day05
//
//  Created by David Weissler on 12/12/16.
//  Copyright © 2016 David Weissler. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>

@interface ViewController ()

@property (nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self day5];
}

- (void)day5 {
    NSString *doorId = @"ojvtpuvg";
    NSMutableArray<NSString *> *password = @[@".",@".",@".",@".",@".",@".",@".",@"."].mutableCopy;
    NSUInteger counter = 0;
    for (NSUInteger i = 0; i < INT_MAX; i++) {
        NSString *append = [NSString stringWithFormat:@"%lu", (unsigned long)i];
        NSString *fullDoor = [doorId stringByAppendingString:append];
        NSString *md5 = [self md5:fullDoor];
        if ([[md5 substringToIndex:5] isEqualToString:@"00000"]) {
            NSString *c = [md5 substringWithRange:NSMakeRange(5, 1)];
            NSNumber *num = [self numberFromString:c];
            if (num && num.integerValue < 8 && [password[num.integerValue] isEqualToString:@"."]) {
                password[num.integerValue] = [md5 substringWithRange:NSMakeRange(6,1)];
                NSLog(@"password: %@", [password componentsJoinedByString:@""]);
                counter++;
            }
        }
        if (counter == 8) {
            break;
        }
    }
    NSLog(@"password: %@", [password componentsJoinedByString:@""]);
}

- (NSString *)md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
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

@end
