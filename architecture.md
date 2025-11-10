# Flipkart Clone - Architecture Document

## Overview
A modern e-commerce Flutter app following Clean Architecture + MVVM pattern with Riverpod state management, Material 3 design, and Firebase-ready architecture.

## Tech Stack
- **Architecture**: Clean Architecture / MVVM
- **State Management**: Riverpod (flutter_riverpod v2+)
- **Navigation**: go_router (declarative routing)
- **Theming**: Material 3 + Flipkart-inspired color palette
- **Data Layer**: Repository pattern (mock first, Firebase-ready)
- **UI**: Declarative widgets + reusable components

## Core Features

### 1. Home Screen (Flipkart-Style)
- **Blue App Bar** with integrated search bar and Flipkart branding
- **Category Icons Bar** - Horizontal scrollable categories (Mobiles, Fashion, Electronics, etc.)
- **Banner Carousel** - Auto-scrolling promotional banners with discount badges
- **Product Sections** - Multiple horizontal scrollable sections with titles
- **Dropdown Menu** - Login/Profile menu with Orders, Wishlist, Logout options
- **Cart Badge** - Shows item count in shopping cart icon

### 2. Shopping Cart
- List view with product images, quantity controls (+/-)
- **Price Details Panel** (sidebar on desktop, bottom on mobile)
- Price breakdown: Original price, Discount, Platform fee, Total amount
- Savings highlight in green container
- "Remove" button for each item
- Responsive layout adapts to screen size
- "Place Order" button for checkout

### 3. Wishlist Management
- In-memory wishlist via LocalWishlistRepository
- Real-time updates via StreamProvider
- Empty state with custom icon illustration
- Add/remove products with snackbar feedback
- Product cards with direct navigation to details

### 4. Product Detail
- Hero animation from product card
- Image carousel (carousel_slider) with page indicators
- Price breakdown with discount percentage badge
- Rating display with review count
- Add-to-Cart (adds to cart) and Buy-Now (adds to cart + redirects)
- Wishlist toggle in app bar
- Product info cards (Free Delivery, 7 Days Return, Warranty)

### 5. Authentication (Firebase-Ready)
- Mock login UI with Google Sign-In placeholder
- User profile display in dropdown menu
- AuthRepository interface for future Firebase integration
- Riverpod authProvider with mock user

## Project Structure

```
lib/
  core/
    models/
      product_model.dart
      user_model.dart
    utils/
      constants.dart
      extensions.dart
  features/
    auth/
      data/
        auth_repository.dart
      presentation/
        auth_provider.dart
        login_screen.dart
    home/
      data/
        product_repository.dart
      presentation/
        home_screen.dart
        providers/
          product_provider.dart
          theme_provider.dart
        widgets/
          home_product_card.dart
          shimmer_product_grid.dart
    product/
      presentation/
        product_detail_screen.dart
    wishlist/
      data/
        wishlist_repository.dart
      presentation/
        wishlist_provider.dart
        wishlist_screen.dart
        widgets/
          wishlist_product_card.dart
  routes/
    app_router.dart
  theme/
    app_colors.dart
    app_theme.dart
  main.dart
  theme.dart (existing)
```

## Data Models

### ProductModel
```dart
- id: String
- title: String
- description: String
- price: double
- originalPrice: double
- discount: int
- rating: double
- reviewCount: int
- imageUrls: List<String>
- category: String
- createdAt: DateTime
- updatedAt: DateTime
```

### UserModel (Firebase-ready)
```dart
- id: String
- email: String
- displayName: String
- photoUrl: String?
- createdAt: DateTime
```

## Repository Pattern

### IWishlistRepository (Interface)
- `Stream<List<String>> watchWishlist()`
- `Future<void> addToWishlist(String productId)`
- `Future<void> removeFromWishlist(String productId)`

### LocalWishlistRepository (Mock Implementation)
- In-memory Set<String> storage
- StreamController for real-time updates
- Ready for Firestore migration

### IProductRepository (Interface)
- `Future<List<ProductModel>> getProducts()`
- `Future<ProductModel?> getProductById(String id)`
- `Future<List<ProductModel>> searchProducts(String query)`

### LocalProductRepository (Mock Implementation)
- Static list of mock products with realistic data
- Ready for Firestore/API integration

### IAuthRepository (Interface)
- `Stream<UserModel?> authStateChanges()`
- `Future<UserModel?> signInWithGoogle()`
- `Future<void> signOut()`

### MockAuthRepository (Mock Implementation)
- Simulated login/logout
- Ready for Firebase Auth integration

## Riverpod Providers

### Core Providers
- `wishlistRepositoryProvider` → provides IWishlistRepository
- `wishlistProvider` → StreamProvider<List<String>>
- `productRepositoryProvider` → provides IProductRepository
- `productsProvider` → FutureProvider<List<ProductModel>>
- `authRepositoryProvider` → provides IAuthRepository
- `authProvider` → StreamProvider<UserModel?>
- `isDarkModeProvider` → StateProvider<bool>

## Navigation Routes (go_router)
- `/` → HomeScreen
- `/product/:id` → ProductDetailScreen
- `/wishlist` → WishlistScreen
- `/login` → LoginScreen

## Theme & Design

### Color Palette (Flipkart-Inspired)
- Primary: #2874F0 (Flipkart Blue)
- Secondary: #FF9F00 (Accent Orange)
- Background: #F1F3F6 (Light Grey)
- Surface: #FFFFFF
- Text Primary: #212121
- Text Secondary: #878787

### Typography
- Font: Google Fonts (Inter)
- Clear hierarchy with display, headline, title, body, label styles

### UI Components
- Modern card design with rounded corners
- Minimal shadows/elevation
- Hero animations for transitions
- Shimmer loading placeholders
- Lottie animations for empty states
- Snackbar feedback for actions

## Implementation Steps

1. **Setup Dependencies**
   - Add flutter_riverpod, go_router, cached_network_image, intl, flutter_rating_bar, carousel_slider, lottie, shimmer

2. **Create Core Infrastructure**
   - Data models (Product, User)
   - Constants and extensions
   - Repository interfaces
   - Theme configuration

3. **Implement Data Layer**
   - Mock repositories with realistic data
   - Riverpod providers

4. **Build UI Components**
   - Reusable widgets (ProductCard, etc.)
   - Feature screens (Home, Product Detail, Wishlist, Login)
   - Navigation setup with go_router

5. **Add Animations & Polish**
   - Hero animations
   - Shimmer loading
   - Lottie empty states
   - Smooth transitions

6. **Testing & Validation**
   - Run compile_project to check for errors
   - Verify responsive layouts
   - Test dark mode toggle
   - Validate navigation flows

## Firebase Migration Path
When ready to integrate Firebase:
1. Replace LocalWishlistRepository with FirestoreWishlistRepository
2. Replace MockAuthRepository with FirebaseAuthRepository
3. Replace LocalProductRepository with FirestoreProductRepository
4. Update providers to use Firebase implementations
5. Add Firestore security rules
6. Configure Firebase project in FlutterFire CLI

## Notes
- All code follows Clean Architecture principles
- Strict separation of concerns (data, domain, presentation)
- Highly modular and testable
- Ready for production with minimal changes
