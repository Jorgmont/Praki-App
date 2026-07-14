import 'package:get_it/get_it.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Dashboard

  // Cubits (Factory registration so a new instance is created when requested)
  sl.registerFactory(() => DashboardCubit(sl()));

  // Repositories (Lazy singletons so they are instantiated only when needed)
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(),
  );
}
