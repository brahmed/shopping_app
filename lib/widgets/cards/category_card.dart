import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    this.onTap,
  }) : super(key: key);

  IconData _getIconFromName(String iconName) {
    switch (iconName) {
      case 'phone_iphone':
        return Icons.phone_iphone;
      case 'checkroom':
        return Icons.checkroom;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'watch':
        return Icons.watch;
      case 'sports_basketball':
        return Icons.sports_basketball;
      case 'home':
        return Icons.home;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${category.name} category',
      hint: 'Double tap to filter products by ${category.name}',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(right: 12),
          child: MergeSemantics(
            child: Column(
              children: [
                ExcludeSemantics(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      _getIconFromName(category.iconName ?? 'category'),
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ExcludeSemantics(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
