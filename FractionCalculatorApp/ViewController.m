//
//  ViewController.m
//  FractionCalculatorApp
//
//  Created by Simon Lam on 10/2/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import "ViewController.h"
#import "FractionCalculator.h"
@interface ViewController ()
- (IBAction)zero:(id)sender;
- (IBAction)one:(id)sender;
- (IBAction)two:(id)sender;
- (IBAction)three:(id)sender;
- (IBAction)four:(id)sender;
- (IBAction)five:(id)sender;
- (IBAction)six:(id)sender;
- (IBAction)seven:(id)sender;
- (IBAction)eight:(id)sender;
- (IBAction)nine:(id)sender;
- (IBAction)subtract:(id)sender;
- (IBAction)multiply:(id)sender;
- (IBAction)decimalize:(id)sender;
- (IBAction)mixedNumber:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *multiplyButton;
- (IBAction)add:(UIButton *)adder;
- (IBAction)divide:(id)sender;
- (IBAction)equals:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)signchange:(id)sender;
- (IBAction)simplify:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UIButton *divButton;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;

@property int fractionPosition;
@property int operation;
@property int digitPosition;
@property bool isAllClear;
@property bool isDecimal;
@property FractionCalculator *myFractionCalculator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myFractionCalculator = [[FractionCalculator alloc] init];
    self.display.text = [NSString stringWithFormat: @"  0"];
    self.fractionPosition = 0;
    self.digitPosition = 0;
    self.isAllClear = false;
    self.isDecimal = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)printFraction{
    if(self.fractionPosition<2){
        self.display.text = [NSString stringWithFormat: @"%d/%d", self.myFractionCalculator.storedFraction.numerator, self.myFractionCalculator.storedFraction.denominator];
    }else{
         self.display.text = [NSString stringWithFormat: @"%d/%d", self.myFractionCalculator.nextFraction.numerator, self.myFractionCalculator.nextFraction.denominator];
    }
}

