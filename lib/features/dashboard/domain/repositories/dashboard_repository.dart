import '../entities/dashboard_item.dart';

abstract class DashboardRepository {
  Future<List<DashboardItem>> getDashboardItems();
}
