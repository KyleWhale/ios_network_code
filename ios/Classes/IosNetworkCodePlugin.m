#import "IosNetworkCodePlugin.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation IosNetworkCodePlugin

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (IosNetworkCodePlugin *)shared {
    static IosNetworkCodePlugin *plugin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        plugin = [[IosNetworkCodePlugin alloc] init];
    });
    return plugin;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"ios_network_code" binaryMessenger:[registrar messenger]];
    IosNetworkCodePlugin *instance = [[IosNetworkCodePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    [[NSNotificationCenter defaultCenter] addObserver:[IosNetworkCodePlugin shared] selector:@selector(screenCaptureChange) name:UIScreenCapturedDidChangeNotification object:nil];
}

- (void)screenCaptureChange {
    
    if ([UIScreen mainScreen].isCaptured) {
        if (self.checkConnectCallback) self.checkConnectCallback(nil);
    } else {
        if (self.checkDisconnectCallback) self.checkDisconnectCallback(nil);
    }
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getMobileCountryCode" isEqualToString:call.method]) {
        NSString *countryCode = @"";
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        if (@available(iOS 12.0, *)) {
            NSDictionary *carrierDictionary = netInfo.serviceSubscriberCellularProviders;
            for (NSString *carrierKey in carrierDictionary) {
                CTCarrier *carrier = [carrierDictionary objectForKey:carrierKey];
                countryCode = carrier.mobileCountryCode;
                if (countryCode && countryCode.length > 0) {
                    break;
                }
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
                networkCode = carrier.mobileNetworkCode;
                if (networkCode && networkCode.length > 0) {
                    break;
                }
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
    } else if ([@"checkConnect" isEqualToString:call.method]) {
        [IosNetworkCodePlugin shared].checkConnectCallback = result;
    } else if ([@"checkDisconnect" isEqualToString:call.method]) {
        [IosNetworkCodePlugin shared].checkDisconnectCallback = result;
    } else if ([@"checkConnectState" isEqualToString:call.method]) {
        result(@([UIScreen mainScreen].isCaptured));
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
