import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum FilterType {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  whereIn,
  whereNotIn,
  isNull,
  isNotNull,
}

class FirestoreFilter {
  final String field;
  final FilterType type;
  final dynamic value;

  const FirestoreFilter({
    required this.field,
    required this.type,
    this.value,
  });

  // Convenience constructors
  FirestoreFilter.isEqualTo(this.field, this.value) : type = FilterType.isEqualTo;
  FirestoreFilter.isNotEqualTo(this.field, this.value) : type = FilterType.isNotEqualTo;
  FirestoreFilter.isLessThan(this.field, this.value) : type = FilterType.isLessThan;
  FirestoreFilter.isLessThanOrEqualTo(this.field, this.value) : type = FilterType.isLessThanOrEqualTo;
  FirestoreFilter.isGreaterThan(this.field, this.value) : type = FilterType.isGreaterThan;
  FirestoreFilter.isGreaterThanOrEqualTo(this.field, this.value) : type = FilterType.isGreaterThanOrEqualTo;
  FirestoreFilter.arrayContains(this.field, this.value) : type = FilterType.arrayContains;
  FirestoreFilter.arrayContainsAny(this.field, this.value) : type = FilterType.arrayContainsAny;
  FirestoreFilter.whereIn(this.field, this.value) : type = FilterType.whereIn;
  FirestoreFilter.whereNotIn(this.field, this.value) : type = FilterType.whereNotIn;
  FirestoreFilter.isNull(this.field)
      : type = FilterType.isNull,
        value = null;
  FirestoreFilter.isNotNull(this.field)
      : type = FilterType.isNotNull,
        value = null;
}

class FirestoreOrderBy {
  final String field;
  final bool descending;

  const FirestoreOrderBy({
    required this.field,
    this.descending = false,
  });

  FirestoreOrderBy.asc(this.field) : descending = false;
  FirestoreOrderBy.desc(this.field) : descending = true;
}

/// Simple Firestore pagination service
class FirestorePaginationService<T> {
  final Query<Map<String, dynamic>> baseQuery;
  final T Function(Map<String, dynamic> json, String id) fromJson;
  final int pageSize;

  final List<FirestoreFilter> _filters = [];
  final List<FirestoreOrderBy> _orderBy = [];

  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoading = false;

  FirestorePaginationService({
    required this.baseQuery,
    required this.fromJson,
    this.pageSize = 20,
    List<FirestoreFilter>? initialFilters,
    List<FirestoreOrderBy>? initialOrderBy,
  }) {
    if (initialFilters != null) _filters.addAll(initialFilters);
    if (initialOrderBy != null) _orderBy.addAll(initialOrderBy);
  }

  // Getters
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  // Filter methods
  void addFilter(FirestoreFilter filter) {
    _filters.add(filter);
    _resetPagination();
  }

  void clearFilters() {
    _filters.clear();
    _resetPagination();
  }

  // Order methods
  void addOrderBy(FirestoreOrderBy orderBy) {
    _orderBy.add(orderBy);
    _resetPagination();
  }

  void clearOrderBy() {
    _orderBy.clear();
    _resetPagination();
  }

  Query<Map<String, dynamic>> _applyFilter(Query<Map<String, dynamic>> query, FirestoreFilter filter) {
    switch (filter.type) {
      case FilterType.isEqualTo:
        return query.where(filter.field, isEqualTo: filter.value);
      case FilterType.isNotEqualTo:
        return query.where(filter.field, isNotEqualTo: filter.value);
      case FilterType.isLessThan:
        return query.where(filter.field, isLessThan: filter.value);
      case FilterType.isLessThanOrEqualTo:
        return query.where(filter.field, isLessThanOrEqualTo: filter.value);
      case FilterType.isGreaterThan:
        return query.where(filter.field, isGreaterThan: filter.value);
      case FilterType.isGreaterThanOrEqualTo:
        return query.where(filter.field, isGreaterThanOrEqualTo: filter.value);
      case FilterType.arrayContains:
        return query.where(filter.field, arrayContains: filter.value);
      case FilterType.arrayContainsAny:
        return query.where(filter.field, arrayContainsAny: filter.value);
      case FilterType.whereIn:
        return query.where(filter.field, whereIn: filter.value);
      case FilterType.whereNotIn:
        return query.where(filter.field, whereNotIn: filter.value);
      case FilterType.isNull:
        return query.where(filter.field, isNull: true);
      case FilterType.isNotNull:
        return query.where(filter.field, isNull: false);
    }
  }

