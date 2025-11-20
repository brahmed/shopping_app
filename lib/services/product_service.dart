import '../models/product_model.dart';
import '../models/category_model.dart';

/// Mock Product Service
/// In a real app, this would make API calls to a backend server
class ProductService {
  // Simulate network delay
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<Category>> getCategories() async {
    await _simulateNetworkDelay();

    return [
      Category(
        id: 'electronics',
        name: 'Electronics',
        iconName: 'phone_iphone',
        imageUrl: 'https://picsum.photos/200/200?electronics',
      ),
      Category(
        id: 'clothing',
        name: 'Clothing',
        iconName: 'checkroom',
        imageUrl: 'https://picsum.photos/200/200?clothing',
      ),
      Category(
        id: 'shoes',
        name: 'Shoes',
        iconName: 'shopping_bag',
        imageUrl: 'https://picsum.photos/200/200?shoes',
      ),
      Category(
        id: 'accessories',
        name: 'Accessories',
        iconName: 'watch',
        imageUrl: 'https://picsum.photos/200/200?accessories',
      ),
      Category(
        id: 'sports',
        name: 'Sports',
        iconName: 'sports_basketball',
        imageUrl: 'https://picsum.photos/200/200?sports',
      ),
      Category(
        id: 'home',
        name: 'Home & Garden',
        iconName: 'home',
        imageUrl: 'https://picsum.photos/200/200?home',
      ),
    ];
  }

