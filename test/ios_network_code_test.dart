import 'package:flutter_test/flutter_test.dart';
import 'package:ios_network_code/ios_network_code.dart';
import 'package:ios_network_code/ios_network_code_platform_interface.dart';
import 'package:ios_network_code/ios_network_code_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosNetworkCodePlatform
    with MockPlatformInterfaceMixin
    implements IosNetworkCodePlatform {

  @override
  Future<String?> getMobileNetworkCode() => Future.value('42');

  @override
  Future<String?> getMobileCountryCode() => Future.value('42');

  @override
  Future<String?> getProxySettings() => Future.value('42');

  @override
  Future<String?> getLanguageCountryCode() => Future.value('42');

  @override
  Future<void> checkConnect() => Future.value();

  @override
  Future<void> checkDisconnect() => Future.value();
}

void main() {
  final IosNetworkCodePlatform initialPlatform = IosNetworkCodePlatform.instance;

  test('$MethodChannelIosNetworkCode is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosNetworkCode>());
  });

  test('getMobileNetworkCode', () async {
    MockIosNetworkCodePlatform fakePlatform = MockIosNetworkCodePlatform();
    IosNetworkCodePlatform.instance = fakePlatform;
    expect(await IosNetworkCode.getMobileNetworkCode(), '42');
  });
}
