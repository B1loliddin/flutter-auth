import 'package:flutter/material.dart';
import 'package:post_app/app.dart';
import 'package:post_app/core/service_locator.dart';

void main() async {
  await serviceLocator();

  runApp(const PostApp());
}
