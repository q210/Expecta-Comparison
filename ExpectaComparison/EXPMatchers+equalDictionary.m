//
//  EXPMatchers+equalDictionary.m
//  Cocode
//
//  Created by Kyle Fuller on 14/06/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

#import "EXPMatchers+equalDictionary.h"

EXPMatcherImplementationBegin(equalDictionary, (NSDictionary * expected)) {
    match(^ BOOL {
        return [actual isEqualToDictionary:expected];
    });
    
    failureMessageForTo(^ NSString * {
        NSSet *actualKeys = [NSSet setWithArray:[(NSDictionary *)actual allKeys]];
        NSSet *keys = [NSSet setWithArray:[(NSDictionary *)expected allKeys]];
        
        NSMutableArray *diffMessages = [@[ @"\n" ] mutableCopy];
        
        if ([actualKeys isEqualToSet:keys] == NO) {
            NSMutableSet *missingKeys = [keys mutableCopy];
            [missingKeys minusSet:actualKeys];
            
            NSMutableSet *extraKeys = [actualKeys mutableCopy];
            [extraKeys minusSet:keys];
            
            if ([missingKeys count] > 0) {
                [diffMessages addObject:[NSString stringWithFormat:@"Dictionary is missing keys: %@", [[missingKeys allObjects] componentsJoinedByString:@", "]]];
            }
            
            if ([extraKeys count] > 0) {
                [diffMessages addObject:[NSString stringWithFormat:@"Dictionary has extra keys: %@", [[extraKeys allObjects] componentsJoinedByString:@", "]]];
            }
        }
        
        NSString *message;
        if (diffMessages.count > 1) {
            message = [diffMessages componentsJoinedByString:@"\n"];
            
        } else {
            NSString *message = [NSString stringWithFormat:@"expected: %@, got: %@", EXPDescribeObject(expected), EXPDescribeObject(actual)];
        }
        
        return message;
    });
    
    failureMessageForNotTo(^ NSString * {
        return [NSString stringWithFormat:@"expected: not %@, got: %@", EXPDescribeObject(expected), EXPDescribeObject(actual)];
    });
}

EXPMatcherImplementationEnd
