import 'dart:async';

import 'package:flutter/services.dart';

class Ksnotification {
  static const MethodChannel _channel = const MethodChannel('ksnotification');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

typedef KSCallback = void Function(dynamic message);

class KSNotificationCenter {
  KSNotificationCenter._();

  static KSNotificationCenter _instance;
  Map<String, List<KSCallback>> _notify;

  static KSNotificationCenter shard() {
    if (_instance == null) {
      _instance = KSNotificationCenter._();
      _instance._notify = Map<String, List<KSCallback>>();
    }
    return _instance;
  }

  /*添加监听回调*/
  addListener(String name, KSCallback callback) {
    if (_notify.containsKey(name)) {
      List callbacks = _notify[name];
      bool result = callbacks.contains(callback);
      if (result == false) {
        callbacks.add(callback);
      }
    } else {
      _notify[name] = List<KSCallback>();
      _notify[name].add(callback);
    }
  }

  /*发送广播*/
  post(String name, dynamic message) {
    if (_notify.containsKey(name)) {
      for (KSCallback callback in _notify[name]) {
        callback(message);
      }
    }
  }

  /*移除观察者的指定监听回调*/
  removeListener(String name, KSCallback callback) {
    if (_notify.containsKey(name)) {
      List callbacks = _notify[name];
      bool result = callbacks.contains(callback);
      if (result) {
        callbacks.remove(callback);
      }
    }
  }

  /*移除观察者的所有监听回调*/
  remove(KSCallback callback) {
    _notify.forEach((String key, List<KSCallback> value) {
      value.removeWhere((_callback) => _callback == callback);
    });
  }

  /*删除所有监听回调*/
  removeAll() {
    _notify.clear();
  }
}
