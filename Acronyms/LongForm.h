//
//  LongForm.h
//  Acronyms
//
//  Created by Shabarinath Pabba on 5/11/17.
//  Copyright © 2017 shabri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LongForm : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@property(nonatomic, strong) NSString *LFString;
@property(nonatomic, strong) NSString *frequency;
@property(nonatomic, strong) NSString *since;

@end
