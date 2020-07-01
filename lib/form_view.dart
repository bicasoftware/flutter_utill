import 'package:flutter/material.dart';
import 'package:flutter_utils/dialogs/dialogs.dart';
import 'package:flutter_utils/dictionary.dart';
import 'package:get/get.dart';

mixin WillPopForm {
  Future<bool> willPop({
    @required BuildContext context,
    @required FormState formState,
    @required bool isCreating,
    @required bool hasChanged,
  }) async {
    if (isCreating) {
      return true;
    } else if (formState.validate()) {
      formState.save();
      if (hasChanged) {
        final r = await Dialogs.showConfirmationDialog(
          context: context,
          title: Dictionary.atencao,
          message: Dictionary.descartarAlteracoes,
          positiveCaption: Dictionary.descartar,
        );

        return r ?? true;
      } else {
        return true;
      }
    }

    return false;
  }

  void doSave({
    @required BuildContext context,
    @required FormState formState,
    @required dynamic resultData,
  }) {
    if (formState.validate()) {
      formState.save();
      Get.back(result: resultData);
      Navigator.of(context).pop<Object>(resultData);
    }
  }
}
