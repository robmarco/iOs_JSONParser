//
//  WebDetailViewController.m
//  JSONParserRM
//
//  Created by Roberto Marco on 31/03/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "WebDetailViewController.h"

@interface WebDetailViewController ()

@end

@implementation WebDetailViewController

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
    
    // Navigation Bar Configuration
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_bg.png"]]];
    
    // WebView Configuration
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate Methods

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self.activityIndicator stopAnimating];
    [self.labelLoading setHidden:YES];
    
    if (error.code == NSURLErrorCancelled)
        return;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
    [self.labelLoading setHidden:NO];
    [self.activityIndicator setHidesWhenStopped:YES];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [self.labelLoading setHidden:YES];
    
    [self activateWebViewButtons];
}

#pragma mark - Private Methods

-(void) activateWebViewButtons {
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
    self.stopButton.enabled = self.webView.loading;
}

- (IBAction)goBack:(id)sender {
    if (self.backButton.enabled)
        [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    if (self.forwardButton.enabled)
        [self.webView goForward];
}

- (IBAction)goRefresh:(id)sender {
    [self.webView reload];
}

- (IBAction)goStop:(id)sender {
    [self.webView stopLoading];
}
@end
