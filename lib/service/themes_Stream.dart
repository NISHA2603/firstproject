import 'dart:async';

import 'package:flutter/material.dart';




class ThemeStreams{

  final _pinkController = StreamController<String>.broadcast();
  void setColors(String pink) => _pinkController.sink.add(pink);

  Stream<String> get pink => _pinkController.stream;


}