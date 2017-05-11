//
//  AcronymServiceManager.h
//  Acronyms
//
//  Created by Shabarinath Pabba on 5/11/17.
//  Copyright © 2017 shabri. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Meanings;

@interface AcronymServiceManager : NSObject

+ (instancetype)sharedInstance;

-(void)getMeaningsFor:(NSString *)acronym success:(void (^)(Meanings* meanings))completionBlock failure:(void (^)(NSError *error))failureBlock;

@end
