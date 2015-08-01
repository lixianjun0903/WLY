#import "AFHTTPRequestOperationManager.h"

@interface AFRequestState : NSObject

-(AFRequestState *)addNotifaction:(id)notify;
@property (readonly)BOOL running;
@end

@interface AFAppRequest : AFHTTPRequestOperationManager

+(AFAppRequest*)sharedClient;
+(AFHTTPRequestOperationManager *)sharedManager;

+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ;

+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail;

+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ resp:(Class)resp;

+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail resp:(Class)resp;

//上传头像
+(AFRequestState *)postImageFlag:(BOOL)flag url:(NSString *)url succ:(void(^)(id img))succ WithData:(NSDictionary *)data fail:(void (^)(int errCode, NSError * err))fail;

//批量上传图片
+(AFRequestState *)postImagesFlag:(BOOL)flag url:(NSString *)url succ:(void(^)(id img))succ WithData:(NSArray *)data fail:(void (^)(int errCode, NSError * err))fail;

+(NSMutableDictionary*)getURLSign:(NSString*)path;
+(NSMutableDictionary*)getURLSignaAndTokenDic:(NSString*)path;

+(AFRequestState *)postRequestWithPost:(NSString *)url param:(NSDictionary *)param succ:(void (^)(NSDictionary*dic))succ fail:(void (^)(int errCode, NSError * err))fail resp:(Class)resp;


/////网络请求更新12.15///////////////

+(AFRequestState *)postRequestWithlogRequest:(NSString *)url param:(NSDictionary *)param saveData:(void (^)(NSDictionary*dic))saveData succ:(void (^)(NSDictionary*dic))succ fail:(void (^)(int errCode, NSError * err))fail;
//统一错误处理函数
+(void)error_hanlde:(int)errCode Witherr:(NSError *)err;
/////////longin

//+(AFRequestState *)postRequestlonginNew:(NSString *)url param:(NSDictionary *)param saveData:(void (^)(NSDictionary*dic))saveData succ:(void (^)(NSDictionary*dic))succ fail:(void (^)(int errCode, NSError * err))fail;
@end
