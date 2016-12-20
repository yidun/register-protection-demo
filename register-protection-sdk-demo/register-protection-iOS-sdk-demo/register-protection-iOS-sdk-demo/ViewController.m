//
//  ViewController.m
//  register-protection-iOS-sdk-demo
//
//  Created by NetEase on 16/12/20.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import <Guardian/NTESCSGuardian.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.username.delegate = self;
    self.nickname.delegate = self;
    self.password.delegate = self;
    self.password_confirm.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NTESCSGuardian setBussinessId:@"YOUR_BUSINESS_ID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSString *token = [NTESCSGuardian getToken:3];
    NSAssert(token != nil, @"token is nil，fatal error");
    
    NSString *username = [self.username text];
    if(!username) username = @"";
    NSString *nickname = [self.nickname text];
    if(!nickname) nickname = @"";
    NSString *password = [self.password text];
    if(!password) password = @"";
    NSString *password_confirm = [self.password_confirm text];
    if(!password_confirm) password_confirm = @"";
    
    NSString *postString = [NSString stringWithFormat:@"token=%@&username=%@&nickname=%@&password=%@&password_confirm=%@",
                            [self urlEncode:token],
                            [self urlEncode:username],
                            [self urlEncode:nickname],
                            [self urlEncode:password],
                            [self urlEncode:password_confirm]];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8183/register.do"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10.0];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postString length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *alertString = nil;
        if(error) {
            alertString = [NSString stringWithFormat:@"error: %@", [error description]];
        } else {
            alertString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlert:alertString];
        });
    }];
    [postDataTask resume];
}

- (NSString *)urlEncode:(NSString *)string {
    if(!string || ![string length]) {
        return nil;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    NSString *encoded = (__bridge_transfer NSString *)
    CFURLCreateStringByAddingPercentEscapes(
                                            kCFAllocatorDefault,
                                            (__bridge CFStringRef)string,
                                            NULL,
                                            CFSTR("!#$&'()*+,/:;=?@[]"),
                                            cfEncoding);
    return encoded;
#pragma clang diagnostic pop
}

- (void)showAlert:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
