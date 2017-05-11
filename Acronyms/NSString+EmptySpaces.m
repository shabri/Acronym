//
//  NSString+EmptySpaces.m
//  Acronyms
//
//  Created by Shabarinath Pabba on 5/11/17.
//  Copyright © 2017 shabri. All rights reserved.
//

#import "NSString+EmptySpaces.h"

@implementation NSString (EmptySpaces)

-(BOOL)isJustSpaces{
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        // it's empty or contains only white spaces
        return true;
    }
    
    return false;
    
}

@end
