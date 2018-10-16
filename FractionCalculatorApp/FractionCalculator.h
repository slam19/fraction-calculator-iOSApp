//
//  FractionCalculator.h
//  FractionCalculator
//
//  Created by Simon Lam on 9/23/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef FractionCalculator_h
#define FractionCalculator_h

#import "Fraction.h"
@interface FractionCalculator: NSObject

@property Fraction *storedFraction;
@property Fraction *nextFraction;

-(void) add : (bool) isSubtraction;
-(void) inputFraction;
-(void) saveFirstFraction;
-(void) multiply : (bool) isDivision;
@end
#endif /* FractionCalculator_h */
