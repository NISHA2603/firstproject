import 'dart:async';

import 'package:firstproject/ui/screens/connectivity_check.dart';

class ConnectivityStreams {
  final conStreamsContr = StreamController<bool>.broadcast();

  Stream<bool> get conn => conStreamsContr.stream;

  processConn() async {
    bool isintr = await ConnectivityCheck().isInternet();
    print("internet $isintr");
    conStreamsContr.sink.add(isintr);

    conn.listen((event) {
      print("event" + event.toString());
    });
  }
}

var contStream= ConnectivityStreams();
