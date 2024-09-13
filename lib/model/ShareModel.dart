import 'categoryModel.dart';

class ShareModel extends CategoryModel {
  Function() GoLinke;

  ShareModel(
      {required this.GoLinke, required super.label, required super.imgPath});
}
