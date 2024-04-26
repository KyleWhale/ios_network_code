
import 'ios_network_code_platform_interface.dart';

class IosNetworkCode {

  static Future<String?> getMobileCountryCode() {
    return IosNetworkCodePlatform.instance.getMobileCountryCode();
  }

  static Future<String?> getMobileNetworkCode() {
    return IosNetworkCodePlatform.instance.getMobileNetworkCode();
  }

  static Future<String?> getProxySettings() {
    return IosNetworkCodePlatform.instance.getProxySettings();
  }

  static Future<String?> getLanguageCountryCode() {
    return IosNetworkCodePlatform.instance.getLanguageCountryCode();
  }

  static Future<void> checkConnect() {
    return IosNetworkCodePlatform.instance.checkConnect();
  }

  static Future<void> checkDisconnect() {
    return IosNetworkCodePlatform.instance.checkDisconnect();
  }

  static Future<void> checkConnectState() {
    return IosNetworkCodePlatform.instance.checkConnectState();
  }
}
