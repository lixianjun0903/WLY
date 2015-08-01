

#import "GeneralizedProcessor.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>

#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation GeneralizedProcessor

/*******base64********/




+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}



/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}








/*******base64********/



+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur), nil];
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil]; // save it to self.context
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}




+(CGFloat)getStrSize_WIDTH:(NSString*)str :(UIFont*)font
{
    CGSize size=[str sizeWithFont:font];
    return size.width;
}
+(CGSize)getStrSize:(NSString*)str :(UIFont*)font
{
    CGSize size=[str sizeWithFont:font];
    return size;
}
+(NSString*)getdatePikerView:(NSDate*)date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [dateformatter stringFromDate:date];
    return dateStr;
}
+(NSString*)getdatePikerViewBirthDay:(NSDate*)date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateformatter stringFromDate:date];
    return dateStr;
}

+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(NSString*)getDateString:(float)sec
{
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:sec];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int month = (int)[comps month];
    int day = (int)[comps day];
    return [NSString stringWithFormat:@"%d月%d日",month,day];
}
+(NSString*)getDateAllString:(float)sec
{
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:sec];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int year=(int)[comps year];
    int month = (int)[comps month];
    int day = (int)[comps day];
    return [NSString stringWithFormat:@"%d,%d月%d日",year,month,day];
}

+(NSDate *)dateFromString:(NSString *)dateString{
    NSLog(@"%@",dateString);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    NSLog(@"%@",destDate);
    return destDate;
}
+(NSDate *)dateFromStringYYMMDD:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
   return destDate;
}

//+(NSDate*)getAlreadyDateString:(int)day
//{
//    NSTimeInterval secondsPerDay1 = day*24*60*60;
//    NSDate *now = [NSDate date];
//    NSDate *alreadyDay = [now addTimeInterval:-secondsPerDay1];
//    return alreadyDay;
//}

+(NSString*)dateToString:(NSDate*)date
{
    NSArray*dateArray =[[date description] componentsSeparatedByString:@" "];
    return [dateArray objectAtIndex:0];
}

+(void)removeCache
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
   [fileManager removeItemAtPath:cachesDir error:nil];
}
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M 百度
+(float) folderSizeAtPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *folderPath = [paths objectAtIndex:0];
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [GeneralizedProcessor fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


+(NSString *)notRounding:(float)value afterPoint:(int)position
{
   return [NSString stringWithFormat:@"%@M",[GeneralizedProcessor getNotRounding:value afterPoint:position]];
}
+(NSString*)getNotRounding:(float)value afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:value];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
+(CGFloat)getViewCenterX:(CGSize)fatherSize :(CGFloat)fontSize :(NSString*)value
{
    UIFont*font=[UIFont systemFontOfSize:fontSize];
    CGSize szie= [GeneralizedProcessor getStrSize:value :font];
    CGFloat x=(fatherSize.width-szie.width)/2;
    return x;
}
+(void)removeView:(UIView*)view :(int)tag
{
    UIView*getView=[view viewWithTag:tag];
    [getView removeFromSuperview];
}
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}
+(NSString*)getFilePath:(NSString*)fileName
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *plistPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    return plistPath;
}

+(BOOL)plistFileisExist:(NSString*)fileName
{
    NSString *plistPath = [GeneralizedProcessor getFilePath:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSLog(@"%@",plistPath
          );
   return [fm fileExistsAtPath:plistPath];
}
+(void)createPlist:(NSString*)fileName
{
    //    NSFileManager *fm = [NSFileManager defaultManager];
    //    NSString *plistPath = [GeneralizedProcessor getFilePath:fileName];
    //    NSLog(@"aaaa%@",plistPath);
    //   [fm createFileAtPath:plistPath contents:nil attributes:nil];
    //////////
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //找到Documents文件所在的路径
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //取得第一个Documents文件夹的路径
    
    NSString *filePath = [path objectAtIndex:0];
    
    //把TestPlist文件加入
    
    NSString *plistPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat: @"%@.plist",fileName]];
    
    //开始创建文件
    NSLog(@"aaaa%@",plistPath);
    
    [fm createFileAtPath:plistPath contents:nil attributes:nil];
    
    
}
+(NSDictionary*)readPlist:(NSString*)fileName//读

{

    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"ppppp%@",data);
    [GeneralizedProcessor getFilePath:@"userToken"];
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:[GeneralizedProcessor
                                                                                      getFilePath:fileName]];
    NSLog(@"data1%@", data1);
    

    return data1;

}
+(void)deletePlist:(NSString*)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *plistPath = [GeneralizedProcessor getFilePath:fileName];
    [fm removeItemAtPath:plistPath error:nil];
}

+(void)writePlist:(NSDictionary*)message :(NSString*)fileName
{
     NSString *plistPath = [GeneralizedProcessor getFilePath:fileName];
     [message writeToFile:plistPath atomically:YES];
    
    
}


