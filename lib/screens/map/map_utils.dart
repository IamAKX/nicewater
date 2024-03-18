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
