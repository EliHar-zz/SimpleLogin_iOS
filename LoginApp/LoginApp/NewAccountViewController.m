//
//  NewAccountViewController.m
//  LoginApp
//
//  Created by Elias Haroun on 2014-07-08.
//  Copyright (c) 2014 Elias Haroun. All rights reserved.
//

#import "NewAccountViewController.h"

@interface NewAccountViewController ()
@property (strong,nonatomic) IBOutlet UITextField* firstnameTF;
@property (strong,nonatomic) IBOutlet UITextField* lastnameTF;
@property (strong,nonatomic) IBOutlet UITextField* usernameTF;
@property (strong,nonatomic) IBOutlet UITextField* passwordTF;
@property (strong,nonatomic) IBOutlet UITextField* emailTF;

@end

@implementation NewAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Create Account";

}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
}

-(IBAction)createAccount:(UIButton*)sender {
    
    NSURL *actionURL = [NSURL URLWithString:@"API-Site"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:actionURL];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSString *firstname = [NSString stringWithFormat:@"first_name=%@&",_firstnameTF.text];
    NSString *lastname = [NSString stringWithFormat:@"last_name=%@&",_lastnameTF.text];
    NSString *username = [NSString stringWithFormat:@"user_name=%@&",_usernameTF.text];
    NSString *password = [NSString stringWithFormat:@"password=%@&",_passwordTF.text];
    NSString *email = [NSString stringWithFormat:@"email=%@",_emailTF.text];

    NSMutableData *data = [NSMutableData data];
    
    [data appendData:[firstname dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[lastname dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[username dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[password dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[email dataUsingEncoding:NSUTF8StringEncoding]];

    NSLog(@"%@",data);
    
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Account Created Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
    [[self navigationController] popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
