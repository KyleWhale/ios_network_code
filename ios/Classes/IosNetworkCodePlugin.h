#import <Flutter/Flutter.h>

@interface IosNetworkCodePlugin : NSObject<FlutterPlugin>

+ (IosNetworkCodePlugin *)shared;

@property (nonatomic, copy) FlutterResult checkConnectCallback;
@property (nonatomic, copy) FlutterResult checkDisconnectCallback;

- (void)screenCaptureChange;

@end
