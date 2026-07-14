import '../../domain/entities/dashboard_item.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/dashboard_item_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<List<DashboardItem>> getDashboardItems() async {
    // Simulate a short network delay for modern loading animations
    await Future.delayed(const Duration(seconds: 2));

    return const [
      DashboardItemModel(
        id: '1',
        title: 'Estado de Ánimo',
        value: 'Estable (8/10)',
        changePercentage: 5.0,
        iconName: 'mood',
        description: 'Tu balance emocional promedio esta semana',
        isTrendingUp: true,
      ),
      DashboardItemModel(
        id: '2',
        title: 'Registro de Sueño',
        value: '7.5 horas',
        changePercentage: 8.3,
        iconName: 'sleep',
        description: 'Duración promedio de sueño por noche',
        isTrendingUp: true,
      ),
      DashboardItemModel(
        id: '3',
        title: 'Nivel de Ansiedad',
        value: 'Bajo (2/10)',
        changePercentage: -12.5,
        iconName: 'anxiety',
        description: 'Nivel reportado de estrés y ansiedad',
        isTrendingUp: false,
      ),
      DashboardItemModel(
        id: '4',
        title: 'Minutos de Mindfulness',
        value: '45 min',
        changePercentage: 25.0,
        iconName: 'meditation',
        description: 'Tiempo dedicado a meditar esta semana',
        isTrendingUp: true,
      ),
    ];
  }
}
