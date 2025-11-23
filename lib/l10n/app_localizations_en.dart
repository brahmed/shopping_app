// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get newOnThisApp => 'New on this App?';

  @override
  String get createAccount => 'Create an account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get doYouHaveAccount => 'Do you have an account?';

  @override
  String get logIn => 'log in';

  @override
  String get signIn => 'Sign In';

  @override
  String get register => 'Register';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get or => 'or';

  @override
  String get logout => 'Log out';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get favorites => 'Favorites';

  @override
  String get profile => 'Profile';

  @override
  String get myAccount => 'My Account';

  @override
  String get shoppingCart => 'Shopping Cart';

  @override
  String get clearAll => 'Clear All';

  @override
  String get clearCart => 'Clear Cart';

  @override
  String get clearCartConfirmation =>
      'Are you sure you want to clear your cart?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get cartIsEmpty => 'Your cart is empty';

  @override
  String get startShopping => 'Start Shopping';

  @override
  String get size => 'Size';

  @override
  String get sizeWithColon => 'Size:';

  @override
  String get color => 'Color';

  @override
  String get colorWithColon => 'Color:';

  @override
  String get subtotal => 'Subtotal:';

  @override
  String get items => 'Items:';

  @override
  String get proceedToCheckout => 'Proceed to Checkout';

  @override
  String get itemRemovedFromCart => 'Item removed from cart';

  @override
  String get checkoutComingSoon => 'Checkout functionality coming soon!';

  @override
  String get viewCart => 'VIEW CART';

  @override
  String itemsAddedToCart(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString items added to cart',
      one: '1 item added to cart',
    );
    return '$_temp0';
  }

  @override
  String get categories => 'Categories';

  @override
  String get filteredProducts => 'Filtered Products';

  @override
  String get allProducts => 'All Products';

  @override
  String get clearFilter => 'Clear Filter';

  @override
  String get noProductsAvailable => 'No products available';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get tryAdjustingFilters => 'Try adjusting your search or filters';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get quantity => 'Quantity';

  @override
  String get description => 'Description';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get removedFromFavorites => 'Removed from favorites';

  @override
  String get addedToFavorites => 'Added to favorites';

  @override
  String get reviews => 'reviews';

  @override
  String discountOff(String percent) {
    return '-$percent% OFF';
  }

  @override
  String get searchProducts => 'Search products...';

  @override
  String get searchForProducts => 'Search for products';

  @override
  String get findWhatYouAreLookingFor =>
      'Find exactly what you\'re looking for';

  @override
  String get filters => 'Filters';

  @override
  String get category => 'Category';

  @override
  String get priceRange => 'Price Range';

  @override
  String get minPrice => 'Min Price';

  @override
  String get maxPrice => 'Max Price';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get myOrders => 'My Orders';

  @override
  String get orders => 'Orders';

  @override
  String get active => 'Active';

  @override
  String get completed => 'Completed';

  @override
  String get noOrdersYet => 'No Orders Yet';

  @override
  String get ordersWillAppearHere => 'Your orders will appear here';

  @override
  String get orderNumber => 'Order #';

  @override
  String get item => 'item';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get placedOn => 'Placed on';

  @override
  String get estimatedDelivery => 'Estimated delivery:';

  @override
  String get track => 'Track';

  @override
  String get noOrdersInCategory => 'No orders in this category';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get orderStatusConfirmed => 'Confirmed';

  @override
  String get orderStatusProcessing => 'Processing';

  @override
  String get orderStatusShipped => 'Shipped';

  @override
  String get orderStatusOutForDelivery => 'Out for Delivery';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get orderStatusReturned => 'Returned';

  @override
  String get orderStatusRefunded => 'Refunded';

  @override
  String get settings => 'Settings';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get help => 'Help';

  @override
  String get addresses => 'Addresses';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get wishlist => 'Wishlist';

  @override
  String get language => 'Language';

  @override
  String get notification => 'Notification';

  @override
  String get switchMode => 'Switch mode';

  @override
  String get languages => 'Languages';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'العربية';

  @override
  String get welcome => 'Hello';

  @override
  String welcomeMessage(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get loading => 'Loading...';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get done => 'Done';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String get submit => 'Submit';

  @override
  String get confirm => 'Confirm';

  @override
  String messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages',
      one: '1 message',
      zero: 'No messages',
    );
    return '$_temp0';
  }

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get tryAgain => 'Try again';

  @override
  String get success => 'Success';

  @override
  String priceAmount(String amount) {
    return '\$$amount';
  }

  @override
  String dateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }
}