-(void)inputNumber : (int) n{ //0: stored frac num, 1: stored frac den, 2: next frac num, 3: next frac den
    if(self.fractionPosition == 0){
        self.myFractionCalculator.storedFraction.numerator *= 10;
        self.myFractionCalculator.storedFraction.numerator += n;
    }
    if(self.fractionPosition == 1){
        self.myFractionCalculator.storedFraction.denominator *= 10;
        self.myFractionCalculator.storedFraction.denominator += n;
        [self.divButton setTitle:@"÷" forState:UIControlStateNormal]; //switches to division sign after first fraction is inputted.
    }
    if(self.fractionPosition == 2){
        self.myFractionCalculator.nextFraction.numerator *= 10;
        self.myFractionCalculator.nextFraction.numerator += n;
         [self.divButton setTitle:@"/" forState:UIControlStateNormal]; //switches back to fraction sign after the numerator of the second fraction is inputted.
        [self.divButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.divButton.backgroundColor = [UIColor colorWithRed:0.20 green:0.90 blue:0.35 alpha:1.0];
    }
    if(self.fractionPosition == 3){
        self.myFractionCalculator.nextFraction.denominator *= 10;
        self.myFractionCalculator.nextFraction.denominator += n;
    }
}

- (IBAction)zero:(id)sender {
    if(self.digitPosition>0){ //special case, cannot have 00000...
        [self inputNumber: 0];
        [self printFraction];
        self.digitPosition++;
    }
}

- (IBAction)one:(id)sender {
    [self inputNumber: 1];
    [self printFraction];
    self.digitPosition++;

}

- (IBAction)two:(id)sender {
    [self inputNumber: 2];
    [self printFraction];
    self.digitPosition++;
}
- (IBAction)three:(id)sender {
    [self inputNumber: 3];
    [self printFraction];
    self.digitPosition++;
}


- (IBAction)four:(id)sender {
    [self inputNumber: 4];
    [self printFraction];
    self.digitPosition++;
}

- (IBAction)five:(id)sender {
    [self inputNumber: 5];
    [self printFraction];
    self.digitPosition++;
}

- (IBAction)six:(id)sender {
    [self inputNumber: 6];
    [self printFraction];
    self.digitPosition++;
}

- (IBAction)seven:(id)sender {
    [self inputNumber: 7];
    [self printFraction];
    self.digitPosition++;
}

- (IBAction)eight:(id)sender {
    [self inputNumber: 8];
    [self printFraction];
    self.digitPosition++;
}

- (IBAction)nine:(id)sender {
    [self inputNumber: 9];
    [self printFraction];
    self.digitPosition++;
}

-(void) compute{
    [self clearOperationVisuals];
    [self.divButton setTitle:@"÷" forState:UIControlStateNormal]; //switch to division sign to extend upon fraction computed after first operation.
    if(self.operation == 4){
        [self.myFractionCalculator multiply:true];
        self.fractionPosition=1;
        [self printFraction];
    }
    if(self.operation == 1){
        [self.myFractionCalculator add:false];
        self.fractionPosition=1;
        [self printFraction];
        
    }
    if(self.operation == 2){
        [self.myFractionCalculator add:true];
        self.fractionPosition=1;
        [self printFraction];
    }
    if(self.operation== 3){
        [self.myFractionCalculator multiply:false];
        self.fractionPosition=1;
        [self printFraction];
    }
    [self.myFractionCalculator.nextFraction setTo:0 over: 0]; //for layering operations
}

-(void) inputOperation: (int) o{
    if(self.fractionPosition==1){
        [self clearOperationVisuals];
        self.operation = o; //1:add, 2:subtract, 3:multiply, 4:divide
        self.fractionPosition++;
        self.digitPosition=0;
    }
}

- (IBAction)equals:(id)sender {
    [self compute];
}

- (IBAction)add:(id)sender {
    if(self.fractionPosition ==3){ //when layering consecutive operations, user does not need to press equals at the end of each operation. By pressing the next operation button, the calculator automatically computes the previous operation.
        [self compute];
    }
    [self inputOperation: 1];
    self.addButton.backgroundColor = [UIColor yellowColor]; //when a button is pressed and the operation is stored, it changes appearance when the user is inputting the second (next) fraction as a reminder/indicator. Returns to normal appearance after operation is completed.
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (IBAction)subtract:(UIButton *)sender {
    if(self.fractionPosition ==3){
        [self compute];
    }
    [self inputOperation: 2];
    self.subButton.backgroundColor = [UIColor yellowColor];
    [self.subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (IBAction)multiply:(UIButton *)sender {
    if(self.fractionPosition ==3){
        [self compute];
        
    }
    [self inputOperation: 3];
    self.multiplyButton.backgroundColor = [UIColor yellowColor];
    [self.multiplyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (IBAction)divide:(id)sender {
    if(self.fractionPosition==3){
        [self compute];
    }
    if(self.fractionPosition==1){
        [self clearOperationVisuals];
        self.operation = 4;
        self.divButton.backgroundColor = [UIColor yellowColor];
        [self.divButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.fractionPosition++;
    
    self.digitPosition=0;
}

- (IBAction)decimalize:(UIButton *)sender {
    if(self.fractionPosition==1){
        if(!self.isDecimal){
            self.display.text = [NSString stringWithFormat: @"%f",[self.myFractionCalculator.storedFraction decimalize]];
            sender.backgroundColor = [UIColor yellowColor];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.isDecimal=true;
        }else{
            [self printFraction]; //reversible
            sender.backgroundColor = [UIColor colorWithRed:0.20 green:0.90 blue:0.35 alpha:1.0];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.isDecimal=false;
        }
    }
}


- (IBAction)mixedNumber:(UIButton *)sender {
    if(self.fractionPosition ==1){
        self.display.text = [NSString stringWithFormat: @"%d + %d/%d",[self.myFractionCalculator.storedFraction turnToMixedNum], self.myFractionCalculator.storedFraction.numerator,self.myFractionCalculator.storedFraction.denominator];
    }
}

- (IBAction)clear:(id)sender {//can clear (either the stored or next fraction) and clear all (both fractions)
    if(self.myFractionCalculator.storedFraction.numerator != 0 &&self.myFractionCalculator.storedFraction.denominator != 0){ //does not work when initial fraction is already cleared.
        if(self.isAllClear){
            [self.myFractionCalculator.storedFraction setTo:0 over: 0];
            [self.myFractionCalculator.nextFraction setTo:0 over: 0];
            self.fractionPosition = 0;
            self.digitPosition =0;
            self.isAllClear=false;
            [sender setTitle:@"C" forState:UIControlStateNormal];
            [self clearOperationVisuals];
        }else{
            if(self.fractionPosition<2){
                [self.myFractionCalculator.storedFraction setTo:0 over: 0];
                self.fractionPosition = 0;
                self.digitPosition =0;
            }else{
                [self.myFractionCalculator.nextFraction setTo:0 over: 0];
                self.fractionPosition = 2;
                self.digitPosition =0;
            }
            self.isAllClear=true;
            [sender setTitle:@"AC" forState:UIControlStateNormal];
           
        }
      [self.divButton setTitle:@"/" forState:UIControlStateNormal];
        [self printFraction];
    }
}

- (IBAction)signchange:(id)sender {
    if(self.fractionPosition<2){
        self.myFractionCalculator.storedFraction.numerator *= -1;
    }else{
        self.myFractionCalculator.nextFraction.numerator *= -1;
    }
    [self printFraction];
}

- (IBAction)simplify:(id)sender {
    if(self.fractionPosition==1){
        [self.myFractionCalculator.storedFraction simplify];
        [self printFraction];
    }
}

-(void)clearOperationVisuals{
    self.addButton.backgroundColor = [UIColor colorWithRed:0.20 green:0.90 blue:0.35 alpha:1.0];
    self.subButton.backgroundColor = [UIColor colorWithRed:0.20 green:0.90 blue:0.35 alpha:1.0];
    self.multiplyButton.backgroundColor = [UIColor colorWithRed:0.20 green:0.90 blue:0.35 alpha:1.0];
    [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.multiplyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
