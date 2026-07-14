import '../../domain/entities/dashboard_item.dart';

class DashboardItemModel extends DashboardItem {
  const DashboardItemModel({
    required super.id,
    required super.title,
    required super.value,
    required super.changePercentage,
    required super.iconName,
    required super.description,
    required super.isTrendingUp,
  });

  factory DashboardItemModel.fromJson(Map<String, dynamic> json) {
    return DashboardItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      value: json['value'] as String,
      changePercentage: (json['changePercentage'] as num).toDouble(),
      iconName: json['iconName'] as String,
      description: json['description'] as String,
      isTrendingUp: json['isTrendingUp'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'changePercentage': changePercentage,
      'iconName': iconName,
      'description': description,
      'isTrendingUp': isTrendingUp,
    };
  }
}
