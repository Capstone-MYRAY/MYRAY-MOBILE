import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';

part 'get_payment_history_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetPaymentHistoryRequest {
  @JsonKey(name: 'jobPostId')
  String? jobPostId;

  @JsonKey(name: 'createdBy')
  String? createdBy;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'minDate')
  DateTime? fromDate;

  @JsonKey(name: 'maxDate')
  DateTime? toDate;

  @JsonKey(name: 'sort-column')
  PaymentHistorySortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'page-size')
  String pageSize;

  GetPaymentHistoryRequest({
    required this.page,
    required this.pageSize,
    this.jobPostId,
    this.createdBy,
    this.status,
    this.orderBy,
    this.sortColumn,
    this.fromDate,
    this.toDate,
  });

  factory GetPaymentHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPaymentHistoryRequestToJson(this);
}
