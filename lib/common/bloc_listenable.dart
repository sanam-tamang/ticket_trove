import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListenable<T> extends ChangeNotifier implements Listenable {
  final BlocBase<T> bloc;

  BlocListenable(this.bloc) {
    bloc.stream.listen((state) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
