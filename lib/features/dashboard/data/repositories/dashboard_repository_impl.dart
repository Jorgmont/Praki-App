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
        title: 'Usuarios Activos',
        value: '12,482',
        changePercentage: 12.5,
        iconName: 'people',
        description: 'Usuarios interactuando en tiempo real',
        isTrendingUp: true,
      ),
      DashboardItemModel(
        id: '2',
        title: 'Ingresos Mensuales',
        value: '\$45,820.50',
        changePercentage: 8.2,
        iconName: 'monetization_on',
        description: 'Ventas brutas registradas este mes',
        isTrendingUp: true,
      ),
      DashboardItemModel(
        id: '3',
        title: 'Tasa de Conversión',
        value: '3.42%',
        changePercentage: -1.5,
        iconName: 'trending_up',
        description: 'Porcentaje de visitas que completan compra',
        isTrendingUp: false,
      ),
      DashboardItemModel(
        id: '4',
        title: 'Rendimiento Servidor',
        value: '99.98%',
        changePercentage: 0.02,
        iconName: 'dns',
        description: 'Porcentaje de uptime de la infraestructura',
        isTrendingUp: true,
      ),
    ];
  }
}
