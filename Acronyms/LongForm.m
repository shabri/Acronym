//
//  LongForm.m
//  Acronyms
//
//  Created by Shabarinath Pabba on 5/11/17.
//  Copyright © 2017 shabri. All rights reserved.
//

#import "LongForm.h"

@implementation LongForm

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]){
        
        self.LFString = dict[@"lf"];
        self.frequency = dict[@"freq"];
        self.since = dict[@"since"];
        
    }
    
    return self;
    
}

@end
