import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/dictionary.dart';
import 'package:flutter_utils/context_helper.dart';

class Dialogs {
  static Future<void> showAwaitingDialog({
    BuildContext context,
    String awaitingText,
    GlobalKey key,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            children: <Widget>[
              Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text(awaitingText),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static Future<bool> showConfirmationDialog({
    @required BuildContext context,
    String title = Dictionary.atencao,
    String message = Dictionary.descartarAlteracoes,
    String negativeCaption = Dictionary.nao,
    String positiveCaption = Dictionary.sim,
  }) async {
    return await showDialog(
      context: context,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(
              negativeCaption,
              style: context.textTheme.button.copyWith(color: Colors.black87),
            ),
            onPressed: () {
              context.goBack(false);
            },
          ),
          FlatButton(
            child: Text(positiveCaption),
            onPressed: () {
              context.goBack(true);
            },
          ),
        ],
      ),
    );
  }

  static Future<String> showIntegerDialog({
    @required BuildContext context,
    @required String initValue,
    @required String label,
    @required String title,
    @required int maxLength,
    String confirmButton = Dictionary.salvar,
    String cancelButton = Dictionary.cancelar,
  }) async {
    final _formKey = GlobalKey<FormState>();

    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(title),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        content: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TextFormField(
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(maxLength),
              ],
              decoration: InputDecoration(
                hintText: "9999",
                labelText: label,
              ),
              keyboardType: TextInputType.number,
              initialValue: initValue,
              onSaved: (s) {
                initValue = s;
              },
              validator: (s) {
                if (int.tryParse(s) == null) {
                  return Messages.numeroInvalido;
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              cancelButton,
              style: Theme.of(context).textTheme.button.copyWith(color: Colors.black87),
            ),
            onPressed: () => context.goBack(),
          ),
          FlatButton(
            child: const Text(Dictionary.salvar),
            onPressed: () {
              final state = _formKey.currentState;
              if (state.validate()) {
                state.save();
                context.goBack(initValue);
              }
            },
          ),
        ],
      ),
    );
  }

  static Future<int> showOptionsDialog({
    @required BuildContext context,
    @required List<String> options,
    @required String title,
  }) async {
    return await showDialog(
      context: context,
      child: SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        title: Text(title),
        children: <Widget>[
          for (int i = 0; i < options.length; i++)
            SimpleDialogOption(
              child: Text(options[i]),
              onPressed: () => context.goBack(i),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            )
        ],
      ),
    );
  }
}
