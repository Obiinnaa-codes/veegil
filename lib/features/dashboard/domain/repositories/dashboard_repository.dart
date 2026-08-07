import '../entities/account.dart';

abstract class DashboardRepository {
  Future<Account> getCurrentUser();

  Future<Account> refresh();
}
