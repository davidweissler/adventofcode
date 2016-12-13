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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self day5];
}

- (void)day5 {
    NSString *doorId = @"ojvtpuvg";
    NSString *password = @"";
    for (NSUInteger i = 0; i < INT_MAX; i++) {
        NSString *append = [NSString stringWithFormat:@"%lu", (unsigned long)i];
        NSString *fullDoor = [doorId stringByAppendingString:append];
        NSString *md5 = [self md5:fullDoor];
        if ([[md5 substringToIndex:5] isEqualToString:@"00000"]) {
            NSLog(@"%@", md5);
            NSString *c = [md5 substringWithRange:NSMakeRange(5, 1)];
            password = [password stringByAppendingString:c];
        }
        if (password.length == 8) {
            break;
        }
    }
    NSLog(@"password: %@", password);
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
}

@end
