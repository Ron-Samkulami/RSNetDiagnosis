//
//  RSViewController.m
//  RSNetDiagnosis
//
//  Created by Ron-Samkulami on 12/26/2023.
//  Copyright (c) 2023 Ron-Samkulami. All rights reserved.
//

#import "RSViewController.h"
#import <RSNetDiagnosis/RSNetDetector.h>

@interface RSViewController ()

@end

@implementation RSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 30)];
    label.text = @"Select Detect Type";
    [self.view addSubview:label];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, 150, 30)];
    [button1 setTitle:@"Detect Single Item" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(testSingleItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 150, 30)];
    [button2 setTitle:@"Detect Multi Items" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(testMultiItems) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testSingleItem
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Detect Single Item" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter host name";
        textField.text = [NSString stringWithFormat:@"www.baidu.com"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Domain Lookup" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *host = [[alert.textFields[0].text componentsSeparatedByCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] componentsJoinedByString:@""];
        [self lookupHost:host];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"TCP Ping" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *host = [[alert.textFields[0].text componentsSeparatedByCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] componentsJoinedByString:@""];
        [self tcpPingHost:host];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"ICMP Ping" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *host = [[alert.textFields[0].text componentsSeparatedByCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] componentsJoinedByString:@""];
        [self icmpPingHost:host];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"ICMP Traceroute" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *host = [[alert.textFields[0].text componentsSeparatedByCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] componentsJoinedByString:@""];
        [self icmpTracerouteHost:host];
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)testMultiItems
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Detect Multi Items" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter host name, separate by \",\"";
        textField.text = [NSString stringWithFormat:@"www.baidu.com, www.google.com"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Detect all items" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *host = [[alert.textFields[0].text componentsSeparatedByCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] componentsJoinedByString:@""];
        if (host.length <= 0) {
            return;
        }
        NSArray *hostList = [host componentsSeparatedByString:@","];
        
        [[RSNetDetector shared] detectHostList:hostList complete:^(NSString *detectLog) {
            NSLog(@"%@",detectLog);
            [[[UIAlertView alloc] initWithTitle:@"log" message:detectLog delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }];
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 单项检测

- (void)lookupHost:(NSString *)host
{
    [[RSNetDetector shared] dnsLookupWithHost:host complete:^(NSString * _Nonnull detectLog) {
        NSLog(@"%@",detectLog);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"DNS Lookup" message:detectLog delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        });
    }];
    
}


- (void)tcpPingHost:(NSString *)host
{
    [[RSNetDetector shared] tcpPingWithHost:host complete:^(NSString * _Nonnull detectLog) {
        NSLog(@"%@",detectLog);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"TCP Ping" message:detectLog delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        });
    }];
}

- (void)icmpPingHost:(NSString *)host
{
    [[RSNetDetector shared] icmpPingWithHost:host complete:^(NSString * _Nonnull detectLog) {
        NSLog(@"%@",detectLog);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"ICMP Ping" message:detectLog delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        });
    }];
}


- (void)icmpTracerouteHost:(NSString *)host
{
    [[RSNetDetector shared] icmpTracerouteWithHost:host complete:^(NSString * _Nonnull detectLog) {
        NSLog(@"%@",detectLog);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"ICMP Traceroute" message:detectLog delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        });
    }];
    
}

@end
