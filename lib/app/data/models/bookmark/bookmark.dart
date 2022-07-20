import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/account.dart';

part 'bookmark.g.dart';

@JsonSerializable(includeIfNull: false)
class Bookmark {
  @JsonKey(name: 'account_id')
  int accountId;

  @JsonKey(name: 'bookmark_id')
  int bookmarkId;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'bookmark_navigation')
  Account bookmarkNavigation;

  @JsonKey(ignore: true)
  bool isBookmarked;

  Bookmark({
    required this.accountId,
    required this.bookmarkId,
    required this.createdDate,
    required this.bookmarkNavigation,
    this.isBookmarked = true,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
