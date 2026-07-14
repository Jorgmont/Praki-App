import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository repository;

  DashboardCubit(this.repository) : super(const DashboardInitial());

  Future<void> loadDashboard() async {
    emit(const DashboardLoading());
    try {
      final items = await repository.getDashboardItems();
      emit(DashboardLoaded(items));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
