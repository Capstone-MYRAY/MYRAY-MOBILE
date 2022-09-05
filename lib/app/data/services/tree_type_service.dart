
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/tree_type/get_tree_type_request.dart';
import 'package:myray_mobile/app/data/models/tree_type/get_tree_type_response.dart';
import 'package:myray_mobile/app/data/services/services.dart';

mixin TreeTypeService{

  final TreeTypeRepository _treeTypeRepository = Get.find<TreeTypeRepository>();

  Future<GetTreeTypeResponse?> getTreeTypeList(GetTreeTypeRequest data) async {
    return await _treeTypeRepository.getList(data);
  } 
  
}