import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_app/data/services/network_service.dart';
import 'package:post_app/domain/repositories/post_repository.dart';

late final PostRepository repository;

Future<void> serviceLocator() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  repository = PostRepositoryImpl(
    network: HttpNetwork(),
  );
}
