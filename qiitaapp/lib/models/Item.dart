import 'package:qiitaapp/models/tag.dart';
import 'package:qiitaapp/models/user.dart';

class Item {
  final String id;
  final String title;
  final String renderedBody;
  final DateTime createdAt;
  final int likesCount;
  final List<Tag> tags;
  final User user;

  Item({
    this.id,
    this.title,
    this.renderedBody,
    this.createdAt,
    this.likesCount,
    this.tags,
    this.user,
  });
}
