import 'package:flutter/widgets.dart';
import 'package:flutter_utils/async_widgets/awaiting_container.dart';

class FutureObserver<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T? data) onSuccess;
  final Widget Function(BuildContext context)? onAwaiting;
  final Widget Function(BuildContext context, Object? erro)? onError;

  Function get _defaultError => (context, error) => Center(child: Text(error));

  Function get _defaultAwaiting => (context) => AwaitingContainer();

  const FutureObserver({
    required this.future,
    required this.onSuccess,
    this.onAwaiting,
    this.onError,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return onError == null
              ? _defaultError(context, snapshot.error)
              : onError!(context, snapshot.error);
        }

        if (!snapshot.hasData) {
          return onAwaiting == null
              ? _defaultAwaiting(context)
              : onAwaiting!(context);
        } else {
          return onSuccess(context, snapshot.data);
        }
      },
    );
  }
}