//最终产生显示时间的字符串
+(NSString*)getHourAndMinTimeStr:(int)hours :(int)minute
{
     NSString*dataTimeStr=nil;
    if (hours<7) {
        dataTimeStr=[NSString stringWithFormat:@"凌晨%@:%@",[GeneralizedProcessor showTimeZeroHour:hours],[GeneralizedProcessor showTimeZeroMin:minute]];
        
    }else if (hours>6 && hours<13)
    {
        dataTimeStr=[NSString stringWithFormat:@"上午%@:%@",[GeneralizedProcessor showTimeZeroHour:hours],[GeneralizedProcessor showTimeZeroMin:minute]];
    }else{
        dataTimeStr=[NSString stringWithFormat:@"下午%@:%@",[GeneralizedProcessor showTimeZeroHour:hours],[GeneralizedProcessor showTimeZeroMin:minute]];
    }
    return dataTimeStr;
}
//对时分秒小于10的加0
+(NSString*)showTimeZeroMin:(int)min
{
    NSString*time_Str=nil;
    if (min<10) {
        time_Str=[NSString stringWithFormat:@"0%d",min];
    }
    {
        time_Str=[NSString stringWithFormat:@"%d",min];
    }
    return time_Str;
}

+(NSString*)showTimeZeroHour:(int)hour
{
    NSString*time_Str=nil;
    if (hour<10) {
      time_Str=[NSString stringWithFormat:@"0%d",hour];
    }else if(hour>12)
    {
       time_Str=[NSString stringWithFormat:@"%d",hour-12];
    }else
    {
        time_Str=[NSString stringWithFormat:@"%d",hour];
    }
    return time_Str;
}
// 判断星期几
+(NSString*)getWeekDay:(int)weekDay
{
    NSString*weekDayStr=nil;
    switch (weekDay) {
        case 1:
            weekDayStr=@"星期日";
            break;
            
        case 2:
            weekDayStr=@"星期一";
           break;
            
        case 3:
            weekDayStr=@"星期二";
            break;
            
        case 4:
            weekDayStr=@"星期三";
            break;
            
        case 5:
            weekDayStr=@"星期四";
            break;
            
        case 6:
            weekDayStr=@"星期五";
           break;
            
        case 7:
            weekDayStr=@"星期六";
          break;
    }
    return weekDayStr;
}
// 判断两个日期是否在同一周
+(BOOL)isDateThisWeek:(NSDate *)date {
    
    NSDate *start;
    NSTimeInterval extends;
    
    NSCalendar *cal=[NSCalendar autoupdatingCurrentCalendar];
    NSDate *today=[NSDate date];
    
    BOOL success= [cal rangeOfUnit:NSWeekCalendarUnit startDate:&start interval: &extends forDate:today];
    
    if(!success)
        return NO;
    
    NSTimeInterval dateInSecs = [date timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate];
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
    }
    else {
        return NO;
    }
}
//调用的时候只需调用这个方法，传入消息的发出/接收时间即可
+(NSString*)getBirthDate:(NSDate*)birthdate
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:birthdate];
    
    int year=(int)[comps year];
    int month = (int)[comps month];
    int day = (int)[comps day];
    NSMutableString*birthDateString=[[NSMutableString alloc]initWithFormat:@"%d",year];
    
    if (month<10) {
        [birthDateString appendFormat:@"0%d",month];
    }else
    {
     [birthDateString appendFormat:@"%d",month];
    }
    
    if (day<10) {
        [birthDateString appendFormat:@"0%d",day];
    }else{
        [birthDateString appendFormat:@"%d",day];
    }
   
    return  birthDateString;
}
+(NSString*)getMessageDatetimeStr:(NSDate*)messageDate :(BOOL)isChatView
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSDateComponents *currectComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    
    
    comps = [calendar components:unitFlags fromDate:messageDate];
    int week = (int)[comps weekday];
    int year=(int)[comps year];
    int month = (int)[comps month];
    int day = (int)[comps day];
    int hour = (int)[comps hour];
    int min = (int)[comps minute];
    
    currectComps = [calendar components:unitFlags fromDate:[NSDate date]];
    int currectYear=(int)[currectComps year];
    int currectMonth = (int)[currectComps month];
    int currectDay = (int)[currectComps day];
    
    NSString*dataTimeStr=nil;
    
    if (currectYear==year && currectDay==day && currectMonth ==month)
    {
        dataTimeStr=[GeneralizedProcessor getHourAndMinTimeStr:hour :min];
    }else if ([GeneralizedProcessor isDateThisWeek:messageDate])
    {
        if (currectYear==year && currectMonth ==month && currectDay-day==1)
        {
            dataTimeStr=[NSString stringWithFormat:@"昨天 %@",[GeneralizedProcessor getHourAndMinTimeStr:hour :min]];
        }else{
            dataTimeStr=[NSString stringWithFormat:@"%@ %@",[GeneralizedProcessor getWeekDay:week],[GeneralizedProcessor getHourAndMinTimeStr:hour :min]];
        }
    }else
    {
        if (currectYear==year && currectMonth ==month && currectDay-day==1)
        {
            dataTimeStr=[NSString stringWithFormat:@"昨天 %@",[GeneralizedProcessor getHourAndMinTimeStr:hour :min]];
        }
        if (isChatView==YES)
        {
            dataTimeStr=[NSString stringWithFormat:@"%d年%d月%d日 %@",year,month,day,[GeneralizedProcessor getHourAndMinTimeStr:hour :min]];
        }else
        {
            dataTimeStr=[NSString stringWithFormat:@"%d-%d-%d",year,month,day];
        }
      
        
    }
    return dataTimeStr;
}


