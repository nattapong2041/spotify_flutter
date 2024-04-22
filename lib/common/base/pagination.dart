class Pagination<T> {
  int _offset;
  final int _limit;
  int _total;
  bool _hasNext = true;
  final List<T> _list;

  Pagination({
    int offset = 0,
    int limit = 10,
    int total = 0,
    bool hasNext = true,
    List<T> items = const [],
  })  : _offset = offset,
        _limit = limit,
        _total = total,
        _hasNext = hasNext,
        _list = List<T>.from(items);

  bool get hasNext => _hasNext;
  int get offset => _offset;
  int get total => _total;
  int get limit => _limit;
  List<T> get list => _list;

  void setNext(List<T> list, int offset, int total, bool hasNext) {
    _list.addAll(list);
    _offset = offset;
    _total = total;
    _hasNext = hasNext;
  }
}
