//
//  RSACryptor.h
//

#import <Foundation/Foundation.h>

@interface RSACryptor : NSObject

+ (instancetype)sharedRSACryptor;

/**
 *  生成密钥对
 *
 *  @param keySize 密钥尺寸，可选数值(512/1024/2048)
 */
- (void)generateKeyPair:(NSUInteger)keySize;

/**
 *  加载公钥
 *
 *  @param publicKeyPath 公钥路径
 *
 @code
 # 生成证书
 $ openssl genrsa -out ca.key 1024
 # 创建证书请求
 $ openssl req -new -key ca.key -out rsacert.csr
 # 生成证书并签名
 $ openssl x509 -req -days 3650 -in rsacert.csr -signkey ca.key -out rsacert.crt
 # 转换格式
 $ openssl x509 -outform der -in rsacert.crt -out rsacert.der
 @endcode
 */
- (void)loadPublicKey:(NSString *)publicKeyPath;

/**
 *  加载私钥
 *
 *  @param privateKeyPath p12文件路径
 *  @param password       p12文件密码
 *
 @code
 openssl pkcs12 -export -out p.p12 -inkey ca.key -in rsacert.crt
 @endcode
 */
- (void)loadPrivateKey:(NSString *)privateKeyPath password:(NSString *)password;

/**
 *  加密数据
 *
 *  @param plainData 明文数据
 *
 *  @return 密文数据
 */
- (NSData *)encryptData:(NSData *)plainData;

/**
 *  解密数据
 *
 *  @param cipherData 密文数据
 *
 *  @return 明文数据
 */
- (NSData *)decryptData:(NSData *)cipherData;

@end
