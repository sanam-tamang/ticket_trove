import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

ToastFuture? toastMessage(BuildContext context, {required String? data}) {

  return data!=null? showToastWidget(
    Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
            color: const Color(0xff111111),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          data,
          style: const TextStyle(color: Color.fromARGB(255, 244, 235, 235)),
        )),
    animation: StyledToastAnimation.slideFromLeftFade,
    context: context,
    isIgnoring: false,
    duration: const Duration(milliseconds: 5000),
  ): null;
}
