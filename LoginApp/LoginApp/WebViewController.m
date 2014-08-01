//
//  WebViewController.m
//  LoginApp
//
//  Created by Elias Haroun on 2014-07-08.
//  Copyright (c) 2014 Elias Haroun. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (strong,nonatomic) IBOutlet UIWebView* websiteView;
@end

@implementation WebViewController

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
    self.title = @"User area";

    NSURL *url = [NSURL URLWithString:@"http://appmonkeys.ca"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_websiteView loadRequest:request];

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
