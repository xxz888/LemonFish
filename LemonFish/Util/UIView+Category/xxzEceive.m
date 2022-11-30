
#import "xxzEceive.h"

@implementation NSArray (Log)


- (NSString *)descriptionWithLocale:(id)locale
{
    
    NSMutableString *rate6 = [NSMutableString string];
    
    
    [rate6 appendString:@"(\n"];
    
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [rate6 appendFormat:@"\t%@,\n",obj];
        
    }];
    
    
    [rate6 appendString:@")\n"];
    
    return rate6;
}



- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *jiaoyishijian = [NSMutableString stringWithString:@"(\n"];

    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [jiaoyishijian appendFormat:@"\t%@,\n", obj];
    }];

    [jiaoyishijian appendString:@")"];

    return jiaoyishijian;
}

@end

@implementation NSDictionary (Log)


- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *jiaoyishijian8 = [NSMutableString stringWithString:@"{\n"];

    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [jiaoyishijian8 appendFormat:@"\t%@ = %@;\n", key, obj];
    }];

    [jiaoyishijian8 appendString:@"}\n"];

    return jiaoyishijian8;
}


- (NSString *)descriptionWithLocale:(id)locale
{
    
    NSMutableString *rate66 = [NSMutableString string];
    
    
    [rate66 appendString:@"{\n"];
    
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [rate66 appendFormat:@"\t%@ = %@;\n",key,obj];
    }];
    
    
    [rate66 appendString:@"}\n"];
    
    return rate66;
}
@end
