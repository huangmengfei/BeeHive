//
//  BHTestViewController.m
//  BeeHive_Example
//
//  Created by huangmengfei on 2018/12/27.
//  Copyright © 2018年 一渡. All rights reserved.
//

#import "BHTestViewController.h"
#import "BeeHive.h"
#import "BHRouter.h"

@interface BHTestViewController ()

@end

@implementation BHTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)testJumpVCRegisterRoute {
    [[BHRouter globalRouter] addPathComponent:@"homeVC" forClass:NSClassFromString(@"BHServiceImpl01") handler:^(NSDictionary<NSString *,id> *params) {
        NSLog(@"BHRouter params = %@",params);
    }];
    
    NSError *parseError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"homeVC":@{@"rrrr":@"ffddd"}}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    
    
    NSString *s = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"com.alibaba.beehive://jump.vc.beehive/homeVC.BHServiceImplProtocol.push?params=%@",s];
    
    [BHRouter openURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] withParams:@{@"rt":@"ddd"} andThen:^(NSString *pathComponentKey, id obj, id returnValue) {
         NSLog(@"pathComponentKey = %@ \n obj = %@ \n returnValue = %@",pathComponentKey,obj,returnValue);
    }];
}



/**
 不需要addPathComponent,直接跳转VC,
 path为VC ClassName,params包含一个以VC ClassName为键值的dict，dict中的值一定是vc的属性
 */
- (void)testJumpVCUnRegisterRoute {
    NSError *parseError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"BHViewController":@{@"rrrr":@"ffddd"}}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    
    
    NSString *s = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *url = [[NSString stringWithFormat:@"com.alibaba.beehive://jump.vc.beehive/BHViewController?params=%@",s] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [BHRouter openURL:[NSURL URLWithString:url] withParams:@{@"rt":@"ddd"} andThen:^(NSString *pathComponentKey, id obj, id returnValue) {
        NSLog(@"pathComponentKey = %@ \n obj = %@ \n returnValue = %@",pathComponentKey,obj,returnValue);
    }];
}

- (void)testServiceRoute {
    
}

- (void)click {
    
    [self testJumpVCRegisterRoute];
    
}

@end
