import 'package:floor/floor.dart';

abstract class BaseDao<T> {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertEntity(T entity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertList(List<T> entities);

  @update
  Future<int> updateEntity(T entity);

  @delete
  Future<int> deleteEntity(T entity);

}