//
//  ViewController.m
//  CPYJSCoreDemo
//
//  Created by ciel on 16/6/18.
//  Copyright © 2016年 CPY. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) JSContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSCoreDemo" ofType:@"html"];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    self.webView.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [context setExceptionHandler:^(JSContext *ctx, JSValue *expectValue) {
        NSLog(@"%@", expectValue);
    }];
    
    self.context = context;
    
    
    JSValue *returnValue = [JSValue valueWithObject:@"oc ahh" inContext:self.context];
    self.context[@"ocAlert"] = ^(JSValue *calback){
        sleep(2);
        [calback callWithArguments:nil];
    };
}


- (IBAction)buttonClick:(UIButton *)sender {
    if (!self.context) {
        return;
    }
    
    void (^block)(void) = ^{
        NSLog(@"js 回调了");
    };
    
    
    NSLog(@"按钮被点击了");
    JSValue *funcValue = self.context[@"alertFunc"];
    JSValue * jsReturnValue = [funcValue callWithArguments:@[[JSValue valueWithObject:block inContext:self.context]]];
    
    NSLog(@"js return value is %@", [jsReturnValue toString]);
    
    JSValue *jsString = self.context[@"jsString"];
    NSLog(@"js string var is %@", [jsString toString]);
    
    JSValue *jsBool = self.context[@"jsBool"];
    NSLog(@"js bool var is %d", [jsBool toBool]);
    
    JSValue *jsInt = self.context[@"jsInt"];
    NSLog(@"js int var is %d", [jsInt toInt32]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
