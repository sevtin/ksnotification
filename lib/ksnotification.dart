import 'dart:async';

import 'package:flutter/services.dart';

class Ksnotification {
  static const MethodChannel _channel = const MethodChannel('ksnotification');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

class KSNotificationCenter {
  KSNotificationCenter._();

  static KSNotificationCenter _instance;
  Map<String, List<KSObserver>> _notify;

  static KSNotificationCenter shard() {
    if (_instance == null) {
      _instance = KSNotificationCenter._();
      _instance._notify = Map<String, List<KSObserver>>();
    }
    return _instance;
  }

  /*添加监听*/
  addObserver(KSObserver observer, String name) {
    if (_notify.containsKey(name)) {
      List observers = _notify[name];
      bool result = observers.contains(observer);
      if (result == false) {
        observers.add(observer);
      }
    } else {
      _notify[name] = List<KSObserver>();
      _notify[name].add(observer);
    }
  }

  /*发送广播通知*/
  post(dynamic message, String name) {
    if (_notify.containsKey(name)) {
      for (KSObserver observer in _notify[name]) {
        observer.receiveNotify(message, name);
      }
    }
  }

  /*移除观察者的指定监听*/
  removeObserver(Object observer, String name) {
    if (_notify.containsKey(name)) {
      List observers = _notify[name];
      bool result = observers.contains(observer);
      if (result) {
        observers.remove(observer);
      }
    }
  }

  /*移除观察者的所有监听*/
  remove(KSObserver observer) {
    _notify.forEach((String key, List<KSObserver> value) {
      for (KSObserver _observer in value) {
        if (_observer == observer) {
          value.remove(observer);
        }
      }
    });
  }

  /*删除所有监听*/
  removeAll() {
    _notify.clear();
  }
}

/*观察者接口*/
abstract class KSObserver {
  receiveNotify(dynamic message, String name);
}
