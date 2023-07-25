import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_network_code_method_channel.dart';

abstract class IosNetworkCodePlatform extends PlatformInterface {
  /// Constructs a IosNetworkCodePlatform.
  IosNetworkCodePlatform() : super(token: _token);

  static final Object _token = Object();

  static IosNetworkCodePlatform _instance = MethodChannelIosNetworkCode();

  /// The default instance of [IosNetworkCodePlatform] to use.
  ///
  /// Defaults to [MethodChannelIosNetworkCode].
  static IosNetworkCodePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosNetworkCodePlatform] when
  /// they register themselves.
  static set instance(IosNetworkCodePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getMobileCountryCode() {
    throw UnimplementedError('getMobileCountryCode() has not been implemented.');
  }

  Future<String?> getMobileNetworkCode() {
    throw UnimplementedError('getMobileNetworkCode() has not been implemented.');
  }

  Future<String?> getProxySettings() {
    throw UnimplementedError('getProxySettings() has not been implemented.');
  }

  Future<String?> getLanguageCountryCode() {
    throw UnimplementedError('getLanguageCountryCode() has not been implemented.');
  }
}
