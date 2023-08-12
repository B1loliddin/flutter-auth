import 'dart:convert';

import 'package:post_app/core/apis.dart';
import 'package:post_app/data/services/network_service.dart';
import 'package:post_app/domain/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> fetchAllPosts();
}

class PostRepositoryImpl implements PostRepository {
  final Network network;

  const PostRepositoryImpl({required this.network});

  @override
  Future<List<Post>> fetchAllPosts() async {
    final String response = await network.get(api: Api.apiPosts) ?? '[]';
    final List json = jsonDecode(response) as List;

    return json
        .map((json) => Post.fromJson(json as Map<String, Object?>))
        .toList();
  }
}
