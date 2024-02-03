import 'package:logger/logger.dart';
import 'package:realm/realm.dart';

import '../../../common/exceptions/base_exception.dart';
import '../../../domain/category/category.dart';
import '../../../domain/category/category_repository.dart';
import '../../../domain/category/exceptions/create_category_exception.dart';
import '../../../domain/category/exceptions/delete_category_exception.dart';
import '../../../domain/category/exceptions/get_category_exception.dart';
import '../../../domain/category/exceptions/update_category_exception.dart';
import '../../data/db/category.dart' as realm;

class CategoryRepositoryImpl implements CategoryRepository {
  final Realm _realm;

  CategoryRepositoryImpl(this._realm);

  @override
  Future<Category> create(Category category) async {
    try {
      final createdCategoryModel = category.toRealmModel();
      _realm.write(() {
        _realm.add(createdCategoryModel);
      });
      return category;
    } catch (e, stackTrace) {
      Logger().e('カテゴリ作成エラー:$e', stackTrace: stackTrace);
      throw CreateCategoryException('');
    }
  }

  @override
  Future<List<Category>> getAll() async {
    try {
      final categoryModel = _realm.all<realm.Category>();
      return categoryModel.map((e) => e.toDomainModel()).toList();
    } catch (e, stackTrace) {
      Logger().e('カテゴリ取得エラー:$e', stackTrace: stackTrace);
      throw GetCategoryException('');
    }
  }

  @override
  Future<Category> update(Category category) async {
    try {
      final categoryModel = _realm.find<realm.Category>(category.id);
      if (categoryModel == null) throw BaseException('');
      _realm.write(() {
        categoryModel.name = category.name;
      });
      return categoryModel.toDomainModel();
    } catch (e, stackTrace) {
      Logger().e('カテゴリ更新エラー:$e', stackTrace: stackTrace);
      throw UpdateCategoryException('');
    }
  }

  @override
  Future<Category> delete(Category category) async {
    try {
      final categoryModel = _realm.find<realm.Category>(category.id);
      if (categoryModel == null) throw BaseException('');
      _realm.write(() {
        _realm.delete(categoryModel);
      });
      return category;
    } catch (e, stackTrace) {
      Logger().e('カテゴリ削除エラー:$e', stackTrace: stackTrace);
      throw DeleteCategoryException('');
    }
  }
}