  Future<List<Product>> getProducts() async {
    await _simulateNetworkDelay();

    return [
      // Electronics
      Product(
        id: '1',
        name: 'Wireless Headphones',
        description:
            'Premium wireless headphones with active noise cancellation, 30-hour battery life, and superior sound quality. Perfect for music lovers and commuters.',
        price: 199.99,
        originalPrice: 249.99,
        imageUrl: 'https://picsum.photos/400/400?headphones',
        images: [
          'https://picsum.photos/400/400?headphones',
          'https://picsum.photos/400/400?headphones2',
          'https://picsum.photos/400/400?headphones3',
        ],
        category: 'electronics',
        rating: 4.5,
        reviewCount: 328,
        brand: 'TechSound',
        colors: ['Black', 'Silver', 'Blue'],
      ),
      Product(
        id: '2',
        name: 'Smart Watch Pro',
        description:
            'Advanced smartwatch with fitness tracking, heart rate monitor, GPS, and 7-day battery life. Stay connected and healthy.',
        price: 299.99,
        originalPrice: 399.99,
        imageUrl: 'https://picsum.photos/400/400?smartwatch',
        images: [
          'https://picsum.photos/400/400?smartwatch',
          'https://picsum.photos/400/400?smartwatch2',
        ],
        category: 'electronics',
        rating: 4.8,
        reviewCount: 512,
        brand: 'FitTech',
        colors: ['Black', 'Rose Gold', 'Space Gray'],
      ),
      Product(
        id: '3',
        name: 'Wireless Mouse',
        description:
            'Ergonomic wireless mouse with precision tracking and long battery life. Comfortable for extended use.',
        price: 29.99,
        imageUrl: 'https://picsum.photos/400/400?mouse',
        images: ['https://picsum.photos/400/400?mouse'],
        category: 'electronics',
        rating: 4.3,
        reviewCount: 156,
        brand: 'TechGear',
        colors: ['Black', 'White'],
      ),

      // Clothing
      Product(
        id: '4',
        name: 'Cotton T-Shirt',
        description:
            '100% premium cotton t-shirt with comfortable fit. Perfect for casual wear and everyday style.',
        price: 24.99,
        originalPrice: 34.99,
        imageUrl: 'https://picsum.photos/400/400?tshirt',
        images: [
          'https://picsum.photos/400/400?tshirt',
          'https://picsum.photos/400/400?tshirt2',
        ],
        category: 'clothing',
        rating: 4.6,
        reviewCount: 234,
        brand: 'StyleCo',
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Black', 'Navy', 'Gray'],
      ),
      Product(
        id: '5',
        name: 'Denim Jeans',
        description:
            'Classic denim jeans with modern fit. Durable fabric and timeless style for any occasion.',
        price: 59.99,
        originalPrice: 89.99,
        imageUrl: 'https://picsum.photos/400/400?jeans',
        images: [
          'https://picsum.photos/400/400?jeans',
          'https://picsum.photos/400/400?jeans2',
        ],
        category: 'clothing',
        rating: 4.4,
        reviewCount: 187,
        brand: 'DenimPro',
        sizes: ['28', '30', '32', '34', '36'],
        colors: ['Blue', 'Black', 'Light Blue'],
      ),
      Product(
        id: '6',
        name: 'Hooded Jacket',
        description:
            'Warm and stylish hooded jacket perfect for cold weather. Water-resistant and windproof.',
        price: 89.99,
        imageUrl: 'https://picsum.photos/400/400?jacket',
        images: ['https://picsum.photos/400/400?jacket'],
        category: 'clothing',
        rating: 4.7,
        reviewCount: 298,
        brand: 'OutdoorWear',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Black', 'Navy', 'Olive'],
      ),

      // Shoes
      Product(
        id: '7',
        name: 'Running Shoes',
        description:
            'Lightweight running shoes with excellent cushioning and support. Perfect for marathons and daily runs.',
        price: 119.99,
        originalPrice: 159.99,
        imageUrl: 'https://picsum.photos/400/400?running',
        images: [
          'https://picsum.photos/400/400?running',
          'https://picsum.photos/400/400?running2',
        ],
        category: 'shoes',
        rating: 4.8,
        reviewCount: 445,
        brand: 'SportRunner',
        sizes: ['7', '8', '9', '10', '11', '12'],
        colors: ['White/Blue', 'Black/Red', 'Gray'],
      ),
      Product(
        id: '8',
        name: 'Casual Sneakers',
        description:
            'Comfortable casual sneakers for everyday wear. Versatile design that goes with any outfit.',
        price: 79.99,
        imageUrl: 'https://picsum.photos/400/400?sneakers',
        images: ['https://picsum.photos/400/400?sneakers'],
        category: 'shoes',
        rating: 4.5,
        reviewCount: 312,
        brand: 'UrbanStep',
        sizes: ['7', '8', '9', '10', '11'],
        colors: ['White', 'Black', 'Navy'],
      ),

      // Accessories
      Product(
        id: '9',
        name: 'Leather Wallet',
        description:
            'Genuine leather wallet with multiple card slots and bill compartment. Elegant and durable.',
        price: 49.99,
        originalPrice: 69.99,
        imageUrl: 'https://picsum.photos/400/400?wallet',
        images: ['https://picsum.photos/400/400?wallet'],
        category: 'accessories',
        rating: 4.6,
        reviewCount: 178,
        brand: 'LeatherCraft',
        colors: ['Brown', 'Black'],
      ),
      Product(
        id: '10',
        name: 'Sunglasses',
        description:
            'UV protection sunglasses with polarized lenses. Stylish design and superior eye protection.',
        price: 89.99,
        imageUrl: 'https://picsum.photos/400/400?sunglasses',
        images: ['https://picsum.photos/400/400?sunglasses'],
        category: 'accessories',
        rating: 4.4,
        reviewCount: 156,
        brand: 'SunStyle',
        colors: ['Black', 'Tortoise', 'Gold'],
      ),
      Product(
        id: '11',
        name: 'Backpack',
        description:
            'Spacious and durable backpack with laptop compartment. Perfect for work, school, or travel.',
        price: 69.99,
        originalPrice: 99.99,
        imageUrl: 'https://picsum.photos/400/400?backpack',
        images: [
          'https://picsum.photos/400/400?backpack',
          'https://picsum.photos/400/400?backpack2',
        ],
        category: 'accessories',
        rating: 4.7,
        reviewCount: 289,
        brand: 'TravelPro',
        colors: ['Black', 'Gray', 'Navy'],
      ),

      // Sports
      Product(
        id: '12',
        name: 'Yoga Mat',
        description:
            'Non-slip yoga mat with excellent cushioning. Eco-friendly material and easy to clean.',
        price: 39.99,
        imageUrl: 'https://picsum.photos/400/400?yoga',
        images: ['https://picsum.photos/400/400?yoga'],
        category: 'sports',
        rating: 4.5,
        reviewCount: 234,
        brand: 'YogaLife',
        colors: ['Purple', 'Blue', 'Pink', 'Green'],
      ),
      Product(
        id: '13',
        name: 'Dumbbell Set',
        description:
            'Adjustable dumbbell set with non-slip grip. Perfect for home workouts and strength training.',
        price: 149.99,
        originalPrice: 199.99,
        imageUrl: 'https://picsum.photos/400/400?dumbbells',
        images: ['https://picsum.photos/400/400?dumbbells'],
        category: 'sports',
        rating: 4.8,
        reviewCount: 367,
        brand: 'FitGear',
      ),

      // Home & Garden
      Product(
        id: '14',
        name: 'Coffee Maker',
        description:
            'Programmable coffee maker with thermal carafe. Brew perfect coffee every morning.',
        price: 79.99,
        imageUrl: 'https://picsum.photos/400/400?coffee',
        images: ['https://picsum.photos/400/400?coffee'],
        category: 'home',
        rating: 4.6,
        reviewCount: 423,
        brand: 'BrewMaster',
        colors: ['Black', 'Silver'],
      ),
      Product(
        id: '15',
        name: 'Table Lamp',
        description:
            'Modern LED table lamp with adjustable brightness. Energy-efficient and stylish design.',
        price: 44.99,
        originalPrice: 59.99,
        imageUrl: 'https://picsum.photos/400/400?lamp',
        images: ['https://picsum.photos/400/400?lamp'],
        category: 'home',
        rating: 4.4,
        reviewCount: 198,
        brand: 'LightHome',
        colors: ['White', 'Black', 'Wood'],
      ),
    ];
  }

  Future<Product?> getProductById(String id) async {
    await _simulateNetworkDelay();
    final products = await getProducts();
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
