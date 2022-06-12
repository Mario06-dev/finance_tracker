import 'package:finance_tracker/models/parent_category_model.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';

// All categories colors
const Color eatingColor = Colors.red;
const Color shoppingColor = Colors.blue;
const Color lifeAndEnterColor = Colors.green;
const Color vehicleColor = Colors.deepPurple;
const Color transportationColor = Colors.purple;

// List of all parent categories
/* List<ParentCategory> parentCategories = [
  const ParentCategory(title: 'Eating', color: Colors.red),
  const ParentCategory(title: 'Shopping', color: Colors.blue),
  const ParentCategory(title: 'Lige & Entertainment', color: Colors.green),
  const ParentCategory(title: 'Vehicle', color: Colors.deepPurple),
  const ParentCategory(title: 'Transportation', color: Colors.purple),
]; */

// List of all categories
List<Category> categories = [
  // ==================== EATING ====================
  const Category(
    categoryId: '',
    title: 'Restaurant Dining',
    color: eatingColor,
    icon: Icons.restaurant,
    parentCategoryTitle: 'Eating',
  ),
  const Category(
    categoryId: '',
    title: 'Delivery',
    color: eatingColor,
    icon: Icons.delivery_dining,
    parentCategoryTitle: 'Eating',
  ),
  const Category(
    categoryId: '',
    title: 'Bakery',
    color: eatingColor,
    icon: Icons.bakery_dining,
    parentCategoryTitle: 'Eating',
  ),

  // ==================== SHOPPING ====================
  const Category(
    categoryId: '',
    title: 'Market & Store',
    color: shoppingColor,
    icon: Icons.shopping_bag,
    parentCategoryTitle: 'Shopping',
  ),
  const Category(
    categoryId: '',
    title: 'Clothes & Shoes',
    color: shoppingColor,
    icon: Icons.checkroom,
    parentCategoryTitle: 'Shopping',
  ),
  const Category(
    categoryId: '',
    title: 'Health & Beauty',
    color: shoppingColor,
    icon: Icons.spa,
    parentCategoryTitle: 'Shopping',
  ),
  const Category(
    categoryId: '',
    title: 'Home',
    color: shoppingColor,
    icon: Icons.house,
    parentCategoryTitle: 'Shopping',
  ),
  const Category(
    categoryId: '',
    title: 'Electronics & Accessories',
    color: shoppingColor,
    icon: Icons.cable,
    parentCategoryTitle: 'Shopping',
  ),
  const Category(
    categoryId: '',
    title: 'Gifts',
    color: shoppingColor,
    icon: Icons.redeem,
    parentCategoryTitle: 'Shopping',
  ),

  // ==================== VEHICLE ====================
  const Category(
    categoryId: '',
    title: 'Gas',
    color: vehicleColor,
    icon: Icons.gas_meter,
    parentCategoryTitle: 'Vehicle',
  ),
];
