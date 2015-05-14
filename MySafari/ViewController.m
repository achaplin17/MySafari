//
//  ViewController.m
//  MySafari
//
//  Created by Anders Chaplin on 5/13/15.
//  Copyright (c) 2015 ___AndersChaplin___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButtonEnabler;
@property (weak, nonatomic) IBOutlet UIButton *forwardButtonEnabler;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.hidesBarsOnSwipe = YES;
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else{
        self.backButtonEnabler.enabled = NO;
    }
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
    else{
        self.forwardButtonEnabler.enabled = NO;
    }
}

- (IBAction)onStoppedLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (IBAction)onPlusButtonPressed:(UIButton *)sender {

    UIAlertView *alertView = [[UIAlertView alloc]init];
    alertView.title = @"New Features Coming Soon!";
    alertView.message = @"Including a better XCode!";
    [alertView addButtonWithTitle:@"Dismiss"];
    alertView.delegate = self;
    [alertView show];

}

#pragma mark - UITextField Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if([textField.text hasPrefix: @"http://"]) {
        NSURL *url = [NSURL URLWithString:textField.text];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    else {
          NSString *urlString = [NSString stringWithFormat:@"http://%@",textField.text];
        NSLog(@"%@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
       return YES;
}

#pragma mark - ScrollView Methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //if([self.urlTextField canResignFirstResponder]){
        [self.urlTextField becomeFirstResponder];
    //}

    
}



#pragma mark - ActivityMonitor Methods

- (void) webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView  {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



@end

