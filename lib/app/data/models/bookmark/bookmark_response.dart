
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/account.dart';
part 'bookmark_response.g.dart';

@JsonSerializable(includeIfNull: false)
class BookmarkResponse{

  @JsonKey(name: 'account_id')
  int accountId;

  @JsonKey(name: 'bookmark_id')
  int bookmarkId;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'bookmark_navigation')
  Account bookmarkNavigation;

  
  BookmarkResponse({
    required this.accountId,
    required this.bookmarkId,
    required this.createdDate,
    required this.bookmarkNavigation,
  });

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) => _$BookmarkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkResponseToJson(this);

}

// {
//       "account_id": 35,
//       "bookmark_id": 33,
//       "created_date": "2022-07-17T04:27:17.000Z",
//       "bookmark_navigation": {
//         "id": 33,
//         "role_id": 3,
//         "fullname": "Diep Nguyen",
//         "date_of_birth": "2000-06-19T17:00:00.000Z",
//         "gender": 0,
//         "phone_number": "+84962467699",
//         "balance": 40000,
//         "point": 0,
//         "area_accounts": []
//       }
//     },
