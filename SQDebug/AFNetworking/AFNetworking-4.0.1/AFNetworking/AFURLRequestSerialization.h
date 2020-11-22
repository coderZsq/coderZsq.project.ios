// AFURLRequestSerialization.h
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 返回遵循RFC 3986的查询字符串键或值的百分比转义字符串。
 RFC 3986声明以下字符为“保留”字符。
 -通用分隔符：“：”，“＃”，“ [”，“]”，“ @”，“？”，“ /”
 -子定界符：“！”，“ $”，“＆”，“'”，“（”，“）”，“ *”，“ +”，“，”，“，”，“ =”

 在RFC 3986-3.4节中，它指出“？” 和“ /”字符不应转义以允许查询字符串包含URL。 因此，所有“保留”字符（“？”除外） 和“ /”应该在查询字符串中转义。

 @param string 要百分号转义的字符串。

 @return换码百分比的字符串。
 */
FOUNDATION_EXPORT NSString * AFPercentEscapedStringFromString(NSString *string);

/**
 一种辅助方法，用于生成编码后的URL查询参数，以附加到URL的末尾。

 @param parameters 要编码的键/值的字典。

 @return网址编码的查询字符串
 */
FOUNDATION_EXPORT NSString * AFQueryStringFromParameters(NSDictionary *parameters);

/**
 对象采用“ AFURLRequestSerialization”协议，该协议对指定HTTP请求的参数进行编码。 请求序列化程序可以将参数编码为查询字符串，HTTP正文，并根据需要设置适当的HTTP标头字段。

 例如，JSON请求序列化程序可以将请求的HTTP主体设置为JSON表示，并将“ Content-Type” HTTP标头字段值设置为“ application / json”。
 */
@protocol AFURLRequestSerialization <NSObject, NSSecureCoding, NSCopying>

/**
 返回带有已编码为原始请求副本的指定参数的请求。

 @param request 原始请求。
 @param parameters 要编码的参数。
 @param error 尝试对请求参数进行编码时发生的错误。

 @return 序列化的请求。
 */
