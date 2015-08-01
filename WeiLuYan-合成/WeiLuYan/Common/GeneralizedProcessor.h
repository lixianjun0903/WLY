

#import <Foundation/Foundation.h>

@interface GeneralizedProcessor : NSObject

/*******base64********/




/******************************************************************************
函数名称 : + (NSString *)base64StringFromText:(NSString *)text
函数描述 : 将文本转换为base64格式字符串
输入参数 : (NSString *)text    文本
输出参数 : N/A
返回参数 : (NSString *)    base64格式字符串
备注信息 :
******************************************************************************/

+ (NSString *)base64StringFromText:(NSString *)text;


/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;


/*******base64********/

+(NSString *)setPassWord:(NSString * )password;
//hash_hmac
+ (NSData *) hmacSha1:(NSString*)key text:(NSString*)text;

+(NSString *)hmac:(NSString *)plainText withKey:(NSString *)key;

//字符串翻转
+(NSString *)fanZhuan:(NSString *)str;


+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
+(CGFloat)getStrSize_WIDTH:(NSString*)str :(UIFont*)font;
+(UIColor * ) hexStringToColor: (NSString *) stringToConvert;
+(NSString* )getDateString:(float)sec;
+(void) removeCache;
+(float) folderSizeAtPath;
+(NSString* ) notRounding:(float)value afterPoint:(int)position;
+(NSString*)getNotRounding:(float)value afterPoint:(int)position;
+(NSDate *)dateFromString:(NSString *)dateString;
+(NSDate*)getAlreadyDateString:(int)day;
+(NSString*)dateToString:(NSDate*)date;
+(CGFloat)getViewCenterX:(CGSize)fatherSize :(CGFloat)fontSize :(NSString*)value;
+(void)removeView:(UIView*)view :(int)tag;
+(NSString*)getdatePikerView:(NSDate*)date;
+(NSString *)md5:(NSString *)str;
//PLIST文件
+(NSString*)getFilePath:(NSString*)fileName;
+(void)createPlist:(NSString*)fileName;//创建
+(void)deletePlist:(NSString*)fileName;//删除
+(void)writePlist:(NSDictionary*)message :(NSString*)fileName;//写
+(NSDictionary*)readPlist:(NSString*)fileName;//读
+(BOOL)plistFileisExist:(NSString*)fileName;
////
+(BOOL)isMobileNumber:(NSString *)mobileNum;

+(NSString*)getMessageDatetimeStr:(NSDate*)messageDate;
+(NSString*)getMessageDatetimeStr:(NSDate*)messageDate :(BOOL)isChatView;
+(NSString*)getBirthDate:(NSDate*)birthdate;
+(NSDate *)dateFromStringYYMMDD:(NSString *)dateString;
+(UIButton*)getButton:(CGRect)newRect :(UIButtonType)buttonType;
+(NSString*)getdatePikerViewBirthDay:(NSDate*)date;
+(BOOL) validateEmail:(NSString *)email;
+(CGSize)lableHeightFromStr:(NSString*)str :(CGFloat)pageWidth :(UIFont*)font;
+(UIButton*)getArrBton:(UIButton*)bton;
+(UIView*)getArrView:(UIView*)view;
+(NSIndexPath*)getNewSection:(NSInteger)section :(NSInteger)row;
+(void)drawLineCode:(CGFloat)red : (CGFloat)green :(CGFloat)blue :(CGContextRef)ctx :(CGPoint)startPostion :(CGPoint)endPoint;


/***************View 初始化****************/
+(UILabel*)getNewLable:(CGRect)rect :(UIFont*)font :(NSString*)text :(UIColor*)textColor;

/***************View 初始化****************/
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+(void)setLableNewFrameFromText:(UILabel*)lable :(NSString*)text :(UIFont*)font :(CGFloat)setLableWidth;
+(BOOL)CheckInput:(NSString *)_text;
@end
