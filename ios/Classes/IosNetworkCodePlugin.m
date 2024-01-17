#import "IosNetworkCodePlugin.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation IosNetworkCodePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"ios_network_code" binaryMessenger:[registrar messenger]];
    IosNetworkCodePlugin *instance = [[IosNetworkCodePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getMobileCountryCode" isEqualToString:call.method]) {
        NSString *countryCode = @"";
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        if (@available(iOS 12.0, *)) {
            NSDictionary *carrierDictionary = netInfo.serviceSubscriberCellularProviders;
            for (NSString *carrierKey in carrierDictionary) {
                CTCarrier *carrier = [carrierDictionary objectForKey:carrierKey];
                NSString *networkCode = carrier.mobileCountryCode;
                break;
            }
        } else {
            CTCarrier *carrier = [netInfo subscriberCellularProvider];
            countryCode = carrier.mobileCountryCode;
        }
        result(countryCode);
    } else if ([@"getMobileNetworkCode" isEqualToString:call.method]) {
        NSString *networkCode = @"";
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        if (@available(iOS 12.0, *)) {
            NSDictionary *carrierDictionary = netInfo.serviceSubscriberCellularProviders;
            for (NSString *carrierKey in carrierDictionary) {
                CTCarrier *carrier = [carrierDictionary objectForKey:carrierKey];
                NSString *networkCode = carrier.mobileNetworkCode;
                break;
            }
        } else {
            CTCarrier *carrier = [netInfo subscriberCellularProvider];
            networkCode = carrier.mobileNetworkCode;
        }
        result(networkCode);
    } else if ([@"getProxySettings" isEqualToString:call.method]) {
        NSDictionary *dic = CFBridgingRelease(CFNetworkCopySystemProxySettings());
        NSArray *keys = [dic[@"__SCOPED__"] allKeys];
        result([keys componentsJoinedByString:@","]);
    } else if ([@"getLanguageCountryCode" isEqualToString:call.method]) {
        result([[NSLocale currentLocale] countryCode]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
