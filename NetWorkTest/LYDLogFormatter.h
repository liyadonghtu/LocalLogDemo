//
//  LYDLogFormatter.h
//  NetWorkTest
//
//  Created by Running on 2018/2/8.
//  Copyright © 2018年 XiaoHai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif

@interface LYDLogFormatter : NSObject
/**
 *  初始化
 *
 *  @return 日志系统管理器对象
 */
+(instancetype)shareInstence;

/*获得系统日志的路径**/
-(NSArray*)getLogPath;

/**配置日志信息*/
- (void)logForLYDconfig;


@end
