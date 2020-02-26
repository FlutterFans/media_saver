//
//  SavePictureToPhoto.h
//  app
//
//  Created by wsh on 2018/3/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
typedef void(^FSSavePictureResultlBlock)(NSString *savePictureResult);

@interface SavePictureToPhoto : NSObject

+ (instancetype)savePictureManager;

+ (void)saveImageFinished:(UIImage *)image result:(FSSavePictureResultlBlock)savePictureResult;

//+ (void)saveImageWithImageUrl:(NSString *)imageUrl result:(FSSavePictureResultlBlock)savePictureResult;

+ (void)saveImageWithImageData:(FlutterStandardTypedData *)imageUrl result:(FSSavePictureResultlBlock)savePictureResult;


@end
