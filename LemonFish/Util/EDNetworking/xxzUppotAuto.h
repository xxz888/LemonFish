
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^SuccessBlock)(id responseObject);
typedef void (^FailureBlock)(NSString *error);

@interface xxzUppotAuto : NSObject

+ (void)PostWithURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock __nullable)success failure:(FailureBlock __nullable)failure;

+ (void)PostWithAddressURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock __nullable)success failure:(FailureBlock __nullable)failure;

+ (void)PostWithImageURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock __nullable)success failure:(FailureBlock __nullable)failure;

@end

NS_ASSUME_NONNULL_END
