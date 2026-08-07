import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/transaction_filter.dart';
import '../providers/core_providers.dart';
import 'transactions_state.dart';

const _pageSize = 20;

final transactionsControllerProvider =
    AsyncNotifierProvider<TransactionsController, TransactionsState>(
  TransactionsController.new,
);

class TransactionsController extends AsyncNotifier<TransactionsState> {
  @override
  Future<TransactionsState> build() async {
    final repository = ref.read(transactionRepositoryProvider);
    try {
      final page = await repository.getTransactions(
        limit: _pageSize,
        offset: 0,
      );
      return TransactionsState(
        transactions: page.items,
        meta: page.meta,
      );
    } on Object catch (error) {
      if (_isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
      }
      rethrow;
    }
  }

  Future<void> refresh() async {
    final previous = state.valueOrNull;
    try {
      final repository = ref.read(transactionRepositoryProvider);
      final page = await repository.getTransactions(
        limit: _pageSize,
        offset: 0,
      );
      state = AsyncData(
        TransactionsState(
          transactions: page.items,
          meta: page.meta,
          activeFilter: previous?.activeFilter ?? TransactionFilter.all,
          searchQuery: previous?.searchQuery ?? '',
        ),
      );
    } catch (error, stackTrace) {
      if (_isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
        return;
      }

      if (previous != null) {
        state = AsyncData(previous);
      } else {
        state = AsyncError(error, stackTrace);
      }
    }
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null ||
        current.isLoadingMore ||
        current.meta?.hasMore != true) {
      return;
    }

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final repository = ref.read(transactionRepositoryProvider);
      final nextOffset = current.transactions.length;
      final page = await repository.getTransactions(
        limit: _pageSize,
        offset: nextOffset,
      );

      final updated = current.copyWith(
        transactions: [...current.transactions, ...page.items],
        meta: page.meta,
        isLoadingMore: false,
      );
      state = AsyncData(updated);
    } catch (error) {
      if (_isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
        return;
      }

      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  void setFilter(TransactionFilter filter) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(activeFilter: filter));
  }

  void setSearchQuery(String query) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(searchQuery: query));
  }

  bool _isUnauthorized(Object error) {
    if (error is DioException) {
      return error.response?.statusCode == 401 ||
          error.apiException.statusCode == 401;
    }
    if (error is ApiException) {
      return error.statusCode == 401;
    }
    return false;
  }
}
