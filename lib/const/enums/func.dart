
import 'package:flutter/material.dart';

String getInitials(String fullName) {
  List<String> nameParts = fullName.split(' ');
  String initials = '';

  for (String part in nameParts) {
    if (part.isNotEmpty) {
      initials += part[0];
    }
  }

  return initials;
}
unfocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
