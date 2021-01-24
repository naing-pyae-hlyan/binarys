import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(BuildContext context, {@required String data}) {
  Clipboard.setData(ClipboardData(text: data)).then(
    (value) => Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard.'),
        duration: Duration(milliseconds: 1000),
      ),
    ),
  );
}
