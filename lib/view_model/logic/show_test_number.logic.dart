import 'dart:async';

import 'package:flutter/material.dart';

import '../../component.dart';
import '../../model/device_data.dart';

  showTestNumber(BuildContext context,int index,int time)async {
    try {
      final size=DeviceSize(context);
    return  await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.6,
            child: Card(
              child: Center(
                  child: OftenText(text: '第$index問', color: Colors.black)
                      .large(context)),
            ),
          );
        },
      ).timeout( Duration(seconds: time));
    } on TimeoutException {
      Navigator.pop(context);
    }
  }
