// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get newOnThisApp => 'جديد في هذا التطبيق؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get doYouHaveAccount => 'هل لديك حساب؟';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get register => 'التسجيل';

  @override
  String get continueWithFacebook => 'المتابعة مع فيسبوك';

  @override
  String get continueWithGoogle => 'المتابعة مع جوجل';

  @override
  String get or => 'أو';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get home => 'الرئيسية';

  @override
  String get search => 'بحث';

  @override
  String get bookmarks => 'المفضلة';

  @override
  String get favorites => 'المفضلة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get myAccount => 'حسابي';

  @override
  String get shoppingCart => 'سلة التسوق';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get clearCart => 'إفراغ السلة';

  @override
  String get clearCartConfirmation =>
      'هل أنت متأكد من رغبتك في إفراغ سلة التسوق؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'مسح';

  @override
  String get cartIsEmpty => 'سلة التسوق فارغة';

  @override
  String get startShopping => 'ابدأ التسوق';

  @override
  String get size => 'الحجم';

  @override
  String get sizeWithColon => 'الحجم:';

  @override
  String get color => 'اللون';

  @override
  String get colorWithColon => 'اللون:';

  @override
  String get subtotal => 'المجموع الفرعي:';

  @override
  String get items => 'العناصر:';

  @override
  String get proceedToCheckout => 'المتابعة للدفع';

  @override
  String get itemRemovedFromCart => 'تم إزالة العنصر من السلة';

  @override
  String get checkoutComingSoon => 'وظيفة الدفع قريبًا!';

  @override
  String get viewCart => 'عرض السلة';

  @override
  String itemsAddedToCart(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تمت إضافة $countString عناصر',
      one: 'تمت إضافة عنصر واحد',
    );
    return '$_temp0';
  }

  @override
  String get categories => 'الفئات';

  @override
  String get filteredProducts => 'المنتجات المفلترة';

  @override
  String get allProducts => 'جميع المنتجات';

  @override
  String get clearFilter => 'مسح الفلتر';

  @override
  String get noProductsAvailable => 'لا توجد منتجات متاحة';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get tryAdjustingFilters => 'حاول تعديل البحث أو الفلاتر';

  @override
  String get error => 'خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get quantity => 'الكمية';

  @override
  String get description => 'الوصف';

  @override
  String get outOfStock => 'نفد من المخزون';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get removedFromFavorites => 'تمت الإزالة من المفضلة';

  @override
  String get addedToFavorites => 'تمت الإضافة إلى المفضلة';

  @override
  String get reviews => 'تقييمات';

  @override
  String discountOff(String percent) {
    return 'خصم $percent%-';
  }

  @override
  String get searchProducts => 'البحث عن منتجات...';

  @override
  String get searchForProducts => 'البحث عن منتجات';

  @override
  String get findWhatYouAreLookingFor => 'اعثر بالضبط على ما تبحث عنه';

  @override
  String get filters => 'الفلاتر';

  @override
  String get category => 'الفئة';

  @override
  String get priceRange => 'نطاق السعر';

  @override
  String get minPrice => 'الحد الأدنى للسعر';

  @override
  String get maxPrice => 'الحد الأقصى للسعر';

  @override
  String get applyFilters => 'تطبيق الفلاتر';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get orders => 'الطلبات';

  @override
  String get active => 'نشط';

  @override
  String get completed => 'مكتمل';

  @override
  String get noOrdersYet => 'لا توجد طلبات بعد';

  @override
  String get ordersWillAppearHere => 'ستظهر طلباتك هنا';

  @override
  String get orderNumber => 'الطلب رقم';

  @override
  String get item => 'عنصر';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عناصر',
      one: 'عنصر واحد',
    );
    return '$_temp0';
  }

  @override
  String get placedOn => 'تم الطلب في';

  @override
  String get estimatedDelivery => 'التسليم المتوقع:';

  @override
  String get track => 'تتبع';

  @override
  String get noOrdersInCategory => 'لا توجد طلبات في هذه الفئة';

  @override
  String get orderStatusPending => 'قيد الانتظار';

  @override
  String get orderStatusConfirmed => 'مؤكد';

  @override
  String get orderStatusProcessing => 'قيد المعالجة';

  @override
  String get orderStatusShipped => 'تم الشحن';

  @override
  String get orderStatusOutForDelivery => 'خارج للتسليم';

  @override
  String get orderStatusDelivered => 'تم التسليم';

  @override
  String get orderStatusCancelled => 'ملغي';

  @override
  String get orderStatusReturned => 'مرتجع';

  @override
  String get orderStatusRefunded => 'مسترد';

  @override
  String get settings => 'الإعدادات';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get help => 'المساعدة';

  @override
  String get addresses => 'العناوين';

  @override
  String get mobileNumber => 'رقم الجوال';

  @override
  String get wishlist => 'قائمة الأمنيات';

  @override
  String get language => 'اللغة';

  @override
  String get notification => 'الإشعارات';

  @override
  String get switchMode => 'تبديل الوضع';

  @override
  String get languages => 'اللغات';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'العربية';

  @override
  String get welcome => 'مرحبا';

  @override
  String welcomeMessage(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get ok => 'موافق';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get done => 'تم';

  @override
  String get close => 'إغلاق';

  @override
  String get back => 'رجوع';

  @override
  String get next => 'التالي';

  @override
  String get previous => 'السابق';

  @override
  String get submit => 'إرسال';

  @override
  String get confirm => 'تأكيد';

  @override
  String messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count رسائل',
      one: 'رسالة واحدة',
      zero: 'لا توجد رسائل',
    );
    return '$_temp0';
  }

  @override
  String get errorOccurred => 'حدث خطأ';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get success => 'نجح';

  @override
  String priceAmount(String amount) {
    return '$amount د.ت';
  }

  @override
  String dateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }
}
