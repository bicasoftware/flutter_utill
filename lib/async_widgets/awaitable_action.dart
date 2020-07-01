import 'package:flutter/widgets.dart';
import 'package:flutter_utils/dialogs/dialogs.dart';

class AsyncDialog {
  static Future<void> run(
    BuildContext context,
    GlobalKey<State> globalKey,
    Future<void> Function() doAsync, {
    void Function(Exception e) onError,
  }) async {
    // ignore: unawaited_futures
    Dialogs.showAwaitingDialog(context: context, key: globalKey);
    try {
      await doAsync();
    } catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        print(e);
      }
    } finally {
      Navigator.of(globalKey.currentContext, rootNavigator: true).pop();
    }
  }

  static Future<T> provide<T>(
    BuildContext context,
    GlobalKey<State> globalKey,
    Future<T> Function() doAsync, {
    void Function(Exception e) onError,
  }) async {
    T data;
    // ignore: unawaited_futures
    Dialogs.showAwaitingDialog(context: context, key: globalKey);
    try {
      data = await doAsync();
    } catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        print(e);
      }
    } finally {
      Navigator.of(globalKey.currentContext, rootNavigator: true).pop();
    }

    return data;
  }
}
