//
//  ViewController.h
//  register-protection-iOS-sdk-demo
//
//  Created by NetEase on 16/12/20.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password_confirm;

@end

