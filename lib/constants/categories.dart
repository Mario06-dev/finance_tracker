import 'package:flutter/material.dart';
import '../models/category_model.dart';

// All categories colors
const Color eatingColor = Colors.red;
const Color shoppingColor = Colors.blue;
const Color lifeAndEnterColor = Colors.indigoAccent;
const Color vehicleColor = Colors.deepPurple;
const Color transportationColor = Colors.purple;
const Color housingColor = Colors.orange;
const Color financialExpensesColor = Colors.brown;
const Color drinksColor = Colors.teal;
const Color incomeColor = Colors.green;

List<Color> catColors = [
  Colors.red, // Color of Eating Out categories
  Colors.blue, // Color of Shopping categories
  Colors.indigoAccent, // Color of Life & Entertainment categories
  Colors.deepPurple, // Color of Vehicle categories
  Colors.purple, // Color of Transportation categories
  Colors.orange, // Color of Housing categories
  Colors.teal, // Color of Bar&Cafe categories
  Colors.brown, // Color of Financial expenses categories
  Colors.green, // Color of income categories
];

Map<String, Color> parentCatsAndColors = {
  'Eating': eatingColor,
  'Shopping': shoppingColor,
  'Life & Entertainment': lifeAndEnterColor,
  'Vehicle': vehicleColor,
  'Transportation': transportationColor,
  'Housing': housingColor,
  'Bar & Cafe': drinksColor,
  'Financial Expenses': financialExpensesColor,
  'Income': incomeColor,
};

List<String> parentCategories = [
  'Eating',
  'Shopping',
  'Life & Entertainment',
  'Vehicle',
  'Transportation',
  'Housing',
  'Bar & Cafe',
  'Financial Expenses',
  'Income'
];

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
    title: 'Software',
    color: shoppingColor,
    icon: Icons.wysiwyg,
    parentCategoryTitle: 'Shopping',
  ),
  const Category(
    categoryId: '',
    title: 'Gifts',
    color: shoppingColor,
    icon: Icons.redeem,
    parentCategoryTitle: 'Shopping',
  ),

  // ==================== LIFE & ENTERTAINEMNT ====================
  const Category(
    categoryId: '',
    title: 'Health Care',
    color: lifeAndEnterColor,
    icon: Icons.health_and_safety,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Subscription Services',
    color: lifeAndEnterColor,
    icon: Icons.subscriptions,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Active sport & Fitness',
    color: lifeAndEnterColor,
    icon: Icons.fitness_center,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Haircut',
    color: lifeAndEnterColor,
    icon: Icons.cut,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Events',
    color: lifeAndEnterColor,
    icon: Icons.event,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Education',
    color: lifeAndEnterColor,
    icon: Icons.school,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Holiday Trips & Stays',
    color: lifeAndEnterColor,
    icon: Icons.luggage,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Charity',
    color: lifeAndEnterColor,
    icon: Icons.escalator_warning,
    parentCategoryTitle: 'Life & Entertainment',
  ),
  const Category(
    categoryId: '',
    title: 'Lottery & Gambling',
    color: lifeAndEnterColor,
    icon: Icons.casino,
    parentCategoryTitle: 'Life & Entertainment',
  ),

  // ==================== VEHICLE ====================
  const Category(
    categoryId: '',
    title: 'Gas',
    color: vehicleColor,
    icon: Icons.gas_meter,
    parentCategoryTitle: 'Vehicle',
  ),
  const Category(
    categoryId: '',
    title: 'Parking',
    color: vehicleColor,
    icon: Icons.local_parking,
    parentCategoryTitle: 'Vehicle',
  ),
  const Category(
    categoryId: '',
    title: 'Registration & Ensurance',
    color: vehicleColor,
    icon: Icons.article,
    parentCategoryTitle: 'Vehicle',
  ),
  const Category(
    categoryId: '',
    title: 'Maintenance & Services',
    color: vehicleColor,
    icon: Icons.car_repair,
    parentCategoryTitle: 'Vehicle',
  ),

  // ==================== TRANSPORTATION ====================
  const Category(
    categoryId: '',
    title: 'Taxi',
    color: transportationColor,
    icon: Icons.local_taxi,
    parentCategoryTitle: 'Transportation',
  ),
  const Category(
    categoryId: '',
    title: 'Public Transport',
    color: transportationColor,
    icon: Icons.tram,
    parentCategoryTitle: 'Transportation',
  ),
  const Category(
    categoryId: '',
    title: 'Log trips',
    color: transportationColor,
    icon: Icons.flight,
    parentCategoryTitle: 'Transportation',
  ),
  const Category(
    categoryId: '',
    title: 'Road Tolls',
    color: transportationColor,
    icon: Icons.edit_road,
    parentCategoryTitle: 'Transportation',
  ),

  // ==================== HOUSING ====================
  const Category(
    categoryId: '',
    title: 'Rent',
    color: housingColor,
    icon: Icons.real_estate_agent,
    parentCategoryTitle: 'Housing',
  ),
  const Category(
    categoryId: '',
    title: 'Utility Bills',
    color: housingColor,
    icon: Icons.payments,
    parentCategoryTitle: 'Housing',
  ),
  const Category(
    categoryId: '',
    title: 'Maintenance',
    color: housingColor,
    icon: Icons.build,
    parentCategoryTitle: 'Housing',
  ),

  // ==================== DRINKS ====================
  const Category(
    categoryId: '',
    title: 'Caffe Bar',
    color: drinksColor,
    icon: Icons.coffee,
    parentCategoryTitle: 'Drinks',
  ),
  const Category(
    categoryId: '',
    title: 'Club',
    color: drinksColor,
    icon: Icons.local_bar,
    parentCategoryTitle: 'Drinks',
  ),

  // ==================== FINANCIAL EXPENSES ====================
  const Category(
    categoryId: '',
    title: 'Taxes',
    color: financialExpensesColor,
    icon: Icons.local_atm,
    parentCategoryTitle: 'Financial Expenses',
  ),
  const Category(
    categoryId: '',
    title: 'Fines',
    color: financialExpensesColor,
    icon: Icons.card_membership,
    parentCategoryTitle: 'Financial Expenses',
  ),
  const Category(
    categoryId: '',
    title: 'Bank Fees',
    color: financialExpensesColor,
    icon: Icons.account_balance,
    parentCategoryTitle: 'Financial Expenses',
  ),

  // ==================== INCOME ====================
  const Category(
    categoryId: '',
    title: 'Paycheck',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
  const Category(
    categoryId: '',
    title: 'Tips',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
  const Category(
    categoryId: '',
    title: 'Rental Income',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
  const Category(
    categoryId: '',
    title: 'Income Gifts',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
  const Category(
    categoryId: '',
    title: 'Intrests & Dividends',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
  const Category(
    categoryId: '',
    title: 'Sales',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
  const Category(
    categoryId: '',
    title: 'Pension',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
  const Category(
    categoryId: '',
    title: 'Other income',
    color: incomeColor,
    icon: Icons.price_check,
    parentCategoryTitle: 'Income',
  ),
];
