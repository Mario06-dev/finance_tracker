/* 
    	Category Model
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/parent_category_model.dart';
import 'package:flutter/material.dart';

class Category {
  final String categoryId;
  final String title;
  final Color color;
  final IconData icon;
  final String parentCategoryTitle;

  const Category({
    required this.categoryId,
    required this.title,
    required this.color,
    required this.icon,
    required this.parentCategoryTitle,
  });

  // Converting everything we get form input to object file
  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'title': title,
        'color': color,
        'icon': icon,
        'parentCategoryTitle': parentCategoryTitle,
      };

  // Take DocumentSnapshot and return Category model
  static Category fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Category(
      categoryId: snapshot['categoryId'],
      title: snapshot['title'],
      color: snapshot['color'],
      icon: snapshot['icon'],
      parentCategoryTitle: snapshot['parentCategoryTitle'],
    );
  }
}
