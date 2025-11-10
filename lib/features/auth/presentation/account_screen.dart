import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bazaar/features/auth/presentation/auth_provider.dart';
import 'package:bazaar/theme/app_colors.dart'; // Assuming AppColors is defined here
import 'package:bazaar/core/utils/constants.dart'; // Assuming AppConstants is defined here

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: currentUser == null
          ? const Center(
              child: Text('Please log in to view your account.'),
            )
          : ListView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              children: [
                // User Profile Header
                Container(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.person,
                            size: 30, color: AppColors.primary),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser.displayName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            currentUser.email,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.defaultPadding),

                // Account Settings Section
                _buildSection(
                  context,
                  title: 'Account Settings',
                  children: [
                    _buildAccountOption(
                      context,
                      icon: Icons.location_on,
                      title: 'Manage Addresses',
                      onTap: () => context.go('/account/addresses'),
                    ),
                    _buildAccountOption(
                      context,
                      icon: Icons.payment,
                      title: 'Payment Methods',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Payment Methods coming soon')),
                        );
                      },
                    ),
                    _buildAccountOption(
                      context,
                      icon: Icons.settings,
                      title: 'App Settings',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('App Settings coming soon')),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.defaultPadding),

                // My Activity Section
                _buildSection(
                  context,
                  title: 'My Activity',
                  children: [
                    _buildAccountOption(
                      context,
                      icon: Icons.shopping_bag,
                      title: 'My Orders',
                      onTap: () => context.push('/order_history'),
                    ),
                    _buildAccountOption(
                      context,
                      icon: Icons.favorite,
                      title: 'My Wishlist',
                      onTap: () => context.push('/wishlist'),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.defaultPadding),

                // Support & Legal Section
                _buildSection(
                  context,
                  title: 'Support & Legal',
                  children: [
                    _buildAccountOption(
                      context,
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Help Center coming soon')),
                        );
                      },
                    ),
                    _buildAccountOption(
                      context,
                      icon: Icons.info_outline,
                      title: 'Legal',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Legal information coming soon')),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.defaultPadding),

                // Sign Out Button
                ElevatedButton.icon(
                  onPressed: () async {
                    await ref.read(authRepositoryProvider).signOut();
                    if (context.mounted) {
                      context.go('/login'); // Redirect to login after sign out
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.defaultRadius),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Divider(height: AppConstants.defaultPadding * 2),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAccountOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}
