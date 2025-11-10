import 'package:flutter/material.dart';
import 'package:bazaar/core/utils/constants.dart';
import 'package:bazaar/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      color: AppColors.surface, // Assuming a suitable background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bazaar',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20.0, // Horizontal space between sections
            runSpacing: 10.0, // Vertical space between wrapped lines
            children: [
              _buildFooterSection(
                context,
                'About Us',
                ['Our Story', 'Careers', 'Press'],
              ),
              _buildFooterSection(
                context,
                'Help',
                ['Payments', 'Shipping', 'Cancellation & Returns', 'FAQ'],
              ),
              _buildFooterSection(
                context,
                'Policy',
                ['Return Policy', 'Terms Of Use', 'Security', 'Privacy', 'Sitemap'],
              ),
              _buildFooterSection(
                context,
                'Social',
                ['Facebook', 'Twitter', 'YouTube'], // Placeholder for social media
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registered Office Address',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bazaar Private Limited,\nBuildings Alyssa, Begonia & Clove Embassy Tech Village,\nOuter Ring Road, Devarabeesanahalli Village,\nBengaluru, 560103,\nKarnataka, India',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mail Us',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: support@bazaar.com\nPhone: 1800-123-4567',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 32, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Methods',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Placeholder for payment method icons
                    Row(
                      children: [
                        Icon(Icons.payment, color: AppColors.textSecondary),
                        SizedBox(width: 8),
                        Icon(Icons.credit_card, color: AppColors.textSecondary),
                        SizedBox(width: 8),
                        Icon(Icons.paypal, color: AppColors.textSecondary),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Social',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Placeholder for social media icons
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.facebook, color: AppColors.textSecondary),
                        SizedBox(width: 8),
                        Icon(FontAwesomeIcons.twitter, color: AppColors.textSecondary),
                        SizedBox(width: 8),
                        Icon(FontAwesomeIcons.youtube, color: AppColors.textSecondary),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32, thickness: 1),
          Text(
            '© 2025 Bazaar. All Rights Reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(BuildContext context, String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: GestureDetector(
                onTap: () {
                  // Handle tap for footer item
                  print('Tapped on $item');
                },
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
