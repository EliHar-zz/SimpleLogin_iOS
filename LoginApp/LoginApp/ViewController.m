//
//  ViewController.m
//  LoginApp
//
//  Created by Elias Haroun on 2014-07-08.
//  Copyright (c) 2014 Elias Haroun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) IBOutlet UITextField* usernameTF;
@property (strong,nonatomic) IBOutlet UITextField* passwordTF;
@property (strong,nonatomic) NSString *enteredPassword;

@property NSArray *jsonArray;
@property NSMutableData *data;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Login";
}

-(IBAction)createAccount:(UIButton*)sender {
    [self performSegueWithIdentifier:@"tocreate" sender:self];
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
}

-(IBAction)login:(UIButton*)sender {
    
    NSLog(@"%@",_usernameTF.text);
    NSLog(@"%@",_passwordTF.text);
    
    NSURL *actionURL = [NSURL URLWithString:@"API-Site"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:actionURL];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSString *username = [NSString stringWithFormat:@"user_name=%@",_usernameTF.text];
    NSData *data = [username dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",data);
    
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start];
     
    //Search option
    /*
    NSLog(@"%@",_usernameTF.text);
    
    NSURL *actionURL = [NSURL URLWithString:@"API-Site"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:actionURL];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSString *postString = [NSString stringWithFormat: @"querryString=arr[]=%@",_usernameTF.text];
    [postString stringByReplacingOccurrencesOfString:@" " withString:@"&arr[]="];
    
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",data);
    
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start];
     */
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _data = [NSMutableData new];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)newData {
    [_data appendData:newData];
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    _jsonArray = [NSJSONSerialization JSONObjectWithData:_data options:nil error:nil];
    
    NSDictionary *user = [_jsonArray objectAtIndex:0];
    
    NSString *dbPassword = [user objectForKey:@"password"];
    NSLog(@"database password is: %@",dbPassword);
    
    _enteredPassword = _passwordTF.text;
    
    if ([_enteredPassword isEqualToString:dbPassword]) {
        [self performSegueWithIdentifier:@"toweb" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password is wrong" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet Connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