  Query<Map<String, dynamic>> _buildQuery() {
    Query<Map<String, dynamic>> query = baseQuery.limit(pageSize);

    // Apply filters
    for (final filter in _filters) {
      query = _applyFilter(query, filter);
    }

    // Apply ordering
    for (final order in _orderBy) {
      query = query.orderBy(order.field, descending: order.descending);
    }

    return query;
  }

  /// Fetch the first page of data
  Future<List<T>> fetchFirstPage() async {
    if (_isLoading) return [];

    _isLoading = true;
    _lastDocument = null;
    _hasMore = true;

    try {
      return await _fetchData();
    } finally {
      _isLoading = false;
    }
  }

  /// Fetch the next page of data
  Future<List<T>> fetchNextPage() async {
    if (_isLoading || !_hasMore) return [];

    _isLoading = true;

    try {
      return await _fetchData();
    } finally {
      _isLoading = false;
    }
  }

  /// Fetch data with pagination
  Future<List<T>> _fetchData() async {
    Query<Map<String, dynamic>> query = _buildQuery();

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final snapshot = await query.get();
    final docs = snapshot.docs;

    final items = docs.map((doc) {
      final data = doc.data();
      return fromJson(data, doc.id);
    }).toList();

    if (docs.isNotEmpty) _lastDocument = docs.last;
    _hasMore = items.length == pageSize;

    return items;
  }

  /// Refresh the data (reset pagination and fetch first page)
  Future<List<T>> refresh() async {
    _resetPagination();
    return await fetchFirstPage();
  }

  void _resetPagination() {
    _lastDocument = null;
    _hasMore = true;
  }

  /// Reset the service to initial state
  void reset() {
    _lastDocument = null;
    _hasMore = true;
    _isLoading = false;
    _filters.clear();
    _orderBy.clear();
  }
}

/// Legacy class for backward compatibility with PagingController
class GenericFirestorePagingController<T> {
  final PagingController<int, T> pagingController;
  final FirestorePaginationService<T> _paginationService;

  GenericFirestorePagingController({
    required Query<Map<String, dynamic>> baseQuery,
    required T Function(Map<String, dynamic> json, String id) fromJson,
    required String Function(T) getId,
    int pageSize = 1,
    List<FirestoreFilter>? initialFilters,
    List<FirestoreOrderBy>? initialOrderBy,
  })  : pagingController = PagingController(firstPageKey: 0),
        _paginationService = FirestorePaginationService<T>(
          baseQuery: baseQuery,
          fromJson: fromJson,
          pageSize: pageSize,
          initialFilters: initialFilters,
          initialOrderBy: initialOrderBy,
        ) {
    pagingController.addPageRequestListener(_fetchPage);
  }

  // Delegate methods to pagination service
  bool get hasMore => _paginationService.hasMore;
  bool get isLoading => _paginationService.isLoading;

  void addFilter(FirestoreFilter filter) {
    _paginationService.addFilter(filter);
  }

  void clearFilters() {
    _paginationService.clearFilters();
  }

  void addOrderBy(FirestoreOrderBy orderBy) {
    _paginationService.addOrderBy(orderBy);
  }

  void clearOrderBy() {
    _paginationService.clearOrderBy();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<T> items;

      if (pageKey == 0) {
        items = await _paginationService.fetchFirstPage();
      } else {
        items = await _paginationService.fetchNextPage();
      }

      final isLastPage = !_paginationService.hasMore;
      if (isLastPage) {
        pagingController.appendLastPage(items);
      } else {
        pagingController.appendPage(items, pageKey + 1);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  void dispose() {
    pagingController.dispose();
  }
}
