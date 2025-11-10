import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/product_model.dart';
import 'package:bazaar/features/home/data/product_repository.dart';

final productRepositoryProvider = Provider<IProductRepository>((ref) => LocalProductRepository());

final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});

final productByIdProvider = FutureProvider.family<ProductModel?, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(id);
});

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() => SearchQueryNotifier());

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
}

final searchResultsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return ref.watch(productsProvider.future);
  }
  final repository = ref.watch(productRepositoryProvider);
  return repository.searchProducts(query);
});
