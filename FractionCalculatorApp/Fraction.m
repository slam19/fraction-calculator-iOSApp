//
//  Fraction.m
//  FractionCalculator
//
//  Created by Simon Lam on 9/23/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"

@implementation Fraction

-(double) convertToNum {
    if (self.denominator != 0)
        return (double) _numerator / self.denominator;
    else
        return NAN;
}
-(void) print{
    NSLog(@"%i/%i", self.numerator, self.denominator);
}

-(void) simplify{
    int u = self.numerator; int v = self.denominator; int temp;
    while (v != 0) {
        temp = u % v;
        u = v;
        v = temp;
    }
    self.numerator /= u;
    self.denominator /= u;
    if(self.denominator < 0){ //negative sign is assigned to denominator when fraction is negative, so we want to bring it up to numerator for stylistic purposes.
        self.denominator*= -1;
        self.numerator*= -1;
    }
}

-(double) decimalize {
    return (double) self.numerator/self.denominator;
}

-(int) turnToMixedNum{
    int n = 0; //whole number of mixed number
    if (self.numerator > self.denominator){
        n = self.numerator/self.denominator;
        self.numerator -= self.denominator* n;
    } //permanently reflects change
    return n;
}

-(void) setTo:(int) n over: (int) d {
    self.numerator = n;
    self.denominator = d;
}

@end
