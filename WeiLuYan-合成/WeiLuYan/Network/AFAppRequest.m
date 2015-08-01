 //
//  AFAppRequest.m
//  QIQI_77
//
//  Created by Bill.Zhang on 14-8-23.
//  Copyright (c) 2014年 Bill.Zhang. All rights reserved.
//

#import "AFAppRequest.h"
#import "AppDelegate.h"
#import "Gson.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "GeneralizedProcessor.h"
#import "AccountModel.h"
#import "MBProgressHUD+Show.h"

static NSString* const WC_API=@"http://wly.iheima.com";
//static NSString* const youku=@"https://openapi.youku.com";

@interface AFRequestState()
@property NSMutableArray * NotfifyArray;

-(void)changeState:(id)notify;
-(void)setEnd;
-(void)start;
@end

@implementation AFRequestState

-(id)init
{
    self = [super init];
    _NotfifyArray = [NSMutableArray new];
    return self;
}

-(AFRequestState *)addNotifaction:(id)notify
{
//    NSValue * v = [NSValue valueWithNonretainedObject:notify];
    [_NotfifyArray addObject:notify];
    
    [self changeState:notify ];
    
    return self;
}

-(void)changeState:(id)notify
{
    if( [notify isKindOfClass:[MJRefreshBaseView class]]){
        if( _running ){
            
        }
        else{
            [(MJRefreshBaseView *)notify endRefreshing];
        }
    }
    if( [notify isKindOfClass:[MBProgressHUD class]]){
        if( _running ){
            [(MBProgressHUD *)notify show:YES];
        }
        else{
            [(MBProgressHUD *)notify removeFromSuperview];
        }
    }}

-(void)setEnd;
{
    _running = NO;
    
    for( id notify in _NotfifyArray ){
        [self changeState:notify];
    }
    
    [_NotfifyArray removeAllObjects];
}

-(void)start
{
    _running = YES;
    
    for( id notify in _NotfifyArray ){
        [self changeState:[(NSValue *)notify nonretainedObjectValue]];
    }
}



@end

@interface UploadImgResp : NSObject<Expose>
@property (nonatomic, strong) NSString * img;
@end

@implementation UploadImgResp
@end

@implementation AFAppRequest

//创建单例
+(AFAppRequest*)sharedClient
{
    static AFAppRequest* _AFRequest = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _AFRequest=[[AFAppRequest alloc]initWithBaseURL:[NSURL URLWithString:WC_API]];
    });
    
    return _AFRequest;
}

+(AFHTTPRequestOperationManager *)sharedManager
{
    static AFHTTPRequestOperationManager* _om = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _om =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:WC_API]];
    });
    
    return _om;
}


//无token加密
+(NSMutableDictionary*)getURLSign:(NSString*)path
{
    NSString*urlStr=[NSString stringWithFormat:@"%@/%@",WC_API,path];
    NSString*base64=[GeneralizedProcessor base64StringFromText:urlStr];
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:base64,@"urlSign",nil];
}


//有token加密
+(NSMutableDictionary*)getURLSignaAndTokenDic:(NSString*)path
{
   NSString*urlStr=[NSString stringWithFormat:@"%@/%@",WC_API,path];
    NSString*base64=[GeneralizedProcessor base64StringFromText:urlStr];
    NSString*token= [[AccountModel instance] getToken];
    return   [NSMutableDictionary dictionaryWithObjectsAndKeys:base64,@"urlSign",token,@"authSign", nil];
}


+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ
{
    return [self postRequestWithToken:url param:param succ:succ resp:nil];
}

//上传数据处理特定错误码
+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail
{
    return [self postRequestWithToken:url param:param succ:succ fail:fail resp:nil];
}
//上传数据统一错误处理
+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ resp:(Class)resp
{
    return [self postRequestWithToken:url param:param succ:succ fail:^(int errCode, NSError *err) {

        [self error_hanlde:errCode Witherr:err];
        
    } resp:resp];
}

//统一错误处理
+(void)error_hanlde:(int)errCode Witherr:(NSError *)err {
    
    if(err.code == -1009)
    {
        [MBProgressHUD creatembHub:@"没有网络"];
    }
    if(errCode == 1003)//err.code == - 1003)
    {
        [AppDelegate errorAndRelogin];
        
    }
    if (errCode==5528) {
        
        [MBProgressHUD creatembHub:@"没有评论"];
    }
    if(errCode == 5006)
    {
        [MBProgressHUD creatembHub:@"手机号或密码错误，请重新输入"];
    }
    
    
    
    if(errCode == 10000)
    {
        [MBProgressHUD creatembHub:@"数据解析错误"];
    }

    if(errCode == 50000)
    {
        [MBProgressHUD creatembHub:@"未知错误"];
    }
    
    if(errCode == 5522)
    {
        [MBProgressHUD creatembHub:@"该项目暂时没有人点赞哦"];
    }
    
    if(errCode == 2043)
    {
        [MBProgressHUD creatembHub:@"操作失败,请核对原密码是否正确"];
    }
    
    if(errCode == 2042)
    {
        [MBProgressHUD creatembHub:@"非注册激活用户"];
    }
    if(errCode == 0)
    {
        [MBProgressHUD creatembHub:@"网络超时，请检查网络连接是否正常"];
    }
    
    if(errCode == 2032)
    {
        [MBProgressHUD creatembHub:@"您得认证信息正在审核"];
    }
    
}