- (nullable NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(nullable id)parameters
                                        error:(NSError * _Nullable __autoreleasing *)error NS_SWIFT_NOTHROW;

@end

#pragma mark -

/**

 */
typedef NS_ENUM(NSUInteger, AFHTTPRequestQueryStringSerializationStyle) {
    AFHTTPRequestQueryStringDefaultStyle = 0,
};

@protocol AFMultipartFormData;

/**
 AFHTTPRequestSerializer符合AFURLRequestSerialization和AFURLResponseSerialization协议，提供查询字符串/ URL格式编码的参数序列化和默认请求标头的具体基础实现，以及响应状态代码和内容类型验证。

   鼓励任何处理HTTP的请求或响应序列化器都继承AFHTTPRequestSerializer的子类，以确保一致的默认行为。
 */
@interface AFHTTPRequestSerializer : NSObject <AFURLRequestSerialization>

/**
 用于序列化参数的字符串编码。 默认情况下，`NSUTF8StringEncoding`。
 */
@property (nonatomic, assign) NSStringEncoding stringEncoding;

/**
 创建的请求是否可以使用设备的蜂窝无线电（如果有）。 默认为YES。

   @see NSMutableURLRequest -setAllowsCellularAccess：
 */
@property (nonatomic, assign) BOOL allowsCellularAccess;

/**
 创建的请求的缓存策略。 默认情况下，`NSURLRequestUseProtocolCachePolicy`。

   @see NSMutableURLRequest -setCachePolicy：
 */
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

/**
 创建的请求是否应使用默认的cookie处理。 默认为YES。

   @see NSMutableURLRequest -setHTTPShouldHandleCookies：
 */
@property (nonatomic, assign) BOOL HTTPShouldHandleCookies;

/**
 在收到来自较早传输的响应之前，创建的请求是否可以继续传输数据。 默认为“否”

   @see NSMutableURLRequest -setHTTPShouldUsePipelining：
 */
@property (nonatomic, assign) BOOL HTTPShouldUsePipelining;

/**
 创建的请求的网络服务类型。 默认情况下为“ NSURLNetworkServiceTypeDefault”。

   @see NSMutableURLRequest -setNetworkServiceType：
 */
@property (nonatomic, assign) NSURLRequestNetworkServiceType networkServiceType;

/**
 创建的请求的超时间隔（以秒为单位）。 默认超时间隔为60秒。

   @see NSMutableURLRequest -setTimeoutInterval：
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

///---------------------------------------
/// @name 配置HTTP请求头
///---------------------------------------

/**
 要应用于序列化请求的默认HTTP标头字段值。 默认情况下，这些内容包括：

   -具有NSLocale + preferredLanguages内容的`Accept-Language`
   -`User-Agent`，其中包含各种捆绑包标识符和操作系统名称的内容

   @discussion 要添加或删除默认请求头，请使用`setValue：forHTTPHeaderField：`。
 */
@property (readonly, nonatomic, strong) NSDictionary <NSString *, NSString *> *HTTPRequestHeaders;

/**
 用默认配置创建并返回一个序列化器。
 */
+ (instancetype)serializer;

/**
 设置在HTTP客户端发出的请求对象中设置的HTTP标头的值。 如果为nil，则删除该标头的现有值。

   @param field 用于设置默认值的HTTP标头
   @param value 为指定的标头设置的默认值，或者为'nil'
 */
- (void)setValue:(nullable NSString *)value
forHTTPHeaderField:(NSString *)field;

/**
 返回在请求序列化程序中设置的HTTP标头的值。

   @param field 用于检索默认值的HTTP标头

   @return 为指定标题设置的默认值，或者为'nil'
 */
- (nullable NSString *)valueForHTTPHeaderField:(NSString *)field;

/**
 将HTTP客户端在请求对象中设置的“ Authorization” HTTP标头设置为具有Base64编码的用户名和密码的基本身份验证值。 这将覆盖此标头的任何现有值。

   @param username HTTP基本身份验证用户名
   @param password HTTP基本身份验证密码
 */
- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password;

/**
 清除“Authorization” HTTP标头的任何现有值。
 */
- (void)clearAuthorizationHeader;

///-------------------------------------------------------
/// @name 配置查询字符串参数序列化
///-------------------------------------------------------

/**
 序列化请求的HTTP方法会将参数编码为查询字符串。 默认情况下，`GET`，`HEAD`和`DELETE`。
 */
@property (nonatomic, strong) NSSet <NSString *> *HTTPMethodsEncodingParametersInURI;

/**
 根据预定义的样式之一设置查询字符串序列化的方法。

   @param style 序列化样式。

   @see AFHTTPRequestQueryStringSerializationStyle
 */
- (void)setQueryStringSerializationWithStyle:(AFHTTPRequestQueryStringSerializationStyle)style;

/**
 根据指定的块设置查询字符串序列化的自定义方法。

   @param block 定义将参数编码为查询字符串的过程的块。 该块返回查询字符串，并接受三个参数：请求，要编码的参数以及尝试对给定请求的参数进行编码时发生的错误。
 */
- (void)setQueryStringSerializationWithBlock:(nullable NSString * _Nullable (^)(NSURLRequest *request, id parameters, NSError * __autoreleasing *error))block;

///-------------------------------
/// @name 创建请求对象
///-------------------------------

/**
 使用指定的HTTP方法和URL字符串创建一个NSMutableURLRequest对象。

   如果HTTP方法是`GET`，`HEAD`或`DELETE`，则参数将用于构造附加到请求URL的url编码查询字符串。 否则，将根据“ parameterEncoding”属性的值对参数进行编码，并将其设置为请求正文。

   @param method 请求的HTTP方法，例如“ GET”，“ POST”，“ PUT”或“ DELETE”。 该参数不能为“ nil”。
   @param URLString 用于创建请求URL的URL字符串。
   @param parameters 将被设置为GET请求的查询字符串或请求HTTP正文的参数。
   @param error 构造请求时发生的错误。

   @return 一个NSMutableURLRequest对象。
 */
- (nullable NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                          URLString:(NSString *)URLString
                                         parameters:(nullable id)parameters
                                              error:(NSError * _Nullable __autoreleasing *)error;

/**
 使用指定的HTTP方法和URLString创建一个“ NSMutableURLRequest”对象，并使用指定的参数和多部分表单数据块构造一个“ multipart / form-data” HTTP正文。参见http://www.w3.org/TR/html4/interact/forms.html#h-17.13.4.2

  多部分表单请求会自动进行流传输，直接从磁盘读取文件以及单个HTTP正文中的内存数据。产生的NSMutableURLRequest对象具有HTTPBodyStream属性，因此请不要在此请求对象上设置HTTPBodyStream或HTTPBody，因为它将清除多部分表单主体流。

  @param method 请求的HTTP方法。此参数不能为“ GET”，“ HEAD”或“ nil”。
  @param URLString 用于创建请求URL的URL字符串。
  @param parameters 在请求HTTP正文中要编码和设置的参数。
  @param block 一个接受单个参数并将数据附加到HTTP正文的块。 block参数是采用AFMultipartFormData协议的对象。
  @param error 构造请求时发生的错误。

  @return 一个NSMutableURLRequest对象
 */
- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(nullable NSDictionary <NSString *, id> *)parameters
                              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                                  error:(NSError * _Nullable __autoreleasing *)error;

/**
 通过从请求中删除HTTPBodyStream来创建NSMutableURLRequest，并将其内容异步写入指定的文件，并在完成时调用完成处理程序。

  @param request 多部分表单请求。 request的HTTPBodyStream属性不能为nil。
  @param fileURL 要写入多部分表单内容的文件URL。
  @param handler 要执行的处理程序块。

  @discussion NSURLSessionTask中存在一个错误，该错误导致请求从HTTP正文流传输内容时请求不发送Content-Length标头，这在与Amazon S3 Web服务进行交互时尤其成问题。解决方法是，此方法采用一个由multipartFormRequestWithMethod：URLString：parameters：constructingBodyWithBlock：error：构造的请求，或带有HTTPBodyStream的任何其他请求，将内容写入指定的文件，并返回原始请求的副本。 HTTPBodyStream属性设置为nil。在这里，文件可以传递到AFURLSessionManager -uploadTaskWithRequest：fromFile：progress：completionHandler：`，或将其内容读入分配给请求的HTTPBody属性的NSData中。

  @see https://github.com/AFNetworking/AFNetworking/issues/1398
 */
- (NSMutableURLRequest *)requestWithMultipartFormRequest:(NSURLRequest *)request
                             writingStreamContentsToFile:(NSURL *)fileURL
                                       completionHandler:(nullable void (^)(NSError * _Nullable error))handler;

@end

#pragma mark -

/**
 AFMultipartFormData协议定义了AFHTTPRequestSerializer -multipartFormRequestWithMethod：URLString：parameters：constructingBodyWithBlock：的block参数中参数所支持的方法。
 */
@protocol AFMultipartFormData

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{生成的文件名}; name =＃{name}”和“ Content-Type：＃{生成的mimeType}”，然后是编码的文件数据和多部分表单边界。

   表单中此数据的文件名和MIME类型将分别使用`fileURL`的最后一个路径部分和`fileURL`扩展名与系统相关的MIME类型自动生成。

   @param fileURL 对应于其内容将附加到表单的文件的URL。 该参数不能为“ nil”。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param error 如果发生错误，返回时将包含一个描述问题的NSError对象。

   @如果文件数据已成功添加，则返回“是”，否则返回“否”。
 */
- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                        error:(NSError * _Nullable __autoreleasing *)error;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是编码文件数据和多部分表单边界。

   @param fileURL 对应于其内容将附加到表单的文件的URL。 该参数不能为“ nil”。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param fileName 在Content-Disposition标头中使用的文件名。 该参数不能为“ nil”。
   @param mimeType 文件数据的声明的MIME类型。 该参数不能为“ nil”。
   @param error 如果发生错误，返回时将包含一个描述问题的NSError对象。

   @如果文件数据已成功添加，则返回“是”，否则返回“否”。
 */
- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                        error:(NSError * _Nullable __autoreleasing *)error;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是来自输入流的数据和多部分表单边界。

   @param inputStream 要添加到表单数据的输入流
   @param name 与指定的输入流关联的名称。 该参数不能为“ nil”。
   @param fileName 与指定输入流关联的文件名。 该参数不能为“ nil”。
   @param length 以字节为单位的指定输入流的长度。
   @param mimeType 指定数据的MIME类型。 （例如，JPEG图像的MIME类型为image / jpeg。）有关有效MIME类型的列表，请参见http://www.iana.org/assignments/media-types/。 该参数不能为“ nil”。
 */
- (void)appendPartWithInputStream:(nullable NSInputStream *)inputStream
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                           length:(int64_t)length
                         mimeType:(NSString *)mimeType;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是编码文件数据和多部分表单边界。

   @param data 要编码并附加到表单数据的数据。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param fileName 与指定数据关联的文件名。 该参数不能为“ nil”。
   @param mimeType 指定数据的MIME类型。 （例如，JPEG图像的MIME类型为image / jpeg。）有关有效MIME类型的列表，请参见http://www.iana.org/assignments/media-types/。 该参数不能为“ nil”。
 */
- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;

/**
 附加HTTP标头`Content-Disposition：form-data; name =＃{name}“`，后跟编码数据和多部分表单边界。

   @param data 要编码并附加到表单数据的数据。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
 */

- (void)appendPartWithFormData:(NSData *)data
                          name:(NSString *)name;


/**
 附加HTTP标头，后跟编码数据和多部分表单边界。

   @param headers 要附加到表单数据的HTTP标头。
   @param body 要编码并附加到表单数据的数据。 该参数不能为“ nil”。
 */
- (void)appendPartWithHeaders:(nullable NSDictionary <NSString *, NSString *> *)headers
                         body:(NSData *)body;

/**
 节流通过限制数据包大小并为从上传流中读取的每个数据块增加延迟来请求带宽。

  通过3G或EDGE连接上载时，请求可能会失败，并显示“请求正文流已耗尽”。根据建议值（kAFUploadStream3GSuggestedPacketSize和kAFUploadStream3GSuggestedDelay）设置最大数据包大小和延迟，可降低输入流超过其分配带宽的风险。不幸的是，没有确定的方法来区分通过NSURLConnection的3G，EDGE或LTE连接。因此，不建议您仅根据网络可达性来限制带宽。相反，您应该考虑在故障块中检查“请求正文流已耗尽”，然后使用限制带宽重试该请求。

  @param numberOfBytes 最大数据包大小，以字节数为单位。输入流的默认数据包大小为16kb。
  @param delay 每次读取数据包时的延迟持续时间。默认情况下，不设置延迟。
 */
- (void)throttleBandwidthWithPacketSize:(NSUInteger)numberOfBytes
                                  delay:(NSTimeInterval)delay;

@end

#pragma mark -

/**
 AFJSONRequestSerializer是AFHTTPRequestSerializer的子类，它使用NSJSONSerialization将参数编码为JSON，将编码请求的Content-Type设置为application / json。
 */
@interface AFJSONRequestSerializer : AFHTTPRequestSerializer

/**
 用于从Foundation对象写入请求JSON数据的选项。 有关可能的值，请参见“ NSJSONSerialization”文档部分“ NSJSONWritingOptions”。 默认为0。
 */
@property (nonatomic, assign) NSJSONWritingOptions writingOptions;

/**
 创建并返回带有指定读写选项的JSON序列化程序。

   @param writingOptions 指定的JSON写入选项。
 */
+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions;

@end

#pragma mark -

/**
 AFPropertyListRequestSerializer是AFHTTPRequestSerializer的子类，它使用NSPropertyListSerializer将参数编码为JSON，并将编码后的请求的Content-Type设置为application / x-plist。
 */
@interface AFPropertyListRequestSerializer : AFHTTPRequestSerializer

/**
 属性列表格式。 可能的值在“ NSPropertyListFormat”中描述。
 */
@property (nonatomic, assign) NSPropertyListFormat format;

/**
 @warning`writeOptions`属性当前未使用。
 */
@property (nonatomic, assign) NSPropertyListWriteOptions writeOptions;

/**
 创建并返回具有指定格式，读取选项和写入选项的属性列表序列化程序。

   @param format 属性列表格式。
   @param writeOptions 属性列表写入选项。

   @warning`writeOptions`属性当前未使用。
 */
+ (instancetype)serializerWithFormat:(NSPropertyListFormat)format
                        writeOptions:(NSPropertyListWriteOptions)writeOptions;

@end

#pragma mark -

///----------------
/// @name Constants
///----------------

/**
 ## Error Domains

 The following error domain is predefined.

 - `NSString * const AFURLRequestSerializationErrorDomain`

 ### Constants

 `AFURLRequestSerializationErrorDomain`
 AFURLRequestSerializer errors. Error codes for `AFURLRequestSerializationErrorDomain` correspond to codes in `NSURLErrorDomain`.
 */
FOUNDATION_EXPORT NSString * const AFURLRequestSerializationErrorDomain;

/**
 ## User info dictionary keys

 These keys may exist in the user info dictionary, in addition to those defined for NSError.

 - `NSString * const AFNetworkingOperationFailingURLRequestErrorKey`

 ### Constants

 `AFNetworkingOperationFailingURLRequestErrorKey`
 The corresponding value is an `NSURLRequest` containing the request of the operation associated with an error. This key is only present in the `AFURLRequestSerializationErrorDomain`.
 */
FOUNDATION_EXPORT NSString * const AFNetworkingOperationFailingURLRequestErrorKey;

/**
 ## Throttling Bandwidth for HTTP Request Input Streams

 @see -throttleBandwidthWithPacketSize:delay:

 ### Constants

 `kAFUploadStream3GSuggestedPacketSize`
 Maximum packet size, in number of bytes. Equal to 16kb.

 `kAFUploadStream3GSuggestedDelay`
 Duration of delay each time a packet is read. Equal to 0.2 seconds.
 */
FOUNDATION_EXPORT NSUInteger const kAFUploadStream3GSuggestedPacketSize;
FOUNDATION_EXPORT NSTimeInterval const kAFUploadStream3GSuggestedDelay;

NS_ASSUME_NONNULL_END
