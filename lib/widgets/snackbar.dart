import 'package:another_flushbar/flushbar.dart';
import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';
import 'package:vibration/vibration.dart';

enum SnackbarType { success, error, warning }

Future<void> showSnackbar(
    String message, {
      SnackbarType type = SnackbarType.warning,
    }) async {
  Color backgroundColor;
  Icon icon;

  switch (type) {
    case SnackbarType.success:
      backgroundColor = Colors.green;
      icon = Icon(Icons.check_circle, color: backgroundColor, size: 25);
      break;
    case SnackbarType.error:
      backgroundColor = Colors.red;
      icon = Icon(Icons.error, color: backgroundColor, size: 25);
      break;
    case SnackbarType.warning:
      backgroundColor = FMColors.primary;
      icon = Icon(Icons.warning_rounded, color: backgroundColor, size: 25);
      break;
  }

  // Vibração diferente para cada tipo
  if (await Vibration.hasVibrator()) {
    switch (type) {
      case SnackbarType.success:
      // vibra super rápido (pulsos curtos)
        Vibration.vibrate(pattern: [0, 50, 50, 50, 50, 50]);
        break;
      case SnackbarType.warning:
      // vibra 3 vezes rápido
        Vibration.vibrate(pattern: [0, 100, 50, 100, 50, 100]);
        break;
      case SnackbarType.error:
      // vibra 1 segundo direto
        Vibration.vibrate(duration: 1000);
        break;
    }
  }

  Flushbar(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 17, bottom: 17),
    icon: icon,
    message: message,
    messageColor: backgroundColor,
    backgroundColor: Colors.white,
    borderColor: backgroundColor,
    borderWidth: 1,
    borderRadius: BorderRadius.circular(AppRadius.normal),
    margin: const EdgeInsets.only(right: 16, left: 16, top: 30),
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    animationDuration: const Duration(milliseconds: 600),
  ).show(AppContext.context);
}