+(AFRequestState *)postRequestWithToken:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail resp:(Class)resp;
{
    NSString * token = [[AccountModel instance] getToken];
    
    if( token == nil )
    {
        fail(11000, nil);
        return nil;
    }
    
    NSMutableDictionary * sign = [[NSMutableDictionary alloc]initWithDictionary:@{@"authSign":token}];
    
    [sign addEntriesFromDictionary:param];
    return [self postRequestWithPost:url param:sign succ:succ fail:fail resp:resp];
    

}

+(void)handleResponse:(id)responseObject Succ:(void (^)(id data))succ Fail:(void (^)(int errCode, NSError * err))fail Resp:(Class)resp State:(AFRequestState *)State;
{
    
    @try
    {
        if([responseObject isKindOfClass:[NSData class]])
        {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        if( responseObject == nil )
        {
            fail(10002, nil);
            return;
        }
        
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        
        if( error_code != 0)
        {
            fail(error_code, nil);
            return;
        }
        
        id data = [Gson fromObj:[responseObject objectForKey:@"data"] Cls:resp];
        
        if(data == nil && resp == [NSNull class])
        {
            succ(nil);
            return;
        }
        
        if( data == nil && resp != [NSNull class] )
        {
            fail(10001, nil);
            return;
        }
        if(succ == nil)
        {
            return;
        }
        succ(data);
    }
    @catch(GsonException * excep){
        fail(10000, nil);
    }
    @catch(NSException * excep){
        fail(50000, nil);
    }
    @finally{
        [State setEnd];
    }
}

+(AFRequestState *)postImageFlag:(BOOL)flag url:(NSString *)url succ:(void(^)(id img))succ WithData:(NSDictionary *)data fail:(void (^)(int errCode, NSError * err))fail
{

     NSMutableDictionary*parameter= [self getURLSignaAndTokenDic:url];
    [parameter setValuesForKeysWithDictionary:data];
    AFHTTPRequestOperationManager*manager=[self sharedClient];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];
    
    AFRequestState * State = [AFRequestState new];
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
        for (int i =0; i<[[data objectForKey:@"feedcontent_pic"]  count]; i++) {
                 
                 
            [formData appendPartWithFileData:UIImagePNGRepresentation([[data objectForKey:@"feedcontent_pic"] objectAtIndex:i]) name:[NSString stringWithFormat: @"Filedata" ] fileName:@"upload.png" mimeType:@"image/png"];
        }
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(flag){
             [self handleResponse:responseObject Succ:^(id data) {
                 succ(((UploadImgResp *)data).img);
                 
             } Fail:fail Resp:[UploadImgResp class] State:State];
         }
         else{
             [self handleResponse:responseObject Succ:^(id data) {
                 succ([NSNumber numberWithInt:(int)data]);
                 
             } Fail:fail Resp:nil State:State];
         }
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         fail(10010,nil);
         [State setEnd];
     }];
    
    [State start];
    return State;
}

+(AFRequestState *)postImagesFlag:(BOOL)flag url:(NSString *)url succ:(void(^)(id img))succ WithData:(NSArray *)data fail:(void (^)(int errCode, NSError * err))fail
{
    
    NSMutableDictionary*parameter= [self getURLSignaAndTokenDic:url];
    for (NSDictionary *dic in data) {
        [parameter setValuesForKeysWithDictionary:dic];
    }
    AFHTTPRequestOperationManager*manager=[self sharedClient];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];
    
    AFRequestState * State = [AFRequestState new];
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
         for (int i =0; i<[data count]; i++) {
             
             NSString *feedKey;
             if (i == 0) {
                 feedKey = @"feed_pic";
             }else{
                 feedKey = [NSString stringWithFormat:@"feed_pic%d",i];
             }
             [formData appendPartWithFileData:UIImagePNGRepresentation([data[i] objectForKey:feedKey]) name:feedKey fileName:[NSString stringWithFormat:@"%@.png",feedKey] mimeType:@"image/png"];
         }
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(flag){
             [self handleResponse:responseObject Succ:^(id data) {
                 succ(((UploadImgResp *)data).img);
                 
             } Fail:fail Resp:[UploadImgResp class] State:State];
         }
         else{
             [self handleResponse:responseObject Succ:^(id data) {
                 succ((NSDictionary *)data);
                 
             } Fail:fail Resp:nil State:State];
         }
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         fail(10010,nil);
         [State setEnd];
     }];
    
    [State start];
    return State;
}


+(AFRequestState *)postRequestWithPost:(NSString *)url param:(NSDictionary *)param succ:(void (^)(NSDictionary*dic))succ fail:(void (^)(int errCode, NSError * err))fail resp:(Class)resp
{
    NSMutableDictionary*sign=[AFAppRequest getURLSign:url];
    
    [sign addEntriesFromDictionary:param];
    
    AFRequestState * State = [AFRequestState new];

    [[self sharedClient] POST:url parameters:sign success:^(AFHTTPRequestOperation * operation, id responseObject)
    {
        [self handleResponse:responseObject Succ:succ Fail:fail Resp:resp State:State];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        fail(0,error);
        [State setEnd];
    }];
    
    [State start];
    return State;
}

@end
