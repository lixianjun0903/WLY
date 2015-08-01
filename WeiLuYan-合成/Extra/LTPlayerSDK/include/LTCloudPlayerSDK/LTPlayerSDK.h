//
//  LTPlayerSDK.h
//  LetvIphoneClient
//
//  Created by Letv on 13-11-26.
//
//

#import <Foundation/Foundation.h>
//#import "LTPlayerSDK+LTCloudPlayer.h"

/* --------------SDK使用说明--------------------- */
/*
 * 1. 此SDK支持iOS5.0及以上版本
 *
 * 2. 使用此SDK时，除已提供的静态库外，需引用以下苹果官方库：
 *    AudioToolbox.framework
 *    MediaPlayer.framework
 *    UIKit.framework
 *    CoreGraphics.framework
 *    Foundation.framework
 *    ImageIO.framework
 *    SystemConfiguration.framework
 *    CoreTelephony.framework
 *    AdSupport.framework
 *    CoreFoundation.framework
 *    libz.dylib
 *    libicucore.dylib
 *    libc++.dylib    
 *    libstdc++.sylib   如果编译报错 建议使用 libstdc++.6.0.9.dylib 
 
 * 3. 使用此SDK时，需在工程Build Settings下，Linking中的Other Linker Flag添加-ObjC
 */
/* --------------------------------------------- */


/* 视频码流 */
typedef NS_ENUM(NSInteger, LTVideoCodeType)
{
    LTVideoCodeTypeUnknown  = 0,    // 未知
    
    LTVideoCodeTypeLD       = 1,    // 流畅
    LTVideoCodeTypeSD       = 2,    // 高清
    LTVideoCodeTypeHD       = 3,    // 超清
    LTVideoCodeTypeOD       = 4     // 原画
};

typedef NS_ENUM (NSInteger, LTCloudPlayerErrorType){
    LTCloudPlayerErrorTypeNone,
    LTCloudPlayerErrorTypeFailedToGetData,         // 获取数据失败
    LTCloudPlayerErrorTypeDataError,               // 数据错误
    LTCloudPlayerErrorTypeNetWorkFailure,          // 网络连接失败
    LTCloudPlayerErrorTypeParseUrlFailure,         // 解析url失败
    LTCloudPlayerErrorTypeNoNextVideo,             //
    LTCloudPlayerErrorTypeOther,                   // 其它
};

typedef enum {
    LTMoviePlayerShowStyleFullScreen,
    LTMoviePlayerShowStyleCustomSize
}LTMoviePlayerShowStyle;

@protocol LTPlayerDelegate <NSObject>

@optional

- (void)LTPlayerStartToPlay;            // 视频开始播放
- (void)LTPlayerFailed;                 // 视频播放失败
- (void)LTPlayerDidFinishedWithUserUnique:(NSString *)userUnique
                              videoUnique:(NSString *)videoUnique
                                videoName:(NSString *)videoName
                                       ap:(BOOL)ap;                         // 播放完成
- (NSTimeInterval) LTPlayerGetCurrentPlaybackTime:(NSString*)vid;           // 设置播放器开始播放的开始时间
- (void)LTPlayerSetCurrentPlayBackTime:(NSTimeInterval)currentPlaybackTime
                               withVid:(NSString*)vid
                             withTitle:(NSString*)title
                            withWebUrl:(NSString*)webUrl
                          withDuration:(NSTimeInterval)duration;            // 实时获取播放进度
- (void) LTPlayerViewTopBackBtnClickEvent;                                  // 全屏播放视图时顶部的返回按钮
- (void) LTPlayerViewFullBtnClickEvent;                                     // 半屏界面全屏按钮切换事件
- (void) LTPlayerViewErrorWithType:(LTCloudPlayerErrorType) type;           // 播放错误
-(void)LTPlayergetVideoInfoComplete:(LTVideoCodeType)codeType videoId:(NSString *)videoId videoName:(NSString *)videoName url:(NSString *)playUrl;
@end

@interface LTPlayerSDK : NSObject


/*
 @abstract		播放器显示
 @discussion
 @param         userUnique - 乐视云视频分配用户唯一标识
 @param			videoUnique － 视频唯一标识
 @param			videoName － 视频名称
 @param			playerDelegate － 播放器回调
 @param         ap  是否自动播放
 */

+ (void)showWithUserUnique:(NSString *)userUnique
               videoUnique:(NSString *)videoUnique
                 videoName:(NSString *)videoName
                 payerName:(NSString *)payerName
                 checkCode:(NSString *)checkCode
                        ap:(BOOL)ap
          inViewController:(UIViewController *)viewController
            playerDelegate:(id<LTPlayerDelegate>)playerDelegate;


+ (void)showPlayerWithVideoCodeType:(LTVideoCodeType)codeType
               videoId:(NSString *)vid
                 playUrl:(NSString *)url
                videoName:(NSString *)vName
          inViewController:(UIViewController *)viewController
            playerDelegate:(id<LTPlayerDelegate>)playerDelegate;

/*
 @abstract		播放器销毁
 @discussion
 */
+ (void)dismiss:(BOOL)animated;
+ (NSTimeInterval)LTPlayerGetVideoDuration;         // 获取播放时长

+ (void)play;
+ (void)pause;
+ (void)setPlayControlViewHide:(BOOL)isHide;

+ (float)getPlayerVolume;                           // 获取当前播放器的声音的大小
+ (void) setPlayerVolume:(float)volume;             // 设置播放器的声音

+ (void) startPlayerService;                        // 启动UTPService
+ (void) checkPlayerServiceIsEnale;                 // 检查服务器的状态

+ (UIView *) getPlayerView;                         // 获取播放器界面的View
+ (void) setPlayerViewFrame:(CGRect)frame;          // 设置播放器View的大小


+ (void) setMoviePlayerShowStyle:(LTMoviePlayerShowStyle) moviePlayerShowStyle; //  播放器的显示风格
+ (LTMoviePlayerShowStyle) getMoviePlayerShowStyle;

+ (void) setMoviePlayerPlayeBackTime:(NSInteger)time; // 选择播放器播放的时间

+ (NSString *) getLTPlayerSDKVersion;  // 获取当前SDK的版本号

@end