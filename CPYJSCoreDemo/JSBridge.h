//
//  JSBridge.h
//  CPYJSCoreDemo
//
//  Created by ciel on 2016/9/29.
//  Copyright © 2016年 CPY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSBridgeProtocol <JSExport>

- (NSInteger)add:(NSInteger)a b:(NSInteger)b;

@end

@interface JSBridge : NSObject<JSBridgeProtocol>


@end
