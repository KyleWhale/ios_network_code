import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_network_code_platform_interface.dart';

/// An implementation of [IosNetworkCodePlatform] that uses method channels.
class MethodChannelIosNetworkCode extends IosNetworkCodePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_network_code');

  @override
  Future<String?> getMobileCountryCode() async {
    final code = await methodChannel.invokeMethod<String>('getMobileCountryCode');
    return code;
  }

  @override
  Future<String?> getMobileNetworkCode() async {
    final code = await methodChannel.invokeMethod<String>('getMobileNetworkCode');
    return code;
  }

  @override
  Future<String?> getProxySettings() async {
    final code = await methodChannel.invokeMethod<String>('getProxySettings');
    return code;
  }

  @override
  Future<String?> getLanguageCountryCode() async {
    final code = await methodChannel.invokeMethod<String>('getLanguageCountryCode');
    return code;
  }
}
