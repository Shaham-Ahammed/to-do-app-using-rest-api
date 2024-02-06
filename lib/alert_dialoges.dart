 import 'package:flutter/material.dart';

updateSuccessMessage(BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Center(child: Text("data updated"))));
  }

  deleteSuccessMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Center(child: Text("data deleted"))));
  }
  successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Center(child: Text("data added"))));
  }

  failureMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Center(
            child: Text(
          "failed to add data",
          style: TextStyle(color: Colors.white),
        ))));
  }