+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(CGSize)lableHeightFromStr:(NSString*)str :(CGFloat)pageWidth :(UIFont*)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = CGSizeMake(pageWidth,2000);
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    return  labelsize;
}
+(UIButton*)getArrBton:(UIButton*)bton
{
    [bton.layer setCornerRadius:CGRectGetHeight([bton bounds]) / 2];
    bton.layer.masksToBounds = YES;
    return bton;
}
+(UIView*)getArrView:(UIView*)view
{
    [view.layer setCornerRadius:CGRectGetHeight([view bounds]) / 2];
    view.layer.masksToBounds = YES;
    return view;
}
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(NSIndexPath*)getNewSection:(NSInteger)section :(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    return indexPath;
}
+(void)drawLineCode:(CGFloat)red : (CGFloat)green :(CGFloat)blue :(CGContextRef)ctx :(CGPoint)startPostion :(CGPoint)endPoint
{
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(ctx, 1.0);  //线宽
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetRGBStrokeColor(ctx, red,green, blue, 1.0);  //颜色
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, startPostion.x, startPostion.y);  //起点坐标
    CGContextAddLineToPoint(ctx,endPoint.x, endPoint.y);   //终点坐标
    CGContextStrokePath(ctx);
}




//CGSize textFitToSize(NSString * text , CGSize maxSize , UIFont * font)
//{
//    
//    CGSize size ;
//    
//    if (iOS7()) {
//        
//        CGRect frame = [text boundingRectWithSize:maxSize
//                                          options:NSStringDrawingUsesLineFragmentOrigin
//                                       attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]
//                                          context:nil];
//        size = frame.size;
//        
//    } else {
//        
//        size = [text sizeWithFont:font
//                constrainedToSize:maxSize
//                    lineBreakMode:NSLineBreakByWordWrapping];
//    }
//    
//    return size;
//}


/***************View 初始化****************/
+(UILabel*)getNewLable:(CGRect)rect :(UIFont*)font :(NSString*)text :(UIColor*)textColor
{
    UILabel*lable  =[[UILabel alloc]initWithFrame:rect];
    [lable setText:text];
    [lable setFont:font];
    [lable setTextColor:textColor];
    return lable;
}
/***************View 初始化****************/

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
+(void)setLableNewFrameFromText:(UILabel*)lable :(NSString*)text :(UIFont*)font :(CGFloat)setLableWidth
{
    [lable setNumberOfLines:0];
     lable.lineBreakMode = NSLineBreakByCharWrapping;
    [lable setText:text];
    CGSize size=[GeneralizedProcessor lableHeightFromStr:text :setLableWidth :font];
    [lable setFont:font];
    CGRect newRect=  CGRectMake(lable.frame.origin.x,lable.frame.origin.y, size.width, size.height);
    [lable setFrame:newRect];
}
+(void)SETPLIST:(NSString*)str{



}
+(BOOL)CheckInput:(NSString *)_text
{
    
//    NSString *Regex = @"^[A-Za-z0-9\\@\\!\\#\\$\\%\\^\\&\\*\\(\\)\\,\\.\\/\\?\\<\\>\\|\\}\\{\\[\\]\\;\\'\\:\\]{6,16}$";
    
    NSString *Regex = @"^[\\s\\S]{6,16}$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    
    
    return [emailTest evaluateWithObject:_text];
    
    
    
}

+ (NSData *)hmacSha1:(NSString*)key text:(NSString*)text
{
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
//    NSString *hash;
//    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", cHMAC[i]];
//    hash = output;
    
    return HMAC;
}

+(NSString *)hmac:(NSString *)plainText withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plainText cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMACData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    
    for (int i = 0; i < HMACData.length; ++i)
        HMAC = [HMAC stringByAppendingFormat:@"%02lx", (unsigned long)buffer[i]];
    
    return HMAC;
}
+(NSString *)fanZhuan:(NSString *)str{
    
    unsigned long len;
    len = [str length];
    unichar a[len];
    for(int i = 0; i < len; i++)
    {
        unichar c = [str characterAtIndex:len-i-1];
        a[i] = c;
    }
    NSString *str1=[NSString stringWithCharacters:a length:len];
    return  str1;
}

+(NSString *)setPassWord:(NSString * )password
{
    NSString * fanWord =  [GeneralizedProcessor fanZhuan:password];
    
    NSData * data = [GeneralizedProcessor hmacSha1:@"123456789" text:fanWord];
    
    return [data base64EncodedStringWithOptions:0];
    
}


@end
