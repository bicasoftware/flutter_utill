import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/awaiting_container.dart';
import 'package:rxdart/rxdart.dart';

class MergedStreamObserver extends StatelessWidget {
  final List<Stream> streams;
  final Widget Function(BuildContext context, List<Object> data) onSuccess;
  final Widget Function(BuildContext context) onAwaiting;
  final Widget Function(BuildContext context, Error erro) onError;

  Function get _defaultError => (context, error) => Center(child: Text(error));

  Function get _defaultAwaiting => (context) => AwaitingContainer();

  const MergedStreamObserver({
    Key key,
    @required this.streams,
    @required this.onSuccess,
    this.onAwaiting,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<List> zipStream = Rx.combineLatestList(streams);
    return StreamBuilder<List<Object>>(
      stream: zipStream,
      builder: (context, AsyncSnapshot<Object> snapshot) {
        if (snapshot.hasError) {
          return onError == null
              ? _defaultError(context, snapshot.error)
              : onError(context, snapshot.error);
        }

        if (!snapshot.hasData) {
          return onAwaiting == null
              ? _defaultAwaiting(context)
              : onAwaiting(context);
        } else {
          return onSuccess(context, snapshot.data);
        }
      },
    );
  }
}
