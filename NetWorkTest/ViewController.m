//
//  ViewController.m
//  NetWorkTest
//
//  Created by Running on 2018/1/21.
//  Copyright © 2018年 XiaoHai. All rights reserved.
//

#import "ViewController.h"
#import "UIKit+AFNetworking.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <MessageUI/MessageUI.h>

@interface ViewController () <MFMailComposeViewControllerDelegate>



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(50, 100, 200, 50);
    [testBtn setTitle:@"添加日志" forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[UIColor greenColor]];
    [testBtn addTarget:self action:@selector(handlButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    
    UIButton *testBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn2.frame = CGRectMake(50, 100, 200, 50);
    [testBtn2 setTitle:@"反馈日志" forState:UIControlStateNormal];
    [testBtn2 setBackgroundColor:[UIColor greenColor]];
    [testBtn2 addTarget:self action:@selector(backLog:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn2];
    
    
}

- (void)handlButtonAction:(id)sender {
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
    
    
}


- (void)backLog:(id)sender {
    DDLogInfo(@"用户反馈日志报告");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:1965661720@qq.com"] options:@{} completionHandler:^(BOOL success) {
        
        DDLogInfo(@"邮件发送成功");
        
    }];
    
//    MFMailComposeViewController* mailController = [[MFMailComposeViewController alloc] init];
//
//    if (mailController) {  // 如果没有设置邮件帐户，mailController 为nil
//
//        mailController.mailComposeDelegate = self;
//        [mailController setSubject:@"日志反馈"];
//        [mailController setToRecipients:@[@"example@example.com"]];
//        [self mailComposeController:mailController didFinishWithResult:nil error:nil];
//    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

