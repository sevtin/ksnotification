import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksnotification/ksnotification.dart';

void main() {
  const MethodChannel channel = MethodChannel('ksnotification');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Ksnotification.platformVersion, '42');
  });
}
