//
//  PhoneViewController.m
//  FISPhoneInCode
//
//  Created by Lukas Thoms on 7/20/15.
//  Copyright (c) 2015 Lukas Thoms. All rights reserved.
//

#import "PhoneViewController.h"
#import <Masonry.h>

@interface PhoneViewController ()

@property (strong, nonatomic) NSDictionary *buttons;
@property (strong, nonatomic) UITextField *numberField;
@property (strong, nonatomic) UIButton *xButton;

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Phone";
    
    
    UITextField *numberField = [[UITextField alloc] init];
    [self.view addSubview:numberField];
    numberField.textAlignment = NSTextAlignmentCenter;
    numberField.font = [UIFont boldSystemFontOfSize:36];
    [numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.offset(10);
        make.height.equalTo(@60);
        make.top.equalTo(self.mas_topLayoutGuide).with.offset(30);
    }];
    self.numberField = numberField;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Phone" image:nil selectedImage:nil];
    
    
    UIButton *x = [[UIButton alloc] init];
    [self.view addSubview:x];
    [x setTitle:@"X" forState:UIControlStateNormal];
    x.titleLabel.font = [UIFont systemFontOfSize:36];
    [x setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [x addTarget:self action:@selector(xTapped) forControlEvents:UIControlEventTouchUpInside];
    x.hidden = YES;
    [x mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numberField.mas_centerY);
        make.right.equalTo(self.view.mas_rightMargin).with.offset(-20);
    }];
    self.xButton = x;
    
    NSMutableDictionary *buttons = [@{}mutableCopy];
    for (NSUInteger i = 1; i<13; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [NSString stringWithFormat:@"%lu", (i)];
        if (i == 10) {
            title = @"*";
        } else if (i == 11) {
            title = @"0";
        } else if (i == 12) {
            title = @"#";
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:42];
        [button addTarget:self action:@selector(numberTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        NSString *dictionaryKey = [NSString stringWithFormat:@"_%lu", i];
        NSDictionary *buttonDictionary = @{dictionaryKey:button};
        [buttons addEntriesFromDictionary:buttonDictionary];
    }
    
    self.buttons = buttons;

    
    for (NSInteger i = 0; i<4; i++) {
        NSString *button1 = [NSString stringWithFormat:@"_%lu", ((i*3)+1)];
        NSString *button2 = [NSString stringWithFormat:@"_%lu", ((i*3)+2)];
        NSString *button3 = [NSString stringWithFormat:@"_%lu", ((i*3)+3)];
        NSString *visualFormat = [NSString stringWithFormat:@"|-[%@]-[%@(%@)]-[%@(%@)]-|", button1, button2, button1, button3, button1];
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:nil views:self.buttons];
        [self.view addConstraints:constraints];
        [self.buttons[button2] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).with.offset((i*80) - 30);
        }];
        [self.buttons[button1] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.buttons[button2]);
        }];
        [self.buttons[button3] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.buttons[button2]);
        }];
    }
    
    
}

-(void) numberTapped: (UIButton *) sender {
    NSString *currentString = self.numberField.text;
    NSString *newString = [NSString stringWithFormat:@"%@%@",currentString, sender.titleLabel.text];
    self.numberField.text = newString;
    self.xButton.hidden = NO;

}

-(void) xTapped {
    self.numberField.text = @"";
    self.xButton.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
