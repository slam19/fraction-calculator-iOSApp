//
//  Fraction.h
//  FractionCalculator
//
//  Created by Simon Lam on 9/23/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef Fraction_h
#define Fraction_h
@interface Fraction: NSObject

@property int numerator, denominator;

-(double) decimalize;
-(void) simplify;
-(void) print;
-(int) turnToMixedNum; //returns whole number of mixed number
-(void) setTo: (int) n over: (int) d;
@end
#endif /* Fraction_h */
