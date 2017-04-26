//
//  EXPMatchers+equalArray.m
//  Cocode
//
//  Created by Kyle Fuller on 14/06/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

#import "Expecta+Comparison.h"

EXPMatcherImplementationBegin(equalArray, (NSArray * expected)) {
    match(^ BOOL {
        return [actual isEqualToArray:expected];
    });
    
    failureMessageForTo(^ NSString * {
        ExpectaComparisonDiff *diff = [[ExpectaComparisonDiff alloc] initWithActualObjects:actual expectedObjects:expected];
        
        NSMutableArray *diffMessages = [@[ @"\n" ] mutableCopy];
        
        if ([diff.removals count] > 0) {
            [diffMessages addObject:[NSString stringWithFormat:@"Array is missing objects: %@", [diff.removals componentsJoinedByString:@", "]]];
        }
        
        if ([diff.additions count] > 0) {
            [diffMessages addObject:[NSString stringWithFormat:@"Array has extra objects: %@", [diff.additions componentsJoinedByString:@", "]]];
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
