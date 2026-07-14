import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../../domain/entities/dashboard_item.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';


class DashboardPage extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool isDarkMode;

  const DashboardPage({
    super.key,
    this.onToggleTheme,
    this.isDarkMode = true,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Load dashboard metrics on startup
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Praki'),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.amber : theme.colorScheme.primary,
            ),
            onPressed: widget.onToggleTheme,
            tooltip: 'Cambiar Tema',
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            tooltip: 'Cerrar Sesión',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<DashboardCubit>().loadDashboard(),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return _buildLoadingSkeleton();
            } else if (state is DashboardLoaded) {
              return _buildDashboardContent(state.items);
            } else if (state is DashboardError) {
              return _buildErrorView(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDashboardContent(List<DashboardItem> items) {
    final mediaQuery = MediaQuery.of(context);
    final crossAxisCount = mediaQuery.size.width > 600 ? 2 : 1;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting / Header section
          Text(
            '¡Hola, Ezequiel!',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aquí tienes el resumen de tu bienestar y salud mental hoy.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Responsive Metrics Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 170,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildMetricCard(items[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(DashboardItem item) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconData(item.iconName),
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                // Trend Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: item.isTrendingUp
                        ? Colors.green.withValues(alpha: isDark ? 0.2 : 0.1)
                        : Colors.red.withValues(alpha: isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.isTrendingUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        color: item.isTrendingUp ? Colors.green : Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${item.changePercentage.abs()}%',
                        style: TextStyle(
                          color: item.isTrendingUp ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Shimmer
          _buildShimmerContainer(width: 180, height: 32),
          const SizedBox(height: 8),
          _buildShimmerContainer(width: double.infinity, height: 16),
          const SizedBox(height: 32),
          // Grid Cards Shimmer
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => _buildShimmerCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShimmerContainer(width: 40, height: 40, borderRadius: 12),
              _buildShimmerContainer(width: 70, height: 24, borderRadius: 100),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerContainer(width: 100, height: 14),
              const SizedBox(height: 8),
              _buildShimmerContainer(width: 150, height: 24),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildShimmerContainer({
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '¡Ups! Ocurrió un problema',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.read<DashboardCubit>().loadDashboard(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'mood':
        return Icons.sentiment_satisfied_alt_rounded;
      case 'sleep':
        return Icons.bedtime_rounded;
      case 'anxiety':
        return Icons.psychology_rounded;
      case 'meditation':
        return Icons.spa_rounded;
      default:
        return Icons.self_improvement_rounded;
    }
  }
}
