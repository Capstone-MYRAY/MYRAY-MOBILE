// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      accountId: json['account_id'] as int,
      bookmarkId: json['bookmark_id'] as int,
      createdDate: DateTime.parse(json['created_date'] as String),
      bookmarkNavigation:
          Account.fromJson(json['bookmark_navigation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      'account_id': instance.accountId,
      'bookmark_id': instance.bookmarkId,
      'created_date': instance.createdDate.toIso8601String(),
      'bookmark_navigation': instance.bookmarkNavigation,
    };
