//
//  SavePictureToPhoto.m
//  app
//
//  Created by wsh on 2018/3/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SavePictureToPhoto.h"


@interface SavePictureToPhoto()

@property (nonatomic, copy) FSSavePictureResultlBlock savePictureResult;

@end


@implementation SavePictureToPhoto


static SavePictureToPhoto * _instence;
+ (instancetype)savePictureManager {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instence = [[self alloc] init];
  });
  return _instence;
}


//+ (void)saveImageWithImageUrl:(NSString *)imageUrl result:(FSSavePictureResultlBlock)savePictureResult {
//  NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:imageUrl]];
//  UIImage *image = [UIImage imageWithData:data];
//  [self saveImageFinished:image result:(FSSavePictureResultlBlock)savePictureResult];
//}

+ (void)saveImageWithImageData:(FlutterStandardTypedData *)data result:(FSSavePictureResultlBlock)savePictureResult {
//  NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:data options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    NSData *decodeData = data.data;
  UIImage *image = [UIImage imageWithData:decodeData];
  [self saveImageFinished:image result:(FSSavePictureResultlBlock)savePictureResult];
}

+ (void)saveImageFinished:(UIImage *)image result:(FSSavePictureResultlBlock)savePictureResult {
  
  SavePictureToPhoto *sp = [SavePictureToPhoto savePictureManager];
  sp.savePictureResult = savePictureResult;
  
  [sp saveImageFinished:image result:savePictureResult];
}

- (void)saveImageFinished:(UIImage *)image result:(FSSavePictureResultlBlock)savePictureResult{
  self.savePictureResult = savePictureResult;
  UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
  if (!error) {
    self.savePictureResult(@"1");
  } else {
    self.savePictureResult(@"0");
  }
  NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

@end
