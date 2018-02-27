//
//  LYDLogFormatter.m
//  NetWorkTest
//
//  Created by Running on 2018/2/8.
//  Copyright © 2018年 XiaoHai. All rights reserved.
//

#import "LYDLogFormatter.h"

@interface LYDLogFormatter ()<DDLogFormatter>

@property (nonatomic, strong) DDFileLogger * fileLogger;

@end

@implementation LYDLogFormatter
- (NSString * __nullable)formatLogMessage:(DDLogMessage *)logMessage NS_SWIFT_NAME(format(message:))
{
    NSString *loglevel = nil;
    switch (logMessage.flag)
    {
        case DDLogFlagError:
        {
            loglevel = @"[ERROR]";
        }
            break;
        case DDLogFlagWarning:
        {
            loglevel = @"[WARN]";
        }
            break;
        case DDLogFlagInfo:
        {
            loglevel = @"[INFO]";
        }
            break;
        case DDLogFlagDebug:
        {
            loglevel = @"[DEBUG]";
        }
            break;
        case DDLogFlagVerbose:
        {
            loglevel = @"[VBOSE]";
        }
            break;
            
        default:
            break;
    }
    NSString *formatStr = [NSString stringWithFormat:@"%@ %@ %@[line %ld] %@",logMessage->_timestamp, loglevel, logMessage->_function,logMessage->_line, logMessage->_message];
    return formatStr;
}

/**配置日志信息*/
- (void)logForLYDconfig {
      __weak typeof(self) weakSelf = self;
//    LYDLogFormatter *logFormatter = [[LYDLogFormatter alloc] init];
    DDFileLogger *fileLogger = self.fileLogger;
    [fileLogger setLogFormatter:weakSelf];
    [DDLog addLogger:fileLogger withLevel:DDLogLevelInfo];//确定写入到文件中的日志级别
    [[DDTTYLogger sharedInstance] setLogFormatter:weakSelf];
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    
}


/**
 *  初始化
 *
 *  @return 日志系统管理器对象
 */
+(instancetype)shareInstence
{
    static LYDLogFormatter *logmanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logmanager = [[self alloc] init];
    });
    return logmanager;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.fileLogger = [[DDFileLogger alloc] init];
        self.fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        self.fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        self.fileLogger.maximumFileSize = 1024 * 1024 * 2;
    }
    return self;
}

/*获得系统日志的路径**/
-(NSArray*)getLogPath
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * logPath = [docPath stringByAppendingPathComponent:@"Caches"];
    logPath = [logPath stringByAppendingPathComponent:@"Logs"];
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSError * error = nil;
    NSArray * fileList = [[NSArray alloc]init];
    fileList = [fileManger contentsOfDirectoryAtPath:logPath error:&error];
    NSMutableArray * listArray = [[NSMutableArray alloc]init];
    for (NSString * oneLogPath in fileList)
    {
        //带有工程名前缀的路径才是我们存储的日志路径
        if([oneLogPath hasPrefix:[NSBundle mainBundle].bundleIdentifier])
        {
            NSString * truePath = [logPath stringByAppendingPathComponent:oneLogPath];
            [listArray addObject:truePath];
        }
    }
    return listArray;
}
@end
