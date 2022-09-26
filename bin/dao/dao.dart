abstract class DAO<T> {
  Future<bool> save(T value);
  Future<T?> findOne(int id) ;
  Future<List<T>> findAll();
  Future<bool> update(T value);
  Future<bool> delete(int id);
}