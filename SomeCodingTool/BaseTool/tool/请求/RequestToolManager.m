//
//  RequestToolManager.m
//  IotTest
//
//  Created by FCNC05 on 2019/8/27.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "RequestToolManager.h"
#import "AFHTTPSessionManager.h"
#import <YYModel.h>
@interface Model : NSObject
@end
static RequestToolManager *manager = nil;
@implementation RequestToolManager
+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}
-(AFHTTPSessionManager *)getManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
    //添加解析类型
    response.removesKeysWithNullValues = YES;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //缓存设置时的添加Last-Modified，If-Modified-Since去服务器询问有没有数据变更 有的话重新发送数据，没有的话直接返回结果
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/jpg", @"image/png", @"application/octet-stream", @"text/json", nil];
    return manager;
}
//传入模型，再输出模型 有的只要结果 数据的缓存
-(void)requestWithUser:(NSString *)api parameter:(NSDictionary *)parameter getTargetModel:(id)targetModel isPost:(BOOL)isPost withSuccess:(SuccessBlock)success withFail:(FailBlock)fail{
    [self requestWithApi:api parameter:parameter targetModel:targetModel isPost:isPost withSuccess:success withFail:fail];
}

-(void)requestWithApi:(NSString *)api parameter:(NSDictionary *)parameter targetModel:(id)targetModel isPost:(BOOL)isPost withSuccess:(SuccessBlock)success withFail:(FailBlock)fail{

    [[self getManager] POST:api parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSObject *model = [[targetModel class] yy_modelWithDictionary:dic];
        //NSObject *model = [ ];
        success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"fail");
    }];

}
//上传图片
-(void)requestWithApi:(NSString *)api parameter:(NSDictionary *)parameter withUploadImage:(NSMutableArray *)arr_image isPost:(BOOL)isPost withSuccess:(SuccessBlock)success withFail:(FailBlock)fail{
    [[self getManager] POST:api parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //NSMutableArray *arr_image;
        for (NSUInteger i = 0; i < arr_image.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(arr_image[i], 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@%ld.%@",str,i,@"jpg"];
            NSLog(@"imageData = %@",imageData);

            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",@"jpg"]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"progress is %@",uploadProgress);
        });

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        NSLog(@"message = %@",[responseObject valueForKey:@"message"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}
//请求的数据缓存
//缓存的设计原则上 是以空间换时间 主要是考虑服务端的压力及客户的体验上
//首先网络请求 post不可以缓存  只有get请求可以 因为缓存是建立在查询的参数为key，对应的值为value   post数据放在body体中 则键值对应   json数据大括号包着
-(void)cacheData{
    //分配缓存用的内存
    NSURLCache *requestCache = [[NSURLCache alloc]initWithMemoryCapacity:4 *1024 *1024 diskCapacity:20 *1024 *1024 diskPath:nil];
    [NSURLCache setSharedURLCache:requestCache];
}
@end
