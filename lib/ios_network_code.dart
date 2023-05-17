
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
}
