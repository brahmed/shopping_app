// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get login => 'Connexion';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get newOnThisApp => 'Nouveau sur cette application ?';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get doYouHaveAccount => 'Avez-vous un compte ?';

  @override
  String get logIn => 'se connecter';

  @override
  String get signIn => 'Se connecter';

  @override
  String get register => 'S\'inscrire';

  @override
  String get continueWithFacebook => 'Continuer avec Facebook';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get or => 'ou';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get home => 'Accueil';

  @override
  String get search => 'Rechercher';

  @override
  String get bookmarks => 'Favoris';

  @override
  String get favorites => 'Favoris';

  @override
  String get profile => 'Profil';

  @override
  String get myAccount => 'Mon compte';

  @override
  String get shoppingCart => 'Panier';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get clearCart => 'Vider le panier';

  @override
  String get clearCartConfirmation =>
      'Êtes-vous sûr de vouloir vider votre panier ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get clear => 'Effacer';

  @override
  String get cartIsEmpty => 'Votre panier est vide';

  @override
  String get startShopping => 'Commencer à magasiner';

  @override
  String get size => 'Taille';

  @override
  String get sizeWithColon => 'Taille :';

  @override
  String get color => 'Couleur';

  @override
  String get colorWithColon => 'Couleur :';

  @override
  String get subtotal => 'Sous-total :';

  @override
  String get items => 'Articles :';

  @override
  String get proceedToCheckout => 'Passer à la caisse';

  @override
  String get itemRemovedFromCart => 'Article retiré du panier';

  @override
  String get checkoutComingSoon =>
      'Fonctionnalité de paiement bientôt disponible !';

  @override
  String get viewCart => 'VOIR LE PANIER';

  @override
  String itemsAddedToCart(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString articles ajoutés au panier',
      one: '1 article ajouté au panier',
    );
    return '$_temp0';
  }

  @override
  String get categories => 'Catégories';

  @override
  String get filteredProducts => 'Produits filtrés';

  @override
  String get allProducts => 'Tous les produits';

  @override
  String get clearFilter => 'Effacer le filtre';

  @override
  String get noProductsAvailable => 'Aucun produit disponible';

  @override
  String get noProductsFound => 'Aucun produit trouvé';

  @override
  String get tryAdjustingFilters =>
      'Essayez d\'ajuster votre recherche ou vos filtres';

  @override
  String get error => 'Erreur';

  @override
  String get retry => 'Réessayer';

  @override
  String get quantity => 'Quantité';

  @override
  String get description => 'Description';

  @override
  String get outOfStock => 'Rupture de stock';

  @override
  String get addToCart => 'Ajouter au panier';

  @override
  String get removedFromFavorites => 'Retiré des favoris';

  @override
  String get addedToFavorites => 'Ajouté aux favoris';

  @override
  String get reviews => 'avis';

  @override
  String discountOff(String percent) {
    return '-$percent% DE RÉDUCTION';
  }

  @override
  String get searchProducts => 'Rechercher des produits...';

  @override
  String get searchForProducts => 'Rechercher des produits';

  @override
  String get findWhatYouAreLookingFor =>
      'Trouvez exactement ce que vous cherchez';

  @override
  String get filters => 'Filtres';

  @override
  String get category => 'Catégorie';

  @override
  String get priceRange => 'Gamme de prix';

  @override
  String get minPrice => 'Prix minimum';

  @override
  String get maxPrice => 'Prix maximum';

  @override
  String get applyFilters => 'Appliquer les filtres';

  @override
  String get myOrders => 'Mes commandes';

  @override
  String get orders => 'Commandes';

  @override
  String get active => 'Actif';

  @override
  String get completed => 'Terminé';

  @override
  String get noOrdersYet => 'Aucune commande pour le moment';

  @override
  String get ordersWillAppearHere => 'Vos commandes apparaîtront ici';

  @override
  String get orderNumber => 'Commande n°';

  @override
  String get item => 'article';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count articles',
      one: '1 article',
    );
    return '$_temp0';
  }

  @override
  String get placedOn => 'Passée le';

  @override
  String get estimatedDelivery => 'Livraison estimée :';

  @override
  String get track => 'Suivre';

  @override
  String get noOrdersInCategory => 'Aucune commande dans cette catégorie';

  @override
  String get orderStatusPending => 'En attente';

  @override
  String get orderStatusConfirmed => 'Confirmée';

  @override
  String get orderStatusProcessing => 'En traitement';

  @override
  String get orderStatusShipped => 'Expédiée';

  @override
  String get orderStatusOutForDelivery => 'En cours de livraison';

  @override
  String get orderStatusDelivered => 'Livrée';

  @override
  String get orderStatusCancelled => 'Annulée';

  @override
  String get orderStatusReturned => 'Retournée';

  @override
  String get orderStatusRefunded => 'Remboursée';

  @override
  String get settings => 'Paramètres';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get help => 'Aide';

  @override
  String get addresses => 'Adresses';

  @override
  String get mobileNumber => 'Numéro de mobile';

  @override
  String get wishlist => 'Liste de souhaits';

  @override
  String get language => 'Langue';

  @override
  String get notification => 'Notification';

  @override
  String get switchMode => 'Changer de mode';

  @override
  String get languages => 'Langues';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'العربية';

  @override
  String get welcome => 'Bonjour';

  @override
  String welcomeMessage(String name) {
    return 'Bienvenue, $name !';
  }

  @override
  String get loading => 'Chargement...';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get done => 'Terminé';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get next => 'Suivant';

  @override
  String get previous => 'Précédent';

  @override
  String get submit => 'Soumettre';

  @override
  String get confirm => 'Confirmer';

  @override
  String messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages',
      one: '1 message',
      zero: 'Aucun message',
    );
    return '$_temp0';
  }

  @override
  String get errorOccurred => 'Une erreur s\'est produite';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get success => 'Succès';

  @override
  String priceAmount(String amount) {
    return '$amount €';
  }

  @override
  String dateFormat(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }
}
