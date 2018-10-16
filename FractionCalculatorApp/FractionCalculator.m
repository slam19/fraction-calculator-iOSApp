//
//  FractionCalculator.m
//  FractionCalculator
//
//  Created by Simon Lam on 9/23/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FractionCalculator.h"
#import "Fraction.h"
@implementation FractionCalculator

-(id) init{
    self = [super init];
    if (self){
        //NSLog(@"I am now setting up a fraction calculator..");
        self.storedFraction= [[Fraction alloc] init];
        self.nextFraction = [[Fraction alloc] init];
    }
    return self;
}

-(void)inputFraction{
    int n;  int d;
    NSLog(@"Input numerator:");
    scanf("%i", &n);
    NSLog(@"Input denominator:");
    scanf("%i", &d);
    [self.nextFraction setTo:n over:d];
  //  NSLog(@"%i",self.nextFraction.numerator);
  //  NSLog(@"%i",self.nextFraction.denominator);
}

-(void) saveFirstFraction{
    self.storedFraction.numerator= self.nextFraction.numerator;
    self.storedFraction.denominator=self.nextFraction.denominator;
}
-(void) add : (bool) isSubtraction{
    if(isSubtraction){
        self.nextFraction.numerator *= -1;
    }
    NSLog(@"the two fractions are : %i/%i, and %i/%i", self.storedFraction.numerator, self.storedFraction.denominator, self.nextFraction.numerator, self.nextFraction.denominator);
    int a = self.nextFraction.denominator;
    int b = self.storedFraction.denominator;
    if(a != b){
        self.nextFraction.denominator *= b;
        self.nextFraction.numerator *= b;
        self.storedFraction.numerator *= a;
        self.storedFraction.denominator *= a;
    }
    NSLog(@"the two fractions are : %i/%i, and %i/%i", self.storedFraction.numerator, self.storedFraction.denominator, self.nextFraction.numerator, self.nextFraction.denominator);
    self.storedFraction.numerator += self.nextFraction.numerator;
    [self.storedFraction simplify];
    NSLog(@"The new fraction is %i/%i.", self.storedFraction.numerator, self.storedFraction.denominator);
}

-(void) multiply: (bool) isDivision{
    if(isDivision){ //flip numerator and denominator.
        int n = self.nextFraction.numerator;
        self.nextFraction.numerator= self.nextFraction.denominator;
        self.nextFraction.denominator = n;
    }
    self.storedFraction.numerator *= self.nextFraction.numerator;
    self.storedFraction.denominator *= self.nextFraction.denominator;
   [self.storedFraction simplify];
    NSLog(@"The new fraction is %i/%i.", self.storedFraction.numerator, self.storedFraction.denominator);
}

@end
