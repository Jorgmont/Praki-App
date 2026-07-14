import 'package:flutter/foundation.dart';
import '../../domain/entities/dashboard_item.dart';

@immutable
abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final List<DashboardItem> items;
  const DashboardLoaded(this.items);
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);
}
