//
//  EXPMatchers+equalSet.m
//  Cocode
//
//  Created by Kyle Fuller on 14/06/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

#import "Expecta+Comparison.h"

EXPMatcherImplementationBegin(equalSet, (NSSet * expected)) {
    match(^ BOOL {
        return [actual isEqualToSet:expected];
    });
    
    failureMessageForTo(^ NSString * {
        ExpectaComparisonDiff *diff = [[ExpectaComparisonDiff alloc] initWithActualObjects:[actual allObjects] expectedObjects:[expected allObjects]];
        
        NSMutableArray *diffMessages = [@[ @"\n" ] mutableCopy];
        
        if ([diff.removals count] > 0) {
            [diffMessages addObject:[NSString stringWithFormat:@"Set is missing objects: %@", [diff.removals componentsJoinedByString:@", "]]];
        }
        
        if ([diff.additions count] > 0) {
            [diffMessages addObject:[NSString stringWithFormat:@"Set has extra objects: %@", [diff.additions componentsJoinedByString:@", "]]];
        }
        
        NSString *message;
        if (diffMessages.count > 1) {
            message = [diffMessages componentsJoinedByString:@"\n"];
            
        } else {
            message = [NSString stringWithFormat:@"expected: %@, got: %@", EXPDescribeObject(expected), EXPDescribeObject(actual)];
        }
        
        return message;
    });
    
    failureMessageForNotTo(^ NSString * {
        return [NSString stringWithFormat:@"expected: not %@, got: %@", EXPDescribeObject(expected), EXPDescribeObject(actual)];
    });
}

EXPMatcherImplementationEnd
