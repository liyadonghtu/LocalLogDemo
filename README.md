# LocalLogDemo
运用CocoaLumberjack，实现日志不同级别，并以文件形式保存到本地的demo。

使用cocoapods，将CocoaLumberjack导入，Podfile看起来是这样的：

platform :ios, '9.3'
target 'NetWorkTest' do
 pod 'CocoaLumberjack'
end


1.将项目中的LYDLogFormatter的类拖入你需要使用的工程。
2.将LYDLogFormatter.h导入全局的宏文件。
3.在didFinishLaunchingWithOptions方法中实现如下代码
     [[LYDLogFormatter shareInstence] logForLYDconfig];
4.接着就可以随意的在全局中使用如下几种log日志
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");


补充：LYDLogFormatter类的实现中有如下代码可以控制写入文件中的日志级别
    [DDLog addLogger:fileLogger withLevel:DDLogLevelInfo];//确定写入到文件中的日志级别


