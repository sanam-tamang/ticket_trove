import 'dart:developer';

import 'package:flutter/foundation.dart';

void debugLog(String data) {
  if(kDebugMode){
    log(data);

  }
}
