import 'package:flutter/material.dart';
import 'package:bazaar/core/models/category_model.dart';
import 'package:bazaar/core/utils/constants.dart';
import 'package:bazaar/theme/app_colors.dart';

class CategoryBar extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel) onCategoryTap;

  const CategoryBar({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Theme.of(context).cardColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.smallPadding),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => onCategoryTap(category),
            child: Container(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconData(category.icon),
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'phone':
        return Icons.phone_android;
      case 'fashion':
        return Icons.checkroom;
      case 'electronics':
        return Icons.laptop;
      case 'home':
        return Icons.weekend;
      case 'appliances':
        return Icons.kitchen;
      case 'flight':
        return Icons.flight;
      case 'beauty':
        return Icons.face;
      case 'grocery':
        return Icons.shopping_basket;
      case 'toys':
        return Icons.toys;
      case 'sports':
        return Icons.sports_soccer;
      default:
        return Icons.category;
    }
  }
}
