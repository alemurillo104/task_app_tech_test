import 'package:flutter/material.dart';

showDialogWidget(
  context, {
  required String title,
  required String description,
  IconData icon = Icons.warning,
  TextStyle titleType = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  TextStyle descriptionType = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  String textButton = 'Cerrar',
  TextStyle textButtonType = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  Function()? onPressed,
}) {
  return _showDialogGeneric(
    context,
    title: title,
    icon: icon,
    titleType: titleType,
    description: description,
    descriptionType: descriptionType,
    textButton: textButton,
    textButtonType: textButtonType,
    onPressed: onPressed,
  );
}

_showDialogGeneric(
  BuildContext context, {
  required String title,
  required IconData icon,
  required TextStyle titleType,
  required String description,
  required TextStyle descriptionType,
  required String textButton,
  required TextStyle textButtonType,
  Function()? onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (contextDialog) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Center(
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: titleType,
              ),
            ],
          ),
        ),
        content: Text(
          description,
          style: descriptionType,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed ?? () => Navigator.pop(contextDialog),
            style: TextButton.styleFrom(
              foregroundColor: Colors.deepPurpleAccent.shade100,
            ),
            child: Text(
              textButton,
              style: textButtonType.copyWith(
                color: Colors.deepPurpleAccent.shade700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

showDialogCustomWidget(
  context, {
  required String title,
  required String description,
  TextStyle titleType = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  TextStyle descriptionType = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  String textButton = 'Cerrar',
  TextStyle textButtonType = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  Function()? leftOnPressed,
  required String okButton,
  TextStyle okButtonType = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  Function()? rightOnPressed,
}) {
  return _showDialogCustom(
    context,
    title: title,
    titleType: titleType,
    description: description,
    descriptionType: descriptionType,
    textButton: textButton,
    textButtonType: textButtonType,
    leftOnPressed: leftOnPressed,
    okButton: okButton,
    okButtonType: okButtonType,
    rightOnPressed: rightOnPressed,
  );
}

_showDialogCustom(
  BuildContext context, {
  required String title,
  required TextStyle titleType,
  required String description,
  required TextStyle descriptionType,
  required String textButton,
  required TextStyle textButtonType,
  required String okButton,
  required TextStyle okButtonType,
  Function()? leftOnPressed,
  Function()? rightOnPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (contextDialog) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Center(
          child: Column(
            children: [
              const Icon(Icons.delete_outline),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: titleType,
              ),
            ],
          ),
        ),
        content: Text(
          description,
          style: descriptionType,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: leftOnPressed ?? () => Navigator.pop(contextDialog),
            style: TextButton.styleFrom(
              foregroundColor: Colors.deepPurpleAccent.shade100,
            ),
            child: Text(
              textButton,
              style: textButtonType.copyWith(
                color: Colors.deepPurpleAccent.shade700,
              ),
            ),
          ),
          TextButton(
            onPressed: rightOnPressed ?? () => Navigator.pop(contextDialog),
            style: TextButton.styleFrom(
              foregroundColor: Colors.deepPurpleAccent.shade100,
            ),
            child: Text(okButton,
                style: okButtonType.copyWith(
                  color: Colors.deepPurpleAccent.shade700,
                )),
          ),
        ],
      ),
    ),
  );
}
