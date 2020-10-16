import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Drive {
  factory Drive() {
    return _instance;
  }

  Drive._();

  static final Drive _instance = Drive._();
  static GlobalKey<NavigatorState> _driveKey;

  GlobalKey<NavigatorState> get key {
    return _driveKey ??= _init();
  }

  GlobalKey<NavigatorState> _init() {
    return _driveKey = GlobalKey<NavigatorState>();
  }

  static Future<T> to<T>(Widget place, [Object arguments]) async {
    return await Drive().key.currentState.push(
          MaterialPageRoute<T>(
            builder: (BuildContext c) => place,
            settings: RouteSettings(arguments: arguments),
          ),
        );
  }

  static Future<T> toNamed<T>(String routeName, [Object arguments]) async {
    return await Drive().key.currentState.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T> replace<T>(Widget place, [Object arguments]) async {
    return await Drive().key.currentState.pushReplacement(
          MaterialPageRoute<T>(
            builder: (BuildContext c) => place,
            settings: RouteSettings(arguments: arguments),
          ),
        );
  }

  static void backUntil<T>(String lastRoute) async {
    return Drive().key.currentState.popUntil(ModalRoute.withName(lastRoute));
  }

  static Future<void> back<T extends Object>([T result]) async {
    Drive().key.currentState.pop<T>(result);
  }
}
