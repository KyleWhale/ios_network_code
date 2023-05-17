#import "IosNetworkCodePlugin.h"

@implementation IosNetworkCodePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"ios_network_code"
            binaryMessenger:[registrar messenger]];
  IosNetworkCodePlugin* instance = [[IosNetworkCodePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getMobileCountryCode" isEqualToString:call.method]) {
      CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
      CTCarrier *carrier = [netInfo subscriberCellularProvider];
      NSString *countryCode = carrier.mobileCountryCode;
      result(countryCode);
  } else if ([@"getMobileNetworkCode" isEqualToString:call.method]) {
      CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
      CTCarrier *carrier = [netInfo subscriberCellularProvider];
      NSString *networkCode = carrier.mobileNetworkCode;
      result(networkCode);
  } else if ([@"getProxySettings" isEqualToString:call.method]) {
      NSDictionary *dic = CFBridgingRelease(CFNetworkCopySystemProxySettings());
      NSArray *keys = [dic[@"__SCOPED__"] allKeys];
      result([keys componentsJoinedByString:@","]);
  } else {
      result(FlutterMethodNotImplemented);
  }
}

@end
