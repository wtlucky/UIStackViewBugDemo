//
//  ViewController.m
//  StackViewBugDemo
//
//  Created by wtlucky on 10/9/15.
//  Copyright © 2015 forkingdog. All rights reserved.
//

#import "ViewController.h"
#import "FDStackView/FDStackView.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *ui_hidingImageView;
@property (nonatomic, strong) UIImageView *fd_hidingImageView;

@end

@implementation ViewController

- (UIImageView *)ui_hidingImageView {
    if (!_ui_hidingImageView) {
        _ui_hidingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forkingdog"]];
//        [_ui_hidingImageView addConstraint:[_ui_hiddingImageView.heightAnchor constraintEqualToConstant:100]];
    }
    return _ui_hidingImageView;
}

- (UIImageView *)fd_hidingImageView {
    if (!_fd_hidingImageView) {
        _fd_hidingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forkingdog"]];
//        [_fd_hidingImageView addConstraint:[_fd_hiddingImageView.heightAnchor constraintEqualToConstant:100]];
    }
    return _fd_hidingImageView;
}

- (NSArray<UIView *> *)demoViews {
    NSArray *demoTexts = @[@"四个文字", @"一", @"三个字"];
    NSMutableArray *demoViews = [NSMutableArray arrayWithCapacity:demoTexts.count];
    for (NSString *text in demoTexts) {
        UILabel *label = [UILabel new];
        label.text = text;
        label.backgroundColor = [UIColor lightGrayColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textAlignment = NSTextAlignmentCenter;
        [demoViews addObject:label];
    }
    return demoViews.copy;
}

- (void)createUIStackView {
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:self.demoViews];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;//UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionFillProportionally;
    stackView.spacing = 30.0f;
    [self.view addSubview:stackView];
    [stackView insertArrangedSubview:self.ui_hidingImageView atIndex:1];
    [self.view addConstraint:[self.view.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor]];
    [self.view addConstraint:[self.view.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor]];
    [self.view addConstraint:[self.view.topAnchor constraintEqualToAnchor:stackView.topAnchor constant:-60.0f]];
}

- (void)createFDStackView {
    FDStackView *stackView = [[FDStackView alloc] initWithArrangedSubviews:self.demoViews];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;// UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionFillProportionally;
    stackView.spacing = 30.0f;
    [self.view addSubview:stackView];
    [stackView insertArrangedSubview:self.fd_hidingImageView atIndex:1];
    [self.view addConstraint:[self.view.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor]];
    [self.view addConstraint:[self.view.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor]];
    [self.view addConstraint:[self.view.topAnchor constraintEqualToAnchor:stackView.topAnchor constant:-250.0f]];
}

- (void)createSwitcher {
    UILabel *guideLabel = [UILabel new];
    guideLabel.text = @"隐藏图片";
    guideLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:guideLabel];
    [self.view addConstraint:[self.view.bottomAnchor constraintEqualToAnchor:guideLabel.bottomAnchor constant:240.f]];
    [self.view addConstraint:[self.view.centerXAnchor constraintEqualToAnchor:guideLabel.centerXAnchor constant:40.f]];
    
    UISwitch *switcher = [[UISwitch alloc] init];
    switcher.translatesAutoresizingMaskIntoConstraints = NO;
    [switcher addTarget:self action:@selector(switcherValueChanged:) forControlEvents:UIControlEventValueChanged];
    switcher.on = NO;
    [self.view addSubview:switcher];
    [self.view addConstraint:[guideLabel.centerYAnchor constraintEqualToAnchor:switcher.centerYAnchor]];
    [self.view addConstraint:[self.view.centerXAnchor constraintEqualToAnchor:switcher.centerXAnchor constant:-20.f]];
}

- (void)switcherValueChanged:(UISwitch *)switcher {
    self.ui_hidingImageView.hidden = switcher.isOn;
    self.fd_hidingImageView.hidden = switcher.isOn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUIStackView];
    [self createFDStackView];
    [self createSwitcher];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
