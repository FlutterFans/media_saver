#import "MediaSaverPlugin.h"
#import "SavePictureToPhoto.h"

@implementation MediaSaverPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"media_saver"
            binaryMessenger:[registrar messenger]];
  MediaSaverPlugin* instance = [[MediaSaverPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

//- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//  if ([@"saveImage" isEqualToString:call.method]) {
//      NSData *data = [call.arguments objectForKey:@"data"];
//      [SavePictureToPhoto saveImageWithImageData:data result:^(NSString *savePictureResult) {
////    callback(@[savePictureResult]);
//          result([NSNumber numberWithBool:true]);
//    }];
//    
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
//}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"saveImage" isEqualToString:call.method]) {
      FlutterStandardTypedData *data = [call.arguments objectForKey:@"data"];
      [SavePictureToPhoto saveImageWithImageData:data result:^(NSString *savePictureResult) {
//    callback(@[savePictureResult]);
          if ([savePictureResult isEqualToString: @"1"]) {
              result([NSNumber  numberWithBool:true]);
          } else {
              result([NSNumber  numberWithBool:true]);
          }
    }];
    
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
