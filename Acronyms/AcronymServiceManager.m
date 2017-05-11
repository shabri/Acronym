//
//  AcronymServiceManager.m
//  Acronyms
//
//  Created by Shabarinath Pabba on 5/11/17.
//  Copyright © 2017 shabri. All rights reserved.
//

#define kURLString @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@"

#import "AcronymServiceManager.h"
#import "Meanings.h"
#import "LongForm.h"

@implementation AcronymServiceManager

+ (instancetype)sharedInstance
{
    static AcronymServiceManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AcronymServiceManager alloc] init];
    });
    return sharedInstance;
}

-(void)getMeaningsFor:(NSString *)acronym success:(void (^)(Meanings* meanings))completionBlock failure:(void (^)(NSError *error))failureBlock{
    
    NSString *urlString = [NSString stringWithFormat:kURLString, acronym];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (url && url.scheme && url.host) {//check validity or url
        NSURLSession *urlSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *urlDataTask = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                if (error) {
                    failureBlock(error);
                }else{
                    if (((NSHTTPURLResponse *)response).statusCode == 200) {
                        NSError *error;
                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        NSLog(@"%@", json);
                        
                        if(error == nil){
                            
                            Meanings *meanings = [[Meanings alloc] init];
                            NSDictionary *firstDictionary = [((NSArray *)json) objectAtIndex:0];
                            NSArray *lfs = firstDictionary[@"lfs"];
                            
                            for (NSDictionary *dict in lfs) {
                                LongForm *lf = [[LongForm alloc] initWithDictionary:dict];
                                [meanings.list addObject:lf];
                            }
                            
                            completionBlock(meanings);
                        }
                        else{
                            NSError *serializingError = [NSError errorWithDomain:@"" code:10005 userInfo:@{ NSLocalizedDescriptionKey : @"Failed serializing data"}];
                            failureBlock(serializingError);
                        }
                    }
                }
                
            });
            
        }];
        [urlDataTask resume];
    }else{
        //Not a valid url
        NSError *error = [NSError errorWithDomain:@"" code:10006 userInfo:@{ NSLocalizedDescriptionKey : @"Not a valid url"}];
        failureBlock(error);
    }
    
}

@end
