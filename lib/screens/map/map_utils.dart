import 'package:flutter/material.dart';
import 'package:nice_water/models/map_filter_model.dart';

List<MapFilterModel> getMapFilters() {
  return [
    MapFilterModel(
        name: 'All Waste',
        id: 0,
        type: 'all',
        iconData: Icons.category_outlined,
        selectedIconData: Icons.category),
    MapFilterModel(
        name: 'Trash',
        id: 1,
        type: 'trash',
        iconData: Icons.delete_outline,
        selectedIconData: Icons.delete),
    MapFilterModel(
        name: 'Sewage',
        id: 2,
        type: 'sewage',
        iconData: Icons.fire_hydrant_alt_outlined,
        selectedIconData: Icons.fire_hydrant_alt),
    MapFilterModel(
        name: 'Construction Waste',
        id: 3,
        type: 'construction',
        iconData: Icons.home_work_outlined,
        selectedIconData: Icons.home_work),
    MapFilterModel(
        name: 'Hazardous Waste',
        id: 4,
        type: 'hazardous',
        iconData: Icons.pest_control_outlined,
        selectedIconData: Icons.pest_control),
    MapFilterModel(
        name: 'Organic Waste',
        id: 5,
        type: 'organic',
        iconData: Icons.recycling_outlined,
        selectedIconData: Icons.recycling),
  ];
}

IconData getPointerIconDateByType(String type) {
  return getMapFilters()
      .firstWhere((element) => element.type == type)
      .iconData!;
}

String getFilterNameByType(String type) {
  return getMapFilters().firstWhere((element) => element.type == type).name!;
}

Widget getPointerIconByType(String type) {
  switch (type) {
    case 'trash':
      return const Icon(Icons.delete_outline);
    case 'sewage':
      return const Icon(Icons.fire_hydrant_alt_outlined);
    case 'construction':
      return const Icon(Icons.home_work_outlined);
    case 'hazardous':
      return const Icon(Icons.pest_control_outlined);
    case 'organic':
      return const Icon(Icons.recycling_outlined);
    default:
      return const Icon(Icons.location_on_outlined);
  }
}
