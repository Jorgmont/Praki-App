class DashboardItem {
  final String id;
  final String title;
  final String value;
  final double changePercentage;
  final String iconName;
  final String description;
  final bool isTrendingUp;

  const DashboardItem({
    required this.id,
    required this.title,
    required this.value,
    required this.changePercentage,
    required this.iconName,
    required this.description,
    required this.isTrendingUp,
  });
}
