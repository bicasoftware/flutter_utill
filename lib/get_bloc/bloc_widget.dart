import 'package:flutter/widgets.dart';
import 'package:flutter_utils/get_bloc/base_bloc.dart';
import 'package:get/get.dart';

mixin BlocWidget<T extends StatefulWidget, B extends BaseBloc> on State<T> {
  B _b;

  B get bloc => _b;

  @override
  void initState() {
    super.initState();
    _b = Get.find<B>();
  }

  @override
  void dispose() {
    super.dispose();
    _b.dispose();
    Get.delete<B>().whenComplete(() {});
  }
}
