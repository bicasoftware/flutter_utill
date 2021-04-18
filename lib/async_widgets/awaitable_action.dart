import 'package:flutter/widgets.dart';
import 'package:flutter_utils/dialogs/dialogs.dart';

class AsyncDialog {
  static Future<void> run(
    String awaitingText,
    BuildContext context,
    GlobalKey<State> globalKey,
    Future<void> Function() doAsync, {
    void Function(Object? e)? onError,
  }) async {
    // ignore: unawaited_futures
    Dialogs.showAwaitingDialog(
      context: context,
      key: globalKey,
      awaitingText: awaitingText,
    );
    try {
      await doAsync();
    } catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        print(e);
      }
    } finally {
      Navigator.of(globalKey.currentContext!, rootNavigator: true).pop();
    }
  }

  static Future<T?> provide<T>(
    String awaitingText,
    BuildContext context,
    GlobalKey<State> globalKey,
    Future<T> Function() doAsync, {
    void Function(Object? e)? onError,
  }) async {
    T? data;
    Dialogs.showAwaitingDialog(
      context: context,
      key: globalKey,
      awaitingText: awaitingText,
    );
    try {
      data = await doAsync();
    } catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        print(e);
      }
    } finally {
      Navigator.of(globalKey.currentContext!, rootNavigator: true).pop();
    }
    return data;
  }
}
