import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_network_code/ios_network_code_method_channel.dart';

void main() {
  MethodChannelIosNetworkCode platform = MethodChannelIosNetworkCode();
  const MethodChannel channel = MethodChannel('ios_network_code');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getMobileNetworkCode', () async {
    expect(await platform.getMobileNetworkCode(), '42');
  });
}
