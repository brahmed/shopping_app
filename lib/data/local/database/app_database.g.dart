// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _originalPriceMeta =
      const VerificationMeta('originalPrice');
  @override
  late final GeneratedColumn<double> originalPrice = GeneratedColumn<double>(
      'original_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagesMeta = const VerificationMeta('images');
  @override
  late final GeneratedColumn<String> images = GeneratedColumn<String>(
      'images', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _reviewCountMeta =
      const VerificationMeta('reviewCount');
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
      'review_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _inStockMeta =
      const VerificationMeta('inStock');
  @override
  late final GeneratedColumn<bool> inStock = GeneratedColumn<bool>(
      'in_stock', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("in_stock" IN (0, 1))'));
  static const VerificationMeta _sizesMeta = const VerificationMeta('sizes');
  @override
  late final GeneratedColumn<String> sizes = GeneratedColumn<String>(
      'sizes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorsMeta = const VerificationMeta('colors');
  @override
  late final GeneratedColumn<String> colors = GeneratedColumn<String>(
      'colors', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        price,
        originalPrice,
        imageUrl,
        images,
        category,
        rating,
        reviewCount,
        inStock,
        sizes,
        colors,
        brand,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('original_price')) {
      context.handle(
          _originalPriceMeta,
          originalPrice.isAcceptableOrUnknown(
              data['original_price']!, _originalPriceMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('images')) {
      context.handle(_imagesMeta,
          images.isAcceptableOrUnknown(data['images']!, _imagesMeta));
    } else if (isInserting) {
      context.missing(_imagesMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('review_count')) {
      context.handle(
          _reviewCountMeta,
          reviewCount.isAcceptableOrUnknown(
              data['review_count']!, _reviewCountMeta));
    } else if (isInserting) {
      context.missing(_reviewCountMeta);
    }
    if (data.containsKey('in_stock')) {
      context.handle(_inStockMeta,
          inStock.isAcceptableOrUnknown(data['in_stock']!, _inStockMeta));
    } else if (isInserting) {
      context.missing(_inStockMeta);
    }
    if (data.containsKey('sizes')) {
      context.handle(
          _sizesMeta, sizes.isAcceptableOrUnknown(data['sizes']!, _sizesMeta));
    } else if (isInserting) {
      context.missing(_sizesMeta);
    }
    if (data.containsKey('colors')) {
      context.handle(_colorsMeta,
          colors.isAcceptableOrUnknown(data['colors']!, _colorsMeta));
    } else if (isInserting) {
      context.missing(_colorsMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      originalPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}original_price']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      images: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      reviewCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}review_count'])!,
      inStock: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}in_stock'])!,
      sizes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sizes'])!,
      colors: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}colors'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String images;
  final String category;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final String sizes;
  final String colors;
  final String? brand;
  final DateTime cachedAt;
  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      this.originalPrice,
      required this.imageUrl,
      required this.images,
      required this.category,
      required this.rating,
      required this.reviewCount,
      required this.inStock,
      required this.sizes,
      required this.colors,
      this.brand,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || originalPrice != null) {
      map['original_price'] = Variable<double>(originalPrice);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['images'] = Variable<String>(images);
    map['category'] = Variable<String>(category);
    map['rating'] = Variable<double>(rating);
    map['review_count'] = Variable<int>(reviewCount);
    map['in_stock'] = Variable<bool>(inStock);
    map['sizes'] = Variable<String>(sizes);
    map['colors'] = Variable<String>(colors);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      price: Value(price),
      originalPrice: originalPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(originalPrice),
      imageUrl: Value(imageUrl),
      images: Value(images),
      category: Value(category),
      rating: Value(rating),
      reviewCount: Value(reviewCount),
      inStock: Value(inStock),
      sizes: Value(sizes),
      colors: Value(colors),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      cachedAt: Value(cachedAt),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      originalPrice: serializer.fromJson<double?>(json['originalPrice']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      images: serializer.fromJson<String>(json['images']),
      category: serializer.fromJson<String>(json['category']),
      rating: serializer.fromJson<double>(json['rating']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      inStock: serializer.fromJson<bool>(json['inStock']),
      sizes: serializer.fromJson<String>(json['sizes']),
      colors: serializer.fromJson<String>(json['colors']),
      brand: serializer.fromJson<String?>(json['brand']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<double>(price),
      'originalPrice': serializer.toJson<double?>(originalPrice),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'images': serializer.toJson<String>(images),
      'category': serializer.toJson<String>(category),
      'rating': serializer.toJson<double>(rating),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'inStock': serializer.toJson<bool>(inStock),
      'sizes': serializer.toJson<String>(sizes),
      'colors': serializer.toJson<String>(colors),
      'brand': serializer.toJson<String?>(brand),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Product copyWith(
          {String? id,
          String? name,
          String? description,
          double? price,
          Value<double?> originalPrice = const Value.absent(),
          String? imageUrl,
          String? images,
          String? category,
          double? rating,
          int? reviewCount,
          bool? inStock,
          String? sizes,
          String? colors,
          Value<String?> brand = const Value.absent(),
          DateTime? cachedAt}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        originalPrice:
            originalPrice.present ? originalPrice.value : this.originalPrice,
        imageUrl: imageUrl ?? this.imageUrl,
        images: images ?? this.images,
        category: category ?? this.category,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        inStock: inStock ?? this.inStock,
        sizes: sizes ?? this.sizes,
        colors: colors ?? this.colors,
        brand: brand.present ? brand.value : this.brand,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      price: data.price.present ? data.price.value : this.price,
      originalPrice: data.originalPrice.present
          ? data.originalPrice.value
          : this.originalPrice,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      images: data.images.present ? data.images.value : this.images,
      category: data.category.present ? data.category.value : this.category,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewCount:
          data.reviewCount.present ? data.reviewCount.value : this.reviewCount,
      inStock: data.inStock.present ? data.inStock.value : this.inStock,
      sizes: data.sizes.present ? data.sizes.value : this.sizes,
      colors: data.colors.present ? data.colors.value : this.colors,
      brand: data.brand.present ? data.brand.value : this.brand,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('originalPrice: $originalPrice, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('images: $images, ')
          ..write('category: $category, ')
          ..write('rating: $rating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('inStock: $inStock, ')
          ..write('sizes: $sizes, ')
          ..write('colors: $colors, ')
          ..write('brand: $brand, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      price,
      originalPrice,
      imageUrl,
      images,
      category,
      rating,
      reviewCount,
      inStock,
      sizes,
      colors,
      brand,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.originalPrice == this.originalPrice &&
          other.imageUrl == this.imageUrl &&
          other.images == this.images &&
          other.category == this.category &&
          other.rating == this.rating &&
          other.reviewCount == this.reviewCount &&
          other.inStock == this.inStock &&
          other.sizes == this.sizes &&
          other.colors == this.colors &&
          other.brand == this.brand &&
          other.cachedAt == this.cachedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<double> price;
  final Value<double?> originalPrice;
  final Value<String> imageUrl;
  final Value<String> images;
  final Value<String> category;
  final Value<double> rating;
  final Value<int> reviewCount;
  final Value<bool> inStock;
  final Value<String> sizes;
  final Value<String> colors;
  final Value<String?> brand;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.originalPrice = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.images = const Value.absent(),
    this.category = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.inStock = const Value.absent(),
    this.sizes = const Value.absent(),
    this.colors = const Value.absent(),
    this.brand = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String name,
    required String description,
    required double price,
    this.originalPrice = const Value.absent(),
    required String imageUrl,
    required String images,
    required String category,
    required double rating,
    required int reviewCount,
    required bool inStock,
    required String sizes,
    required String colors,
    this.brand = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        price = Value(price),
        imageUrl = Value(imageUrl),
        images = Value(images),
        category = Value(category),
        rating = Value(rating),
        reviewCount = Value(reviewCount),
        inStock = Value(inStock),
        sizes = Value(sizes),
        colors = Value(colors),
        cachedAt = Value(cachedAt);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? price,
    Expression<double>? originalPrice,
    Expression<String>? imageUrl,
    Expression<String>? images,
    Expression<String>? category,
    Expression<double>? rating,
    Expression<int>? reviewCount,
    Expression<bool>? inStock,
    Expression<String>? sizes,
    Expression<String>? colors,
    Expression<String>? brand,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (originalPrice != null) 'original_price': originalPrice,
      if (imageUrl != null) 'image_url': imageUrl,
      if (images != null) 'images': images,
      if (category != null) 'category': category,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'review_count': reviewCount,
      if (inStock != null) 'in_stock': inStock,
      if (sizes != null) 'sizes': sizes,
      if (colors != null) 'colors': colors,
      if (brand != null) 'brand': brand,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<double>? price,
      Value<double?>? originalPrice,
      Value<String>? imageUrl,
      Value<String>? images,
      Value<String>? category,
      Value<double>? rating,
      Value<int>? reviewCount,
      Value<bool>? inStock,
      Value<String>? sizes,
      Value<String>? colors,
      Value<String?>? brand,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      inStock: inStock ?? this.inStock,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      brand: brand ?? this.brand,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (originalPrice.present) {
      map['original_price'] = Variable<double>(originalPrice.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(images.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (inStock.present) {
      map['in_stock'] = Variable<bool>(inStock.value);
    }
    if (sizes.present) {
      map['sizes'] = Variable<String>(sizes.value);
    }
    if (colors.present) {
      map['colors'] = Variable<String>(colors.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('originalPrice: $originalPrice, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('images: $images, ')
          ..write('category: $category, ')
          ..write('rating: $rating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('inStock: $inStock, ')
          ..write('sizes: $sizes, ')
          ..write('colors: $colors, ')
          ..write('brand: $brand, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, iconName, imageUrl, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final String? iconName;
  final String? imageUrl;
  final DateTime cachedAt;
  const Category(
      {required this.id,
      required this.name,
      this.iconName,
      this.imageUrl,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      cachedAt: Value(cachedAt),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String?>(iconName),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Category copyWith(
          {String? id,
          String? name,
          Value<String?> iconName = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          DateTime? cachedAt}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        iconName: iconName.present ? iconName.value : this.iconName,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconName, imageUrl, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.imageUrl == this.imageUrl &&
          other.cachedAt == this.cachedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> iconName;
  final Value<String?> imageUrl;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    this.iconName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        cachedAt = Value(cachedAt);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? iconName,
    Expression<String>? imageUrl,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? iconName,
      Value<String?>? imageUrl,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      imageUrl: imageUrl ?? this.imageUrl,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemsMeta = const VerificationMeta('items');
  @override
  late final GeneratedColumn<String> items = GeneratedColumn<String>(
      'items', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _shippingCostMeta =
      const VerificationMeta('shippingCost');
  @override
  late final GeneratedColumn<double> shippingCost = GeneratedColumn<double>(
      'shipping_cost', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
      'tax', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
      'payment_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderDateMeta =
      const VerificationMeta('orderDate');
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
      'order_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deliveryDateMeta =
      const VerificationMeta('deliveryDate');
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
      'delivery_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _estimatedDeliveryMeta =
      const VerificationMeta('estimatedDelivery');
  @override
  late final GeneratedColumn<DateTime> estimatedDelivery =
      GeneratedColumn<DateTime>('estimated_delivery', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _shippingAddressMeta =
      const VerificationMeta('shippingAddress');
  @override
  late final GeneratedColumn<String> shippingAddress = GeneratedColumn<String>(
      'shipping_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _billingAddressMeta =
      const VerificationMeta('billingAddress');
  @override
  late final GeneratedColumn<String> billingAddress = GeneratedColumn<String>(
      'billing_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _trackingNumberMeta =
      const VerificationMeta('trackingNumber');
  @override
  late final GeneratedColumn<String> trackingNumber = GeneratedColumn<String>(
      'tracking_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _couponCodeMeta =
      const VerificationMeta('couponCode');
  @override
  late final GeneratedColumn<String> couponCode = GeneratedColumn<String>(
      'coupon_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderNotesMeta =
      const VerificationMeta('orderNotes');
  @override
  late final GeneratedColumn<String> orderNotes = GeneratedColumn<String>(
      'order_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isGiftMeta = const VerificationMeta('isGift');
  @override
  late final GeneratedColumn<bool> isGift = GeneratedColumn<bool>(
      'is_gift', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_gift" IN (0, 1))'));
  static const VerificationMeta _giftMessageMeta =
      const VerificationMeta('giftMessage');
  @override
  late final GeneratedColumn<String> giftMessage = GeneratedColumn<String>(
      'gift_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusUpdatesMeta =
      const VerificationMeta('statusUpdates');
  @override
  late final GeneratedColumn<String> statusUpdates = GeneratedColumn<String>(
      'status_updates', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        items,
        subtotal,
        discount,
        shippingCost,
        tax,
        totalAmount,
        status,
        paymentStatus,
        paymentMethod,
        orderDate,
        deliveryDate,
        estimatedDelivery,
        shippingAddress,
        billingAddress,
        trackingNumber,
        couponCode,
        orderNotes,
        isGift,
        giftMessage,
        statusUpdates,
        isSynced,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('items')) {
      context.handle(
          _itemsMeta, items.isAcceptableOrUnknown(data['items']!, _itemsMeta));
    } else if (isInserting) {
      context.missing(_itemsMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    } else if (isInserting) {
      context.missing(_discountMeta);
    }
    if (data.containsKey('shipping_cost')) {
      context.handle(
          _shippingCostMeta,
          shippingCost.isAcceptableOrUnknown(
              data['shipping_cost']!, _shippingCostMeta));
    } else if (isInserting) {
      context.missing(_shippingCostMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
          _taxMeta, tax.isAcceptableOrUnknown(data['tax']!, _taxMeta));
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('order_date')) {
      context.handle(_orderDateMeta,
          orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta));
    } else if (isInserting) {
      context.missing(_orderDateMeta);
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
          _deliveryDateMeta,
          deliveryDate.isAcceptableOrUnknown(
              data['delivery_date']!, _deliveryDateMeta));
    }
    if (data.containsKey('estimated_delivery')) {
      context.handle(
          _estimatedDeliveryMeta,
          estimatedDelivery.isAcceptableOrUnknown(
              data['estimated_delivery']!, _estimatedDeliveryMeta));
    }
    if (data.containsKey('shipping_address')) {
      context.handle(
          _shippingAddressMeta,
          shippingAddress.isAcceptableOrUnknown(
              data['shipping_address']!, _shippingAddressMeta));
    } else if (isInserting) {
      context.missing(_shippingAddressMeta);
    }
    if (data.containsKey('billing_address')) {
      context.handle(
          _billingAddressMeta,
          billingAddress.isAcceptableOrUnknown(
              data['billing_address']!, _billingAddressMeta));
    }
    if (data.containsKey('tracking_number')) {
      context.handle(
          _trackingNumberMeta,
          trackingNumber.isAcceptableOrUnknown(
              data['tracking_number']!, _trackingNumberMeta));
    }
    if (data.containsKey('coupon_code')) {
      context.handle(
          _couponCodeMeta,
          couponCode.isAcceptableOrUnknown(
              data['coupon_code']!, _couponCodeMeta));
    }
    if (data.containsKey('order_notes')) {
      context.handle(
          _orderNotesMeta,
          orderNotes.isAcceptableOrUnknown(
              data['order_notes']!, _orderNotesMeta));
    }
    if (data.containsKey('is_gift')) {
      context.handle(_isGiftMeta,
          isGift.isAcceptableOrUnknown(data['is_gift']!, _isGiftMeta));
    } else if (isInserting) {
      context.missing(_isGiftMeta);
    }
    if (data.containsKey('gift_message')) {
      context.handle(
          _giftMessageMeta,
          giftMessage.isAcceptableOrUnknown(
              data['gift_message']!, _giftMessageMeta));
    }
    if (data.containsKey('status_updates')) {
      context.handle(
          _statusUpdatesMeta,
          statusUpdates.isAcceptableOrUnknown(
              data['status_updates']!, _statusUpdatesMeta));
    } else if (isInserting) {
      context.missing(_statusUpdatesMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      items: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}items'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount'])!,
      shippingCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}shipping_cost'])!,
      tax: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      paymentStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_status'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      orderDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}order_date'])!,
      deliveryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}delivery_date']),
      estimatedDelivery: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}estimated_delivery']),
      shippingAddress: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}shipping_address'])!,
      billingAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}billing_address']),
      trackingNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tracking_number']),
      couponCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coupon_code']),
      orderNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_notes']),
      isGift: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_gift'])!,
      giftMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gift_message']),
      statusUpdates: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_updates'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final String id;
  final String userId;
  final String items;
  final double subtotal;
  final double discount;
  final double shippingCost;
  final double tax;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final DateTime? estimatedDelivery;
  final String shippingAddress;
  final String? billingAddress;
  final String? trackingNumber;
  final String? couponCode;
  final String? orderNotes;
  final bool isGift;
  final String? giftMessage;
  final String statusUpdates;
  final bool isSynced;
  final DateTime cachedAt;
  const Order(
      {required this.id,
      required this.userId,
      required this.items,
      required this.subtotal,
      required this.discount,
      required this.shippingCost,
      required this.tax,
      required this.totalAmount,
      required this.status,
      required this.paymentStatus,
      required this.paymentMethod,
      required this.orderDate,
      this.deliveryDate,
      this.estimatedDelivery,
      required this.shippingAddress,
      this.billingAddress,
      this.trackingNumber,
      this.couponCode,
      this.orderNotes,
      required this.isGift,
      this.giftMessage,
      required this.statusUpdates,
      required this.isSynced,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['items'] = Variable<String>(items);
    map['subtotal'] = Variable<double>(subtotal);
    map['discount'] = Variable<double>(discount);
    map['shipping_cost'] = Variable<double>(shippingCost);
    map['tax'] = Variable<double>(tax);
    map['total_amount'] = Variable<double>(totalAmount);
    map['status'] = Variable<String>(status);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['order_date'] = Variable<DateTime>(orderDate);
    if (!nullToAbsent || deliveryDate != null) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate);
    }
    if (!nullToAbsent || estimatedDelivery != null) {
      map['estimated_delivery'] = Variable<DateTime>(estimatedDelivery);
    }
    map['shipping_address'] = Variable<String>(shippingAddress);
    if (!nullToAbsent || billingAddress != null) {
      map['billing_address'] = Variable<String>(billingAddress);
    }
    if (!nullToAbsent || trackingNumber != null) {
      map['tracking_number'] = Variable<String>(trackingNumber);
    }
    if (!nullToAbsent || couponCode != null) {
      map['coupon_code'] = Variable<String>(couponCode);
    }
    if (!nullToAbsent || orderNotes != null) {
      map['order_notes'] = Variable<String>(orderNotes);
    }
    map['is_gift'] = Variable<bool>(isGift);
    if (!nullToAbsent || giftMessage != null) {
      map['gift_message'] = Variable<String>(giftMessage);
    }
    map['status_updates'] = Variable<String>(statusUpdates);
    map['is_synced'] = Variable<bool>(isSynced);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      userId: Value(userId),
      items: Value(items),
      subtotal: Value(subtotal),
      discount: Value(discount),
      shippingCost: Value(shippingCost),
      tax: Value(tax),
      totalAmount: Value(totalAmount),
      status: Value(status),
      paymentStatus: Value(paymentStatus),
      paymentMethod: Value(paymentMethod),
      orderDate: Value(orderDate),
      deliveryDate: deliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryDate),
      estimatedDelivery: estimatedDelivery == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDelivery),
      shippingAddress: Value(shippingAddress),
      billingAddress: billingAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(billingAddress),
      trackingNumber: trackingNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackingNumber),
      couponCode: couponCode == null && nullToAbsent
          ? const Value.absent()
          : Value(couponCode),
      orderNotes: orderNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(orderNotes),
      isGift: Value(isGift),
      giftMessage: giftMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(giftMessage),
      statusUpdates: Value(statusUpdates),
      isSynced: Value(isSynced),
      cachedAt: Value(cachedAt),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      items: serializer.fromJson<String>(json['items']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discount: serializer.fromJson<double>(json['discount']),
      shippingCost: serializer.fromJson<double>(json['shippingCost']),
      tax: serializer.fromJson<double>(json['tax']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: serializer.fromJson<String>(json['status']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      deliveryDate: serializer.fromJson<DateTime?>(json['deliveryDate']),
      estimatedDelivery:
          serializer.fromJson<DateTime?>(json['estimatedDelivery']),
      shippingAddress: serializer.fromJson<String>(json['shippingAddress']),
      billingAddress: serializer.fromJson<String?>(json['billingAddress']),
      trackingNumber: serializer.fromJson<String?>(json['trackingNumber']),
      couponCode: serializer.fromJson<String?>(json['couponCode']),
      orderNotes: serializer.fromJson<String?>(json['orderNotes']),
      isGift: serializer.fromJson<bool>(json['isGift']),
      giftMessage: serializer.fromJson<String?>(json['giftMessage']),
      statusUpdates: serializer.fromJson<String>(json['statusUpdates']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'items': serializer.toJson<String>(items),
      'subtotal': serializer.toJson<double>(subtotal),
      'discount': serializer.toJson<double>(discount),
      'shippingCost': serializer.toJson<double>(shippingCost),
      'tax': serializer.toJson<double>(tax),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(status),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'deliveryDate': serializer.toJson<DateTime?>(deliveryDate),
      'estimatedDelivery': serializer.toJson<DateTime?>(estimatedDelivery),
      'shippingAddress': serializer.toJson<String>(shippingAddress),
      'billingAddress': serializer.toJson<String?>(billingAddress),
      'trackingNumber': serializer.toJson<String?>(trackingNumber),
      'couponCode': serializer.toJson<String?>(couponCode),
      'orderNotes': serializer.toJson<String?>(orderNotes),
      'isGift': serializer.toJson<bool>(isGift),
      'giftMessage': serializer.toJson<String?>(giftMessage),
      'statusUpdates': serializer.toJson<String>(statusUpdates),
      'isSynced': serializer.toJson<bool>(isSynced),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Order copyWith(
          {String? id,
          String? userId,
          String? items,
          double? subtotal,
          double? discount,
          double? shippingCost,
          double? tax,
          double? totalAmount,
          String? status,
          String? paymentStatus,
          String? paymentMethod,
          DateTime? orderDate,
          Value<DateTime?> deliveryDate = const Value.absent(),
          Value<DateTime?> estimatedDelivery = const Value.absent(),
          String? shippingAddress,
          Value<String?> billingAddress = const Value.absent(),
          Value<String?> trackingNumber = const Value.absent(),
          Value<String?> couponCode = const Value.absent(),
          Value<String?> orderNotes = const Value.absent(),
          bool? isGift,
          Value<String?> giftMessage = const Value.absent(),
          String? statusUpdates,
          bool? isSynced,
          DateTime? cachedAt}) =>
      Order(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        items: items ?? this.items,
        subtotal: subtotal ?? this.subtotal,
        discount: discount ?? this.discount,
        shippingCost: shippingCost ?? this.shippingCost,
        tax: tax ?? this.tax,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        orderDate: orderDate ?? this.orderDate,
        deliveryDate:
            deliveryDate.present ? deliveryDate.value : this.deliveryDate,
        estimatedDelivery: estimatedDelivery.present
            ? estimatedDelivery.value
            : this.estimatedDelivery,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        billingAddress:
            billingAddress.present ? billingAddress.value : this.billingAddress,
        trackingNumber:
            trackingNumber.present ? trackingNumber.value : this.trackingNumber,
        couponCode: couponCode.present ? couponCode.value : this.couponCode,
        orderNotes: orderNotes.present ? orderNotes.value : this.orderNotes,
        isGift: isGift ?? this.isGift,
        giftMessage: giftMessage.present ? giftMessage.value : this.giftMessage,
        statusUpdates: statusUpdates ?? this.statusUpdates,
        isSynced: isSynced ?? this.isSynced,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      items: data.items.present ? data.items.value : this.items,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      shippingCost: data.shippingCost.present
          ? data.shippingCost.value
          : this.shippingCost,
      tax: data.tax.present ? data.tax.value : this.tax,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      status: data.status.present ? data.status.value : this.status,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      orderDate: data.orderDate.present ? data.orderDate.value : this.orderDate,
      deliveryDate: data.deliveryDate.present
          ? data.deliveryDate.value
          : this.deliveryDate,
      estimatedDelivery: data.estimatedDelivery.present
          ? data.estimatedDelivery.value
          : this.estimatedDelivery,
      shippingAddress: data.shippingAddress.present
          ? data.shippingAddress.value
          : this.shippingAddress,
      billingAddress: data.billingAddress.present
          ? data.billingAddress.value
          : this.billingAddress,
      trackingNumber: data.trackingNumber.present
          ? data.trackingNumber.value
          : this.trackingNumber,
      couponCode:
          data.couponCode.present ? data.couponCode.value : this.couponCode,
      orderNotes:
          data.orderNotes.present ? data.orderNotes.value : this.orderNotes,
      isGift: data.isGift.present ? data.isGift.value : this.isGift,
      giftMessage:
          data.giftMessage.present ? data.giftMessage.value : this.giftMessage,
      statusUpdates: data.statusUpdates.present
          ? data.statusUpdates.value
          : this.statusUpdates,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('items: $items, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('tax: $tax, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('orderDate: $orderDate, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('estimatedDelivery: $estimatedDelivery, ')
          ..write('shippingAddress: $shippingAddress, ')
          ..write('billingAddress: $billingAddress, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('couponCode: $couponCode, ')
          ..write('orderNotes: $orderNotes, ')
          ..write('isGift: $isGift, ')
          ..write('giftMessage: $giftMessage, ')
          ..write('statusUpdates: $statusUpdates, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        userId,
        items,
        subtotal,
        discount,
        shippingCost,
        tax,
        totalAmount,
        status,
        paymentStatus,
        paymentMethod,
        orderDate,
        deliveryDate,
        estimatedDelivery,
        shippingAddress,
        billingAddress,
        trackingNumber,
        couponCode,
        orderNotes,
        isGift,
        giftMessage,
        statusUpdates,
        isSynced,
        cachedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.items == this.items &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.shippingCost == this.shippingCost &&
          other.tax == this.tax &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.paymentStatus == this.paymentStatus &&
          other.paymentMethod == this.paymentMethod &&
          other.orderDate == this.orderDate &&
          other.deliveryDate == this.deliveryDate &&
          other.estimatedDelivery == this.estimatedDelivery &&
          other.shippingAddress == this.shippingAddress &&
          other.billingAddress == this.billingAddress &&
          other.trackingNumber == this.trackingNumber &&
          other.couponCode == this.couponCode &&
          other.orderNotes == this.orderNotes &&
          other.isGift == this.isGift &&
          other.giftMessage == this.giftMessage &&
          other.statusUpdates == this.statusUpdates &&
          other.isSynced == this.isSynced &&
          other.cachedAt == this.cachedAt);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> items;
  final Value<double> subtotal;
  final Value<double> discount;
  final Value<double> shippingCost;
  final Value<double> tax;
  final Value<double> totalAmount;
  final Value<String> status;
  final Value<String> paymentStatus;
  final Value<String> paymentMethod;
  final Value<DateTime> orderDate;
  final Value<DateTime?> deliveryDate;
  final Value<DateTime?> estimatedDelivery;
  final Value<String> shippingAddress;
  final Value<String?> billingAddress;
  final Value<String?> trackingNumber;
  final Value<String?> couponCode;
  final Value<String?> orderNotes;
  final Value<bool> isGift;
  final Value<String?> giftMessage;
  final Value<String> statusUpdates;
  final Value<bool> isSynced;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.items = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.shippingCost = const Value.absent(),
    this.tax = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.estimatedDelivery = const Value.absent(),
    this.shippingAddress = const Value.absent(),
    this.billingAddress = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.couponCode = const Value.absent(),
    this.orderNotes = const Value.absent(),
    this.isGift = const Value.absent(),
    this.giftMessage = const Value.absent(),
    this.statusUpdates = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    required String id,
    required String userId,
    required String items,
    required double subtotal,
    required double discount,
    required double shippingCost,
    required double tax,
    required double totalAmount,
    required String status,
    required String paymentStatus,
    required String paymentMethod,
    required DateTime orderDate,
    this.deliveryDate = const Value.absent(),
    this.estimatedDelivery = const Value.absent(),
    required String shippingAddress,
    this.billingAddress = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.couponCode = const Value.absent(),
    this.orderNotes = const Value.absent(),
    required bool isGift,
    this.giftMessage = const Value.absent(),
    required String statusUpdates,
    this.isSynced = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        items = Value(items),
        subtotal = Value(subtotal),
        discount = Value(discount),
        shippingCost = Value(shippingCost),
        tax = Value(tax),
        totalAmount = Value(totalAmount),
        status = Value(status),
        paymentStatus = Value(paymentStatus),
        paymentMethod = Value(paymentMethod),
        orderDate = Value(orderDate),
        shippingAddress = Value(shippingAddress),
        isGift = Value(isGift),
        statusUpdates = Value(statusUpdates),
        cachedAt = Value(cachedAt);
  static Insertable<Order> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? items,
    Expression<double>? subtotal,
    Expression<double>? discount,
    Expression<double>? shippingCost,
    Expression<double>? tax,
    Expression<double>? totalAmount,
    Expression<String>? status,
    Expression<String>? paymentStatus,
    Expression<String>? paymentMethod,
    Expression<DateTime>? orderDate,
    Expression<DateTime>? deliveryDate,
    Expression<DateTime>? estimatedDelivery,
    Expression<String>? shippingAddress,
    Expression<String>? billingAddress,
    Expression<String>? trackingNumber,
    Expression<String>? couponCode,
    Expression<String>? orderNotes,
    Expression<bool>? isGift,
    Expression<String>? giftMessage,
    Expression<String>? statusUpdates,
    Expression<bool>? isSynced,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (items != null) 'items': items,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (shippingCost != null) 'shipping_cost': shippingCost,
      if (tax != null) 'tax': tax,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (orderDate != null) 'order_date': orderDate,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (estimatedDelivery != null) 'estimated_delivery': estimatedDelivery,
      if (shippingAddress != null) 'shipping_address': shippingAddress,
      if (billingAddress != null) 'billing_address': billingAddress,
      if (trackingNumber != null) 'tracking_number': trackingNumber,
      if (couponCode != null) 'coupon_code': couponCode,
      if (orderNotes != null) 'order_notes': orderNotes,
      if (isGift != null) 'is_gift': isGift,
      if (giftMessage != null) 'gift_message': giftMessage,
      if (statusUpdates != null) 'status_updates': statusUpdates,
      if (isSynced != null) 'is_synced': isSynced,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? items,
      Value<double>? subtotal,
      Value<double>? discount,
      Value<double>? shippingCost,
      Value<double>? tax,
      Value<double>? totalAmount,
      Value<String>? status,
      Value<String>? paymentStatus,
      Value<String>? paymentMethod,
      Value<DateTime>? orderDate,
      Value<DateTime?>? deliveryDate,
      Value<DateTime?>? estimatedDelivery,
      Value<String>? shippingAddress,
      Value<String?>? billingAddress,
      Value<String?>? trackingNumber,
      Value<String?>? couponCode,
      Value<String?>? orderNotes,
      Value<bool>? isGift,
      Value<String?>? giftMessage,
      Value<String>? statusUpdates,
      Value<bool>? isSynced,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return OrdersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      shippingCost: shippingCost ?? this.shippingCost,
      tax: tax ?? this.tax,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      couponCode: couponCode ?? this.couponCode,
      orderNotes: orderNotes ?? this.orderNotes,
      isGift: isGift ?? this.isGift,
      giftMessage: giftMessage ?? this.giftMessage,
      statusUpdates: statusUpdates ?? this.statusUpdates,
      isSynced: isSynced ?? this.isSynced,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (items.present) {
      map['items'] = Variable<String>(items.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (shippingCost.present) {
      map['shipping_cost'] = Variable<double>(shippingCost.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (estimatedDelivery.present) {
      map['estimated_delivery'] = Variable<DateTime>(estimatedDelivery.value);
    }
    if (shippingAddress.present) {
      map['shipping_address'] = Variable<String>(shippingAddress.value);
    }
    if (billingAddress.present) {
      map['billing_address'] = Variable<String>(billingAddress.value);
    }
    if (trackingNumber.present) {
      map['tracking_number'] = Variable<String>(trackingNumber.value);
    }
    if (couponCode.present) {
      map['coupon_code'] = Variable<String>(couponCode.value);
    }
    if (orderNotes.present) {
      map['order_notes'] = Variable<String>(orderNotes.value);
    }
    if (isGift.present) {
      map['is_gift'] = Variable<bool>(isGift.value);
    }
    if (giftMessage.present) {
      map['gift_message'] = Variable<String>(giftMessage.value);
    }
    if (statusUpdates.present) {
      map['status_updates'] = Variable<String>(statusUpdates.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('items: $items, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('tax: $tax, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('orderDate: $orderDate, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('estimatedDelivery: $estimatedDelivery, ')
          ..write('shippingAddress: $shippingAddress, ')
          ..write('billingAddress: $billingAddress, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('couponCode: $couponCode, ')
          ..write('orderNotes: $orderNotes, ')
          ..write('isGift: $isGift, ')
          ..write('giftMessage: $giftMessage, ')
          ..write('statusUpdates: $statusUpdates, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AddressesTable extends Addresses
    with TableInfo<$AddressesTable, AddressesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AddressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressLine1Meta =
      const VerificationMeta('addressLine1');
  @override
  late final GeneratedColumn<String> addressLine1 = GeneratedColumn<String>(
      'address_line1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressLine2Meta =
      const VerificationMeta('addressLine2');
  @override
  late final GeneratedColumn<String> addressLine2 = GeneratedColumn<String>(
      'address_line2', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _zipCodeMeta =
      const VerificationMeta('zipCode');
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
      'zip_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _landmarkMeta =
      const VerificationMeta('landmark');
  @override
  late final GeneratedColumn<String> landmark = GeneratedColumn<String>(
      'landmark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        fullName,
        phoneNumber,
        addressLine1,
        addressLine2,
        city,
        state,
        country,
        zipCode,
        landmark,
        isDefault,
        type,
        isSynced,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'addresses';
  @override
  VerificationContext validateIntegrity(Insertable<AddressesData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('address_line1')) {
      context.handle(
          _addressLine1Meta,
          addressLine1.isAcceptableOrUnknown(
              data['address_line1']!, _addressLine1Meta));
    } else if (isInserting) {
      context.missing(_addressLine1Meta);
    }
    if (data.containsKey('address_line2')) {
      context.handle(
          _addressLine2Meta,
          addressLine2.isAcceptableOrUnknown(
              data['address_line2']!, _addressLine2Meta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta));
    } else if (isInserting) {
      context.missing(_zipCodeMeta);
    }
    if (data.containsKey('landmark')) {
      context.handle(_landmarkMeta,
          landmark.isAcceptableOrUnknown(data['landmark']!, _landmarkMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    } else if (isInserting) {
      context.missing(_isDefaultMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AddressesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AddressesData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      addressLine1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_line1'])!,
      addressLine2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_line2']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      zipCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zip_code'])!,
      landmark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}landmark']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $AddressesTable createAlias(String alias) {
    return $AddressesTable(attachedDatabase, alias);
  }
}

class AddressesData extends DataClass implements Insertable<AddressesData> {
  final String id;
  final String userId;
  final String fullName;
  final String phoneNumber;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String? landmark;
  final bool isDefault;
  final String type;
  final bool isSynced;
  final DateTime cachedAt;
  const AddressesData(
      {required this.id,
      required this.userId,
      required this.fullName,
      required this.phoneNumber,
      required this.addressLine1,
      this.addressLine2,
      required this.city,
      required this.state,
      required this.country,
      required this.zipCode,
      this.landmark,
      required this.isDefault,
      required this.type,
      required this.isSynced,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['full_name'] = Variable<String>(fullName);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['address_line1'] = Variable<String>(addressLine1);
    if (!nullToAbsent || addressLine2 != null) {
      map['address_line2'] = Variable<String>(addressLine2);
    }
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['country'] = Variable<String>(country);
    map['zip_code'] = Variable<String>(zipCode);
    if (!nullToAbsent || landmark != null) {
      map['landmark'] = Variable<String>(landmark);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['type'] = Variable<String>(type);
    map['is_synced'] = Variable<bool>(isSynced);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  AddressesCompanion toCompanion(bool nullToAbsent) {
    return AddressesCompanion(
      id: Value(id),
      userId: Value(userId),
      fullName: Value(fullName),
      phoneNumber: Value(phoneNumber),
      addressLine1: Value(addressLine1),
      addressLine2: addressLine2 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine2),
      city: Value(city),
      state: Value(state),
      country: Value(country),
      zipCode: Value(zipCode),
      landmark: landmark == null && nullToAbsent
          ? const Value.absent()
          : Value(landmark),
      isDefault: Value(isDefault),
      type: Value(type),
      isSynced: Value(isSynced),
      cachedAt: Value(cachedAt),
    );
  }

  factory AddressesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AddressesData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      addressLine1: serializer.fromJson<String>(json['addressLine1']),
      addressLine2: serializer.fromJson<String?>(json['addressLine2']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      zipCode: serializer.fromJson<String>(json['zipCode']),
      landmark: serializer.fromJson<String?>(json['landmark']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      type: serializer.fromJson<String>(json['type']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'fullName': serializer.toJson<String>(fullName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'addressLine1': serializer.toJson<String>(addressLine1),
      'addressLine2': serializer.toJson<String?>(addressLine2),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'country': serializer.toJson<String>(country),
      'zipCode': serializer.toJson<String>(zipCode),
      'landmark': serializer.toJson<String?>(landmark),
      'isDefault': serializer.toJson<bool>(isDefault),
      'type': serializer.toJson<String>(type),
      'isSynced': serializer.toJson<bool>(isSynced),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  AddressesData copyWith(
          {String? id,
          String? userId,
          String? fullName,
          String? phoneNumber,
          String? addressLine1,
          Value<String?> addressLine2 = const Value.absent(),
          String? city,
          String? state,
          String? country,
          String? zipCode,
          Value<String?> landmark = const Value.absent(),
          bool? isDefault,
          String? type,
          bool? isSynced,
          DateTime? cachedAt}) =>
      AddressesData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2:
            addressLine2.present ? addressLine2.value : this.addressLine2,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        zipCode: zipCode ?? this.zipCode,
        landmark: landmark.present ? landmark.value : this.landmark,
        isDefault: isDefault ?? this.isDefault,
        type: type ?? this.type,
        isSynced: isSynced ?? this.isSynced,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  AddressesData copyWithCompanion(AddressesCompanion data) {
    return AddressesData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      addressLine1: data.addressLine1.present
          ? data.addressLine1.value
          : this.addressLine1,
      addressLine2: data.addressLine2.present
          ? data.addressLine2.value
          : this.addressLine2,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      country: data.country.present ? data.country.value : this.country,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
      landmark: data.landmark.present ? data.landmark.value : this.landmark,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      type: data.type.present ? data.type.value : this.type,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AddressesData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('zipCode: $zipCode, ')
          ..write('landmark: $landmark, ')
          ..write('isDefault: $isDefault, ')
          ..write('type: $type, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      fullName,
      phoneNumber,
      addressLine1,
      addressLine2,
      city,
      state,
      country,
      zipCode,
      landmark,
      isDefault,
      type,
      isSynced,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddressesData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fullName == this.fullName &&
          other.phoneNumber == this.phoneNumber &&
          other.addressLine1 == this.addressLine1 &&
          other.addressLine2 == this.addressLine2 &&
          other.city == this.city &&
          other.state == this.state &&
          other.country == this.country &&
          other.zipCode == this.zipCode &&
          other.landmark == this.landmark &&
          other.isDefault == this.isDefault &&
          other.type == this.type &&
          other.isSynced == this.isSynced &&
          other.cachedAt == this.cachedAt);
}

class AddressesCompanion extends UpdateCompanion<AddressesData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> fullName;
  final Value<String> phoneNumber;
  final Value<String> addressLine1;
  final Value<String?> addressLine2;
  final Value<String> city;
  final Value<String> state;
  final Value<String> country;
  final Value<String> zipCode;
  final Value<String?> landmark;
  final Value<bool> isDefault;
  final Value<String> type;
  final Value<bool> isSynced;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const AddressesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.landmark = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.type = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AddressesCompanion.insert({
    required String id,
    required String userId,
    required String fullName,
    required String phoneNumber,
    required String addressLine1,
    this.addressLine2 = const Value.absent(),
    required String city,
    required String state,
    required String country,
    required String zipCode,
    this.landmark = const Value.absent(),
    required bool isDefault,
    required String type,
    this.isSynced = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        fullName = Value(fullName),
        phoneNumber = Value(phoneNumber),
        addressLine1 = Value(addressLine1),
        city = Value(city),
        state = Value(state),
        country = Value(country),
        zipCode = Value(zipCode),
        isDefault = Value(isDefault),
        type = Value(type),
        cachedAt = Value(cachedAt);
  static Insertable<AddressesData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? fullName,
    Expression<String>? phoneNumber,
    Expression<String>? addressLine1,
    Expression<String>? addressLine2,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? country,
    Expression<String>? zipCode,
    Expression<String>? landmark,
    Expression<bool>? isDefault,
    Expression<String>? type,
    Expression<bool>? isSynced,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fullName != null) 'full_name': fullName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (addressLine1 != null) 'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (zipCode != null) 'zip_code': zipCode,
      if (landmark != null) 'landmark': landmark,
      if (isDefault != null) 'is_default': isDefault,
      if (type != null) 'type': type,
      if (isSynced != null) 'is_synced': isSynced,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AddressesCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? fullName,
      Value<String>? phoneNumber,
      Value<String>? addressLine1,
      Value<String?>? addressLine2,
      Value<String>? city,
      Value<String>? state,
      Value<String>? country,
      Value<String>? zipCode,
      Value<String?>? landmark,
      Value<bool>? isDefault,
      Value<String>? type,
      Value<bool>? isSynced,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return AddressesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      landmark: landmark ?? this.landmark,
      isDefault: isDefault ?? this.isDefault,
      type: type ?? this.type,
      isSynced: isSynced ?? this.isSynced,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (addressLine1.present) {
      map['address_line1'] = Variable<String>(addressLine1.value);
    }
    if (addressLine2.present) {
      map['address_line2'] = Variable<String>(addressLine2.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (landmark.present) {
      map['landmark'] = Variable<String>(landmark.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddressesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('zipCode: $zipCode, ')
          ..write('landmark: $landmark, ')
          ..write('isDefault: $isDefault, ')
          ..write('type: $type, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isVerifiedMeta =
      const VerificationMeta('isVerified');
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
      'is_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_verified" IN (0, 1))'));
  static const VerificationMeta _helpfulCountMeta =
      const VerificationMeta('helpfulCount');
  @override
  late final GeneratedColumn<int> helpfulCount = GeneratedColumn<int>(
      'helpful_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productId,
        userId,
        rating,
        title,
        comment,
        isVerified,
        helpfulCount,
        timestamp,
        isSynced,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reviews';
  @override
  VerificationContext validateIntegrity(Insertable<Review> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    if (data.containsKey('is_verified')) {
      context.handle(
          _isVerifiedMeta,
          isVerified.isAcceptableOrUnknown(
              data['is_verified']!, _isVerifiedMeta));
    } else if (isInserting) {
      context.missing(_isVerifiedMeta);
    }
    if (data.containsKey('helpful_count')) {
      context.handle(
          _helpfulCountMeta,
          helpfulCount.isAcceptableOrUnknown(
              data['helpful_count']!, _helpfulCountMeta));
    } else if (isInserting) {
      context.missing(_helpfulCountMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment'])!,
      isVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_verified'])!,
      helpfulCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}helpful_count'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }
}

class Review extends DataClass implements Insertable<Review> {
  final String id;
  final String productId;
  final String userId;
  final double rating;
  final String? title;
  final String comment;
  final bool isVerified;
  final int helpfulCount;
  final DateTime timestamp;
  final bool isSynced;
  final DateTime cachedAt;
  const Review(
      {required this.id,
      required this.productId,
      required this.userId,
      required this.rating,
      this.title,
      required this.comment,
      required this.isVerified,
      required this.helpfulCount,
      required this.timestamp,
      required this.isSynced,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['user_id'] = Variable<String>(userId);
    map['rating'] = Variable<double>(rating);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['comment'] = Variable<String>(comment);
    map['is_verified'] = Variable<bool>(isVerified);
    map['helpful_count'] = Variable<int>(helpfulCount);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['is_synced'] = Variable<bool>(isSynced);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      id: Value(id),
      productId: Value(productId),
      userId: Value(userId),
      rating: Value(rating),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      comment: Value(comment),
      isVerified: Value(isVerified),
      helpfulCount: Value(helpfulCount),
      timestamp: Value(timestamp),
      isSynced: Value(isSynced),
      cachedAt: Value(cachedAt),
    );
  }

  factory Review.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      userId: serializer.fromJson<String>(json['userId']),
      rating: serializer.fromJson<double>(json['rating']),
      title: serializer.fromJson<String?>(json['title']),
      comment: serializer.fromJson<String>(json['comment']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      helpfulCount: serializer.fromJson<int>(json['helpfulCount']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'userId': serializer.toJson<String>(userId),
      'rating': serializer.toJson<double>(rating),
      'title': serializer.toJson<String?>(title),
      'comment': serializer.toJson<String>(comment),
      'isVerified': serializer.toJson<bool>(isVerified),
      'helpfulCount': serializer.toJson<int>(helpfulCount),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'isSynced': serializer.toJson<bool>(isSynced),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Review copyWith(
          {String? id,
          String? productId,
          String? userId,
          double? rating,
          Value<String?> title = const Value.absent(),
          String? comment,
          bool? isVerified,
          int? helpfulCount,
          DateTime? timestamp,
          bool? isSynced,
          DateTime? cachedAt}) =>
      Review(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        userId: userId ?? this.userId,
        rating: rating ?? this.rating,
        title: title.present ? title.value : this.title,
        comment: comment ?? this.comment,
        isVerified: isVerified ?? this.isVerified,
        helpfulCount: helpfulCount ?? this.helpfulCount,
        timestamp: timestamp ?? this.timestamp,
        isSynced: isSynced ?? this.isSynced,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Review copyWithCompanion(ReviewsCompanion data) {
    return Review(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      userId: data.userId.present ? data.userId.value : this.userId,
      rating: data.rating.present ? data.rating.value : this.rating,
      title: data.title.present ? data.title.value : this.title,
      comment: data.comment.present ? data.comment.value : this.comment,
      isVerified:
          data.isVerified.present ? data.isVerified.value : this.isVerified,
      helpfulCount: data.helpfulCount.present
          ? data.helpfulCount.value
          : this.helpfulCount,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('userId: $userId, ')
          ..write('rating: $rating, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('isVerified: $isVerified, ')
          ..write('helpfulCount: $helpfulCount, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, userId, rating, title, comment,
      isVerified, helpfulCount, timestamp, isSynced, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.userId == this.userId &&
          other.rating == this.rating &&
          other.title == this.title &&
          other.comment == this.comment &&
          other.isVerified == this.isVerified &&
          other.helpfulCount == this.helpfulCount &&
          other.timestamp == this.timestamp &&
          other.isSynced == this.isSynced &&
          other.cachedAt == this.cachedAt);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> userId;
  final Value<double> rating;
  final Value<String?> title;
  final Value<String> comment;
  final Value<bool> isVerified;
  final Value<int> helpfulCount;
  final Value<DateTime> timestamp;
  final Value<bool> isSynced;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const ReviewsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.userId = const Value.absent(),
    this.rating = const Value.absent(),
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.helpfulCount = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewsCompanion.insert({
    required String id,
    required String productId,
    required String userId,
    required double rating,
    this.title = const Value.absent(),
    required String comment,
    required bool isVerified,
    required int helpfulCount,
    required DateTime timestamp,
    this.isSynced = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        userId = Value(userId),
        rating = Value(rating),
        comment = Value(comment),
        isVerified = Value(isVerified),
        helpfulCount = Value(helpfulCount),
        timestamp = Value(timestamp),
        cachedAt = Value(cachedAt);
  static Insertable<Review> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? userId,
    Expression<double>? rating,
    Expression<String>? title,
    Expression<String>? comment,
    Expression<bool>? isVerified,
    Expression<int>? helpfulCount,
    Expression<DateTime>? timestamp,
    Expression<bool>? isSynced,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (userId != null) 'user_id': userId,
      if (rating != null) 'rating': rating,
      if (title != null) 'title': title,
      if (comment != null) 'comment': comment,
      if (isVerified != null) 'is_verified': isVerified,
      if (helpfulCount != null) 'helpful_count': helpfulCount,
      if (timestamp != null) 'timestamp': timestamp,
      if (isSynced != null) 'is_synced': isSynced,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewsCompanion copyWith(
      {Value<String>? id,
      Value<String>? productId,
      Value<String>? userId,
      Value<double>? rating,
      Value<String?>? title,
      Value<String>? comment,
      Value<bool>? isVerified,
      Value<int>? helpfulCount,
      Value<DateTime>? timestamp,
      Value<bool>? isSynced,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return ReviewsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      isVerified: isVerified ?? this.isVerified,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (helpfulCount.present) {
      map['helpful_count'] = Variable<int>(helpfulCount.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('userId: $userId, ')
          ..write('rating: $rating, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('isVerified: $isVerified, ')
          ..write('helpfulCount: $helpfulCount, ')
          ..write('timestamp: $timestamp, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WishlistsTable extends Wishlists
    with TableInfo<$WishlistsTable, Wishlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productsMeta =
      const VerificationMeta('products');
  @override
  late final GeneratedColumn<String> products = GeneratedColumn<String>(
      'products', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isPrivateMeta =
      const VerificationMeta('isPrivate');
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
      'is_private', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_private" IN (0, 1))'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        type,
        products,
        createdAt,
        isPrivate,
        description,
        isSynced,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlists';
  @override
  VerificationContext validateIntegrity(Insertable<Wishlist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('products')) {
      context.handle(_productsMeta,
          products.isAcceptableOrUnknown(data['products']!, _productsMeta));
    } else if (isInserting) {
      context.missing(_productsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_private')) {
      context.handle(_isPrivateMeta,
          isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta));
    } else if (isInserting) {
      context.missing(_isPrivateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wishlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wishlist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      products: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}products'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isPrivate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_private'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $WishlistsTable createAlias(String alias) {
    return $WishlistsTable(attachedDatabase, alias);
  }
}

class Wishlist extends DataClass implements Insertable<Wishlist> {
  final String id;
  final String userId;
  final String name;
  final String type;
  final String products;
  final DateTime createdAt;
  final bool isPrivate;
  final String? description;
  final bool isSynced;
  final DateTime cachedAt;
  const Wishlist(
      {required this.id,
      required this.userId,
      required this.name,
      required this.type,
      required this.products,
      required this.createdAt,
      required this.isPrivate,
      this.description,
      required this.isSynced,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['products'] = Variable<String>(products);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_private'] = Variable<bool>(isPrivate);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  WishlistsCompanion toCompanion(bool nullToAbsent) {
    return WishlistsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      type: Value(type),
      products: Value(products),
      createdAt: Value(createdAt),
      isPrivate: Value(isPrivate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isSynced: Value(isSynced),
      cachedAt: Value(cachedAt),
    );
  }

  factory Wishlist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wishlist(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      products: serializer.fromJson<String>(json['products']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      description: serializer.fromJson<String?>(json['description']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'products': serializer.toJson<String>(products),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'description': serializer.toJson<String?>(description),
      'isSynced': serializer.toJson<bool>(isSynced),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Wishlist copyWith(
          {String? id,
          String? userId,
          String? name,
          String? type,
          String? products,
          DateTime? createdAt,
          bool? isPrivate,
          Value<String?> description = const Value.absent(),
          bool? isSynced,
          DateTime? cachedAt}) =>
      Wishlist(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        type: type ?? this.type,
        products: products ?? this.products,
        createdAt: createdAt ?? this.createdAt,
        isPrivate: isPrivate ?? this.isPrivate,
        description: description.present ? description.value : this.description,
        isSynced: isSynced ?? this.isSynced,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Wishlist copyWithCompanion(WishlistsCompanion data) {
    return Wishlist(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      products: data.products.present ? data.products.value : this.products,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      description:
          data.description.present ? data.description.value : this.description,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Wishlist(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('products: $products, ')
          ..write('createdAt: $createdAt, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('description: $description, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, type, products, createdAt,
      isPrivate, description, isSynced, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wishlist &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.type == this.type &&
          other.products == this.products &&
          other.createdAt == this.createdAt &&
          other.isPrivate == this.isPrivate &&
          other.description == this.description &&
          other.isSynced == this.isSynced &&
          other.cachedAt == this.cachedAt);
}

class WishlistsCompanion extends UpdateCompanion<Wishlist> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> type;
  final Value<String> products;
  final Value<DateTime> createdAt;
  final Value<bool> isPrivate;
  final Value<String?> description;
  final Value<bool> isSynced;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const WishlistsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.products = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.description = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishlistsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required String type,
    required String products,
    required DateTime createdAt,
    required bool isPrivate,
    this.description = const Value.absent(),
    this.isSynced = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        name = Value(name),
        type = Value(type),
        products = Value(products),
        createdAt = Value(createdAt),
        isPrivate = Value(isPrivate),
        cachedAt = Value(cachedAt);
  static Insertable<Wishlist> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? products,
    Expression<DateTime>? createdAt,
    Expression<bool>? isPrivate,
    Expression<String>? description,
    Expression<bool>? isSynced,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (products != null) 'products': products,
      if (createdAt != null) 'created_at': createdAt,
      if (isPrivate != null) 'is_private': isPrivate,
      if (description != null) 'description': description,
      if (isSynced != null) 'is_synced': isSynced,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishlistsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<String>? type,
      Value<String>? products,
      Value<DateTime>? createdAt,
      Value<bool>? isPrivate,
      Value<String?>? description,
      Value<bool>? isSynced,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return WishlistsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      isPrivate: isPrivate ?? this.isPrivate,
      description: description ?? this.description,
      isSynced: isSynced ?? this.isSynced,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (products.present) {
      map['products'] = Variable<String>(products.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('products: $products, ')
          ..write('createdAt: $createdAt, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('description: $description, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
      'is_read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'));
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actionUrlMeta =
      const VerificationMeta('actionUrl');
  @override
  late final GeneratedColumn<String> actionUrl = GeneratedColumn<String>(
      'action_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        message,
        type,
        timestamp,
        isRead,
        imageUrl,
        actionUrl,
        data,
        isSynced,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    } else if (isInserting) {
      context.missing(_isReadMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('action_url')) {
      context.handle(_actionUrlMeta,
          actionUrl.isAcceptableOrUnknown(data['action_url']!, _actionUrlMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      isRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      actionUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_url']),
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data']),
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String id;
  final String title;
  final String message;
  final String type;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;
  final String? actionUrl;
  final String? data;
  final bool isSynced;
  final DateTime cachedAt;
  const Notification(
      {required this.id,
      required this.title,
      required this.message,
      required this.type,
      required this.timestamp,
      required this.isRead,
      this.imageUrl,
      this.actionUrl,
      this.data,
      required this.isSynced,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['type'] = Variable<String>(type);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || actionUrl != null) {
      map['action_url'] = Variable<String>(actionUrl);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<String>(data);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      title: Value(title),
      message: Value(message),
      type: Value(type),
      timestamp: Value(timestamp),
      isRead: Value(isRead),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      actionUrl: actionUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(actionUrl),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      isSynced: Value(isSynced),
      cachedAt: Value(cachedAt),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      type: serializer.fromJson<String>(json['type']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      actionUrl: serializer.fromJson<String?>(json['actionUrl']),
      data: serializer.fromJson<String?>(json['data']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'type': serializer.toJson<String>(type),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'isRead': serializer.toJson<bool>(isRead),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'actionUrl': serializer.toJson<String?>(actionUrl),
      'data': serializer.toJson<String?>(data),
      'isSynced': serializer.toJson<bool>(isSynced),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Notification copyWith(
          {String? id,
          String? title,
          String? message,
          String? type,
          DateTime? timestamp,
          bool? isRead,
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> actionUrl = const Value.absent(),
          Value<String?> data = const Value.absent(),
          bool? isSynced,
          DateTime? cachedAt}) =>
      Notification(
        id: id ?? this.id,
        title: title ?? this.title,
        message: message ?? this.message,
        type: type ?? this.type,
        timestamp: timestamp ?? this.timestamp,
        isRead: isRead ?? this.isRead,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        actionUrl: actionUrl.present ? actionUrl.value : this.actionUrl,
        data: data.present ? data.value : this.data,
        isSynced: isSynced ?? this.isSynced,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      type: data.type.present ? data.type.value : this.type,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      actionUrl: data.actionUrl.present ? data.actionUrl.value : this.actionUrl,
      data: data.data.present ? data.data.value : this.data,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('isRead: $isRead, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('actionUrl: $actionUrl, ')
          ..write('data: $data, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, message, type, timestamp, isRead,
      imageUrl, actionUrl, data, isSynced, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.title == this.title &&
          other.message == this.message &&
          other.type == this.type &&
          other.timestamp == this.timestamp &&
          other.isRead == this.isRead &&
          other.imageUrl == this.imageUrl &&
          other.actionUrl == this.actionUrl &&
          other.data == this.data &&
          other.isSynced == this.isSynced &&
          other.cachedAt == this.cachedAt);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> message;
  final Value<String> type;
  final Value<DateTime> timestamp;
  final Value<bool> isRead;
  final Value<String?> imageUrl;
  final Value<String?> actionUrl;
  final Value<String?> data;
  final Value<bool> isSynced;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.type = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isRead = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.actionUrl = const Value.absent(),
    this.data = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    required String title,
    required String message,
    required String type,
    required DateTime timestamp,
    required bool isRead,
    this.imageUrl = const Value.absent(),
    this.actionUrl = const Value.absent(),
    this.data = const Value.absent(),
    this.isSynced = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        message = Value(message),
        type = Value(type),
        timestamp = Value(timestamp),
        isRead = Value(isRead),
        cachedAt = Value(cachedAt);
  static Insertable<Notification> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? message,
    Expression<String>? type,
    Expression<DateTime>? timestamp,
    Expression<bool>? isRead,
    Expression<String>? imageUrl,
    Expression<String>? actionUrl,
    Expression<String>? data,
    Expression<bool>? isSynced,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (type != null) 'type': type,
      if (timestamp != null) 'timestamp': timestamp,
      if (isRead != null) 'is_read': isRead,
      if (imageUrl != null) 'image_url': imageUrl,
      if (actionUrl != null) 'action_url': actionUrl,
      if (data != null) 'data': data,
      if (isSynced != null) 'is_synced': isSynced,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? message,
      Value<String>? type,
      Value<DateTime>? timestamp,
      Value<bool>? isRead,
      Value<String?>? imageUrl,
      Value<String?>? actionUrl,
      Value<String?>? data,
      Value<bool>? isSynced,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return NotificationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
      data: data ?? this.data,
      isSynced: isSynced ?? this.isSynced,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (actionUrl.present) {
      map['action_url'] = Variable<String>(actionUrl.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('isRead: $isRead, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('actionUrl: $actionUrl, ')
          ..write('data: $data, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nextDeliveryDateMeta =
      const VerificationMeta('nextDeliveryDate');
  @override
  late final GeneratedColumn<DateTime> nextDeliveryDate =
      GeneratedColumn<DateTime>('next_delivery_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _totalOrdersMeta =
      const VerificationMeta('totalOrders');
  @override
  late final GeneratedColumn<int> totalOrders = GeneratedColumn<int>(
      'total_orders', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        productId,
        quantity,
        frequency,
        price,
        status,
        startDate,
        nextDeliveryDate,
        endDate,
        totalOrders,
        isSynced,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(Insertable<Subscription> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('next_delivery_date')) {
      context.handle(
          _nextDeliveryDateMeta,
          nextDeliveryDate.isAcceptableOrUnknown(
              data['next_delivery_date']!, _nextDeliveryDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('total_orders')) {
      context.handle(
          _totalOrdersMeta,
          totalOrders.isAcceptableOrUnknown(
              data['total_orders']!, _totalOrdersMeta));
    } else if (isInserting) {
      context.missing(_totalOrdersMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      nextDeliveryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_delivery_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      totalOrders: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_orders'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final String id;
  final String userId;
  final String productId;
  final int quantity;
  final String frequency;
  final double price;
  final String status;
  final DateTime startDate;
  final DateTime? nextDeliveryDate;
  final DateTime? endDate;
  final int totalOrders;
  final bool isSynced;
  final DateTime cachedAt;
  const Subscription(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.quantity,
      required this.frequency,
      required this.price,
      required this.status,
      required this.startDate,
      this.nextDeliveryDate,
      this.endDate,
      required this.totalOrders,
      required this.isSynced,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['product_id'] = Variable<String>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['frequency'] = Variable<String>(frequency);
    map['price'] = Variable<double>(price);
    map['status'] = Variable<String>(status);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || nextDeliveryDate != null) {
      map['next_delivery_date'] = Variable<DateTime>(nextDeliveryDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['total_orders'] = Variable<int>(totalOrders);
    map['is_synced'] = Variable<bool>(isSynced);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      id: Value(id),
      userId: Value(userId),
      productId: Value(productId),
      quantity: Value(quantity),
      frequency: Value(frequency),
      price: Value(price),
      status: Value(status),
      startDate: Value(startDate),
      nextDeliveryDate: nextDeliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDeliveryDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      totalOrders: Value(totalOrders),
      isSynced: Value(isSynced),
      cachedAt: Value(cachedAt),
    );
  }

  factory Subscription.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      productId: serializer.fromJson<String>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      frequency: serializer.fromJson<String>(json['frequency']),
      price: serializer.fromJson<double>(json['price']),
      status: serializer.fromJson<String>(json['status']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      nextDeliveryDate:
          serializer.fromJson<DateTime?>(json['nextDeliveryDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      totalOrders: serializer.fromJson<int>(json['totalOrders']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'productId': serializer.toJson<String>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'frequency': serializer.toJson<String>(frequency),
      'price': serializer.toJson<double>(price),
      'status': serializer.toJson<String>(status),
      'startDate': serializer.toJson<DateTime>(startDate),
      'nextDeliveryDate': serializer.toJson<DateTime?>(nextDeliveryDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'totalOrders': serializer.toJson<int>(totalOrders),
      'isSynced': serializer.toJson<bool>(isSynced),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Subscription copyWith(
          {String? id,
          String? userId,
          String? productId,
          int? quantity,
          String? frequency,
          double? price,
          String? status,
          DateTime? startDate,
          Value<DateTime?> nextDeliveryDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          int? totalOrders,
          bool? isSynced,
          DateTime? cachedAt}) =>
      Subscription(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        frequency: frequency ?? this.frequency,
        price: price ?? this.price,
        status: status ?? this.status,
        startDate: startDate ?? this.startDate,
        nextDeliveryDate: nextDeliveryDate.present
            ? nextDeliveryDate.value
            : this.nextDeliveryDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        totalOrders: totalOrders ?? this.totalOrders,
        isSynced: isSynced ?? this.isSynced,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      price: data.price.present ? data.price.value : this.price,
      status: data.status.present ? data.status.value : this.status,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      nextDeliveryDate: data.nextDeliveryDate.present
          ? data.nextDeliveryDate.value
          : this.nextDeliveryDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      totalOrders:
          data.totalOrders.present ? data.totalOrders.value : this.totalOrders,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('frequency: $frequency, ')
          ..write('price: $price, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('nextDeliveryDate: $nextDeliveryDate, ')
          ..write('endDate: $endDate, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      productId,
      quantity,
      frequency,
      price,
      status,
      startDate,
      nextDeliveryDate,
      endDate,
      totalOrders,
      isSynced,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.frequency == this.frequency &&
          other.price == this.price &&
          other.status == this.status &&
          other.startDate == this.startDate &&
          other.nextDeliveryDate == this.nextDeliveryDate &&
          other.endDate == this.endDate &&
          other.totalOrders == this.totalOrders &&
          other.isSynced == this.isSynced &&
          other.cachedAt == this.cachedAt);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> productId;
  final Value<int> quantity;
  final Value<String> frequency;
  final Value<double> price;
  final Value<String> status;
  final Value<DateTime> startDate;
  final Value<DateTime?> nextDeliveryDate;
  final Value<DateTime?> endDate;
  final Value<int> totalOrders;
  final Value<bool> isSynced;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const SubscriptionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.frequency = const Value.absent(),
    this.price = const Value.absent(),
    this.status = const Value.absent(),
    this.startDate = const Value.absent(),
    this.nextDeliveryDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.totalOrders = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    required String id,
    required String userId,
    required String productId,
    required int quantity,
    required String frequency,
    required double price,
    required String status,
    required DateTime startDate,
    this.nextDeliveryDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required int totalOrders,
    this.isSynced = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        productId = Value(productId),
        quantity = Value(quantity),
        frequency = Value(frequency),
        price = Value(price),
        status = Value(status),
        startDate = Value(startDate),
        totalOrders = Value(totalOrders),
        cachedAt = Value(cachedAt);
  static Insertable<Subscription> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? productId,
    Expression<int>? quantity,
    Expression<String>? frequency,
    Expression<double>? price,
    Expression<String>? status,
    Expression<DateTime>? startDate,
    Expression<DateTime>? nextDeliveryDate,
    Expression<DateTime>? endDate,
    Expression<int>? totalOrders,
    Expression<bool>? isSynced,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (frequency != null) 'frequency': frequency,
      if (price != null) 'price': price,
      if (status != null) 'status': status,
      if (startDate != null) 'start_date': startDate,
      if (nextDeliveryDate != null) 'next_delivery_date': nextDeliveryDate,
      if (endDate != null) 'end_date': endDate,
      if (totalOrders != null) 'total_orders': totalOrders,
      if (isSynced != null) 'is_synced': isSynced,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubscriptionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? productId,
      Value<int>? quantity,
      Value<String>? frequency,
      Value<double>? price,
      Value<String>? status,
      Value<DateTime>? startDate,
      Value<DateTime?>? nextDeliveryDate,
      Value<DateTime?>? endDate,
      Value<int>? totalOrders,
      Value<bool>? isSynced,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return SubscriptionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      frequency: frequency ?? this.frequency,
      price: price ?? this.price,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      nextDeliveryDate: nextDeliveryDate ?? this.nextDeliveryDate,
      endDate: endDate ?? this.endDate,
      totalOrders: totalOrders ?? this.totalOrders,
      isSynced: isSynced ?? this.isSynced,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (nextDeliveryDate.present) {
      map['next_delivery_date'] = Variable<DateTime>(nextDeliveryDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (totalOrders.present) {
      map['total_orders'] = Variable<int>(totalOrders.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('frequency: $frequency, ')
          ..write('price: $price, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('nextDeliveryDate: $nextDeliveryDate, ')
          ..write('endDate: $endDate, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('isSynced: $isSynced, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CouponsTable extends Coupons with TableInfo<$CouponsTable, Coupon> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CouponsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _discountTypeMeta =
      const VerificationMeta('discountType');
  @override
  late final GeneratedColumn<String> discountType = GeneratedColumn<String>(
      'discount_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _discountValueMeta =
      const VerificationMeta('discountValue');
  @override
  late final GeneratedColumn<double> discountValue = GeneratedColumn<double>(
      'discount_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _minPurchaseMeta =
      const VerificationMeta('minPurchase');
  @override
  late final GeneratedColumn<double> minPurchase = GeneratedColumn<double>(
      'min_purchase', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _maxDiscountMeta =
      const VerificationMeta('maxDiscount');
  @override
  late final GeneratedColumn<double> maxDiscount = GeneratedColumn<double>(
      'max_discount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _expiryDateMeta =
      const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
      'expiry_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _usageLimitMeta =
      const VerificationMeta('usageLimit');
  @override
  late final GeneratedColumn<int> usageLimit = GeneratedColumn<int>(
      'usage_limit', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        code,
        title,
        description,
        discountType,
        discountValue,
        minPurchase,
        maxDiscount,
        expiryDate,
        isActive,
        usageLimit,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coupons';
  @override
  VerificationContext validateIntegrity(Insertable<Coupon> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('discount_type')) {
      context.handle(
          _discountTypeMeta,
          discountType.isAcceptableOrUnknown(
              data['discount_type']!, _discountTypeMeta));
    } else if (isInserting) {
      context.missing(_discountTypeMeta);
    }
    if (data.containsKey('discount_value')) {
      context.handle(
          _discountValueMeta,
          discountValue.isAcceptableOrUnknown(
              data['discount_value']!, _discountValueMeta));
    } else if (isInserting) {
      context.missing(_discountValueMeta);
    }
    if (data.containsKey('min_purchase')) {
      context.handle(
          _minPurchaseMeta,
          minPurchase.isAcceptableOrUnknown(
              data['min_purchase']!, _minPurchaseMeta));
    }
    if (data.containsKey('max_discount')) {
      context.handle(
          _maxDiscountMeta,
          maxDiscount.isAcceptableOrUnknown(
              data['max_discount']!, _maxDiscountMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
          _expiryDateMeta,
          expiryDate.isAcceptableOrUnknown(
              data['expiry_date']!, _expiryDateMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('usage_limit')) {
      context.handle(
          _usageLimitMeta,
          usageLimit.isAcceptableOrUnknown(
              data['usage_limit']!, _usageLimitMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Coupon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Coupon(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      discountType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}discount_type'])!,
      discountValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount_value'])!,
      minPurchase: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_purchase']),
      maxDiscount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_discount']),
      expiryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expiry_date']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      usageLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usage_limit']),
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CouponsTable createAlias(String alias) {
    return $CouponsTable(attachedDatabase, alias);
  }
}

class Coupon extends DataClass implements Insertable<Coupon> {
  final String id;
  final String code;
  final String title;
  final String description;
  final String discountType;
  final double discountValue;
  final double? minPurchase;
  final double? maxDiscount;
  final DateTime? expiryDate;
  final bool isActive;
  final int? usageLimit;
  final DateTime cachedAt;
  const Coupon(
      {required this.id,
      required this.code,
      required this.title,
      required this.description,
      required this.discountType,
      required this.discountValue,
      this.minPurchase,
      this.maxDiscount,
      this.expiryDate,
      required this.isActive,
      this.usageLimit,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['discount_type'] = Variable<String>(discountType);
    map['discount_value'] = Variable<double>(discountValue);
    if (!nullToAbsent || minPurchase != null) {
      map['min_purchase'] = Variable<double>(minPurchase);
    }
    if (!nullToAbsent || maxDiscount != null) {
      map['max_discount'] = Variable<double>(maxDiscount);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || usageLimit != null) {
      map['usage_limit'] = Variable<int>(usageLimit);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CouponsCompanion toCompanion(bool nullToAbsent) {
    return CouponsCompanion(
      id: Value(id),
      code: Value(code),
      title: Value(title),
      description: Value(description),
      discountType: Value(discountType),
      discountValue: Value(discountValue),
      minPurchase: minPurchase == null && nullToAbsent
          ? const Value.absent()
          : Value(minPurchase),
      maxDiscount: maxDiscount == null && nullToAbsent
          ? const Value.absent()
          : Value(maxDiscount),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      isActive: Value(isActive),
      usageLimit: usageLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(usageLimit),
      cachedAt: Value(cachedAt),
    );
  }

  factory Coupon.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Coupon(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      discountType: serializer.fromJson<String>(json['discountType']),
      discountValue: serializer.fromJson<double>(json['discountValue']),
      minPurchase: serializer.fromJson<double?>(json['minPurchase']),
      maxDiscount: serializer.fromJson<double?>(json['maxDiscount']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      usageLimit: serializer.fromJson<int?>(json['usageLimit']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'discountType': serializer.toJson<String>(discountType),
      'discountValue': serializer.toJson<double>(discountValue),
      'minPurchase': serializer.toJson<double?>(minPurchase),
      'maxDiscount': serializer.toJson<double?>(maxDiscount),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'isActive': serializer.toJson<bool>(isActive),
      'usageLimit': serializer.toJson<int?>(usageLimit),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Coupon copyWith(
          {String? id,
          String? code,
          String? title,
          String? description,
          String? discountType,
          double? discountValue,
          Value<double?> minPurchase = const Value.absent(),
          Value<double?> maxDiscount = const Value.absent(),
          Value<DateTime?> expiryDate = const Value.absent(),
          bool? isActive,
          Value<int?> usageLimit = const Value.absent(),
          DateTime? cachedAt}) =>
      Coupon(
        id: id ?? this.id,
        code: code ?? this.code,
        title: title ?? this.title,
        description: description ?? this.description,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        minPurchase: minPurchase.present ? minPurchase.value : this.minPurchase,
        maxDiscount: maxDiscount.present ? maxDiscount.value : this.maxDiscount,
        expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
        isActive: isActive ?? this.isActive,
        usageLimit: usageLimit.present ? usageLimit.value : this.usageLimit,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  Coupon copyWithCompanion(CouponsCompanion data) {
    return Coupon(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      discountType: data.discountType.present
          ? data.discountType.value
          : this.discountType,
      discountValue: data.discountValue.present
          ? data.discountValue.value
          : this.discountValue,
      minPurchase:
          data.minPurchase.present ? data.minPurchase.value : this.minPurchase,
      maxDiscount:
          data.maxDiscount.present ? data.maxDiscount.value : this.maxDiscount,
      expiryDate:
          data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      usageLimit:
          data.usageLimit.present ? data.usageLimit.value : this.usageLimit,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Coupon(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('discountType: $discountType, ')
          ..write('discountValue: $discountValue, ')
          ..write('minPurchase: $minPurchase, ')
          ..write('maxDiscount: $maxDiscount, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('isActive: $isActive, ')
          ..write('usageLimit: $usageLimit, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      code,
      title,
      description,
      discountType,
      discountValue,
      minPurchase,
      maxDiscount,
      expiryDate,
      isActive,
      usageLimit,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Coupon &&
          other.id == this.id &&
          other.code == this.code &&
          other.title == this.title &&
          other.description == this.description &&
          other.discountType == this.discountType &&
          other.discountValue == this.discountValue &&
          other.minPurchase == this.minPurchase &&
          other.maxDiscount == this.maxDiscount &&
          other.expiryDate == this.expiryDate &&
          other.isActive == this.isActive &&
          other.usageLimit == this.usageLimit &&
          other.cachedAt == this.cachedAt);
}

class CouponsCompanion extends UpdateCompanion<Coupon> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> title;
  final Value<String> description;
  final Value<String> discountType;
  final Value<double> discountValue;
  final Value<double?> minPurchase;
  final Value<double?> maxDiscount;
  final Value<DateTime?> expiryDate;
  final Value<bool> isActive;
  final Value<int?> usageLimit;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CouponsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.discountType = const Value.absent(),
    this.discountValue = const Value.absent(),
    this.minPurchase = const Value.absent(),
    this.maxDiscount = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.usageLimit = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CouponsCompanion.insert({
    required String id,
    required String code,
    required String title,
    required String description,
    required String discountType,
    required double discountValue,
    this.minPurchase = const Value.absent(),
    this.maxDiscount = const Value.absent(),
    this.expiryDate = const Value.absent(),
    required bool isActive,
    this.usageLimit = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        code = Value(code),
        title = Value(title),
        description = Value(description),
        discountType = Value(discountType),
        discountValue = Value(discountValue),
        isActive = Value(isActive),
        cachedAt = Value(cachedAt);
  static Insertable<Coupon> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? discountType,
    Expression<double>? discountValue,
    Expression<double>? minPurchase,
    Expression<double>? maxDiscount,
    Expression<DateTime>? expiryDate,
    Expression<bool>? isActive,
    Expression<int>? usageLimit,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (discountType != null) 'discount_type': discountType,
      if (discountValue != null) 'discount_value': discountValue,
      if (minPurchase != null) 'min_purchase': minPurchase,
      if (maxDiscount != null) 'max_discount': maxDiscount,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (isActive != null) 'is_active': isActive,
      if (usageLimit != null) 'usage_limit': usageLimit,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CouponsCompanion copyWith(
      {Value<String>? id,
      Value<String>? code,
      Value<String>? title,
      Value<String>? description,
      Value<String>? discountType,
      Value<double>? discountValue,
      Value<double?>? minPurchase,
      Value<double?>? maxDiscount,
      Value<DateTime?>? expiryDate,
      Value<bool>? isActive,
      Value<int?>? usageLimit,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CouponsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      minPurchase: minPurchase ?? this.minPurchase,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      expiryDate: expiryDate ?? this.expiryDate,
      isActive: isActive ?? this.isActive,
      usageLimit: usageLimit ?? this.usageLimit,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (discountType.present) {
      map['discount_type'] = Variable<String>(discountType.value);
    }
    if (discountValue.present) {
      map['discount_value'] = Variable<double>(discountValue.value);
    }
    if (minPurchase.present) {
      map['min_purchase'] = Variable<double>(minPurchase.value);
    }
    if (maxDiscount.present) {
      map['max_discount'] = Variable<double>(maxDiscount.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (usageLimit.present) {
      map['usage_limit'] = Variable<int>(usageLimit.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CouponsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('discountType: $discountType, ')
          ..write('discountValue: $discountValue, ')
          ..write('minPurchase: $minPurchase, ')
          ..write('maxDiscount: $maxDiscount, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('isActive: $isActive, ')
          ..write('usageLimit: $usageLimit, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingOperationsTable extends PendingOperations
    with TableInfo<$PendingOperationsTable, PendingOperation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingOperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _operationTypeMeta =
      const VerificationMeta('operationType');
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
      'operation_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endpointMeta =
      const VerificationMeta('endpoint');
  @override
  late final GeneratedColumn<String> endpoint = GeneratedColumn<String>(
      'endpoint', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        operationType,
        entityType,
        entityId,
        endpoint,
        method,
        payload,
        status,
        retryCount,
        createdAt,
        lastAttemptAt,
        errorMessage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_operations';
  @override
  VerificationContext validateIntegrity(Insertable<PendingOperation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation_type')) {
      context.handle(
          _operationTypeMeta,
          operationType.isAcceptableOrUnknown(
              data['operation_type']!, _operationTypeMeta));
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('endpoint')) {
      context.handle(_endpointMeta,
          endpoint.isAcceptableOrUnknown(data['endpoint']!, _endpointMeta));
    } else if (isInserting) {
      context.missing(_endpointMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingOperation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingOperation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      operationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation_type'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      endpoint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endpoint'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
    );
  }

  @override
  $PendingOperationsTable createAlias(String alias) {
    return $PendingOperationsTable(attachedDatabase, alias);
  }
}

class PendingOperation extends DataClass
    implements Insertable<PendingOperation> {
  final int id;
  final String operationType;
  final String entityType;
  final String entityId;
  final String endpoint;
  final String method;
  final String payload;
  final String status;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final String? errorMessage;
  const PendingOperation(
      {required this.id,
      required this.operationType,
      required this.entityType,
      required this.entityId,
      required this.endpoint,
      required this.method,
      required this.payload,
      required this.status,
      required this.retryCount,
      required this.createdAt,
      this.lastAttemptAt,
      this.errorMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation_type'] = Variable<String>(operationType);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['endpoint'] = Variable<String>(endpoint);
    map['method'] = Variable<String>(method);
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  PendingOperationsCompanion toCompanion(bool nullToAbsent) {
    return PendingOperationsCompanion(
      id: Value(id),
      operationType: Value(operationType),
      entityType: Value(entityType),
      entityId: Value(entityId),
      endpoint: Value(endpoint),
      method: Value(method),
      payload: Value(payload),
      status: Value(status),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory PendingOperation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingOperation(
      id: serializer.fromJson<int>(json['id']),
      operationType: serializer.fromJson<String>(json['operationType']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      endpoint: serializer.fromJson<String>(json['endpoint']),
      method: serializer.fromJson<String>(json['method']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operationType': serializer.toJson<String>(operationType),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'endpoint': serializer.toJson<String>(endpoint),
      'method': serializer.toJson<String>(method),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  PendingOperation copyWith(
          {int? id,
          String? operationType,
          String? entityType,
          String? entityId,
          String? endpoint,
          String? method,
          String? payload,
          String? status,
          int? retryCount,
          DateTime? createdAt,
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          Value<String?> errorMessage = const Value.absent()}) =>
      PendingOperation(
        id: id ?? this.id,
        operationType: operationType ?? this.operationType,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        endpoint: endpoint ?? this.endpoint,
        method: method ?? this.method,
        payload: payload ?? this.payload,
        status: status ?? this.status,
        retryCount: retryCount ?? this.retryCount,
        createdAt: createdAt ?? this.createdAt,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
      );
  PendingOperation copyWithCompanion(PendingOperationsCompanion data) {
    return PendingOperation(
      id: data.id.present ? data.id.value : this.id,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      endpoint: data.endpoint.present ? data.endpoint.value : this.endpoint,
      method: data.method.present ? data.method.value : this.method,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperation(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      operationType,
      entityType,
      entityId,
      endpoint,
      method,
      payload,
      status,
      retryCount,
      createdAt,
      lastAttemptAt,
      errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingOperation &&
          other.id == this.id &&
          other.operationType == this.operationType &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.endpoint == this.endpoint &&
          other.method == this.method &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.errorMessage == this.errorMessage);
}

class PendingOperationsCompanion extends UpdateCompanion<PendingOperation> {
  final Value<int> id;
  final Value<String> operationType;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> endpoint;
  final Value<String> method;
  final Value<String> payload;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<String?> errorMessage;
  const PendingOperationsCompanion({
    this.id = const Value.absent(),
    this.operationType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.endpoint = const Value.absent(),
    this.method = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  });
  PendingOperationsCompanion.insert({
    this.id = const Value.absent(),
    required String operationType,
    required String entityType,
    required String entityId,
    required String endpoint,
    required String method,
    required String payload,
    required String status,
    this.retryCount = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  })  : operationType = Value(operationType),
        entityType = Value(entityType),
        entityId = Value(entityId),
        endpoint = Value(endpoint),
        method = Value(method),
        payload = Value(payload),
        status = Value(status),
        createdAt = Value(createdAt);
  static Insertable<PendingOperation> custom({
    Expression<int>? id,
    Expression<String>? operationType,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? endpoint,
    Expression<String>? method,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<String>? errorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operationType != null) 'operation_type': operationType,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }

  PendingOperationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? operationType,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? endpoint,
      Value<String>? method,
      Value<String>? payload,
      Value<String>? status,
      Value<int>? retryCount,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastAttemptAt,
      Value<String?>? errorMessage}) {
    return PendingOperationsCompanion(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (endpoint.present) {
      map['endpoint'] = Variable<String>(endpoint.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationsCompanion(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }
}

class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productDataMeta =
      const VerificationMeta('productData');
  @override
  late final GeneratedColumn<String> productData = GeneratedColumn<String>(
      'product_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _selectedSizeMeta =
      const VerificationMeta('selectedSize');
  @override
  late final GeneratedColumn<String> selectedSize = GeneratedColumn<String>(
      'selected_size', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _selectedColorMeta =
      const VerificationMeta('selectedColor');
  @override
  late final GeneratedColumn<String> selectedColor = GeneratedColumn<String>(
      'selected_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productId,
        productData,
        quantity,
        selectedSize,
        selectedColor,
        addedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(Insertable<CartItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_data')) {
      context.handle(
          _productDataMeta,
          productData.isAcceptableOrUnknown(
              data['product_data']!, _productDataMeta));
    } else if (isInserting) {
      context.missing(_productDataMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('selected_size')) {
      context.handle(
          _selectedSizeMeta,
          selectedSize.isAcceptableOrUnknown(
              data['selected_size']!, _selectedSizeMeta));
    }
    if (data.containsKey('selected_color')) {
      context.handle(
          _selectedColorMeta,
          selectedColor.isAcceptableOrUnknown(
              data['selected_color']!, _selectedColorMeta));
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      productData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_data'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      selectedSize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_size']),
      selectedColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_color']),
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(attachedDatabase, alias);
  }
}

class CartItem extends DataClass implements Insertable<CartItem> {
  final int id;
  final String productId;
  final String productData;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final DateTime addedAt;
  const CartItem(
      {required this.id,
      required this.productId,
      required this.productData,
      required this.quantity,
      this.selectedSize,
      this.selectedColor,
      required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<String>(productId);
    map['product_data'] = Variable<String>(productData);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || selectedSize != null) {
      map['selected_size'] = Variable<String>(selectedSize);
    }
    if (!nullToAbsent || selectedColor != null) {
      map['selected_color'] = Variable<String>(selectedColor);
    }
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(
      id: Value(id),
      productId: Value(productId),
      productData: Value(productData),
      quantity: Value(quantity),
      selectedSize: selectedSize == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedSize),
      selectedColor: selectedColor == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedColor),
      addedAt: Value(addedAt),
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItem(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      productData: serializer.fromJson<String>(json['productData']),
      quantity: serializer.fromJson<int>(json['quantity']),
      selectedSize: serializer.fromJson<String?>(json['selectedSize']),
      selectedColor: serializer.fromJson<String?>(json['selectedColor']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<String>(productId),
      'productData': serializer.toJson<String>(productData),
      'quantity': serializer.toJson<int>(quantity),
      'selectedSize': serializer.toJson<String?>(selectedSize),
      'selectedColor': serializer.toJson<String?>(selectedColor),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  CartItem copyWith(
          {int? id,
          String? productId,
          String? productData,
          int? quantity,
          Value<String?> selectedSize = const Value.absent(),
          Value<String?> selectedColor = const Value.absent(),
          DateTime? addedAt}) =>
      CartItem(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productData: productData ?? this.productData,
        quantity: quantity ?? this.quantity,
        selectedSize:
            selectedSize.present ? selectedSize.value : this.selectedSize,
        selectedColor:
            selectedColor.present ? selectedColor.value : this.selectedColor,
        addedAt: addedAt ?? this.addedAt,
      );
  CartItem copyWithCompanion(CartItemsCompanion data) {
    return CartItem(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      productData:
          data.productData.present ? data.productData.value : this.productData,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      selectedSize: data.selectedSize.present
          ? data.selectedSize.value
          : this.selectedSize,
      selectedColor: data.selectedColor.present
          ? data.selectedColor.value
          : this.selectedColor,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItem(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('quantity: $quantity, ')
          ..write('selectedSize: $selectedSize, ')
          ..write('selectedColor: $selectedColor, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, productData, quantity,
      selectedSize, selectedColor, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.productData == this.productData &&
          other.quantity == this.quantity &&
          other.selectedSize == this.selectedSize &&
          other.selectedColor == this.selectedColor &&
          other.addedAt == this.addedAt);
}

class CartItemsCompanion extends UpdateCompanion<CartItem> {
  final Value<int> id;
  final Value<String> productId;
  final Value<String> productData;
  final Value<int> quantity;
  final Value<String?> selectedSize;
  final Value<String?> selectedColor;
  final Value<DateTime> addedAt;
  const CartItemsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productData = const Value.absent(),
    this.quantity = const Value.absent(),
    this.selectedSize = const Value.absent(),
    this.selectedColor = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  CartItemsCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    required String productData,
    required int quantity,
    this.selectedSize = const Value.absent(),
    this.selectedColor = const Value.absent(),
    required DateTime addedAt,
  })  : productId = Value(productId),
        productData = Value(productData),
        quantity = Value(quantity),
        addedAt = Value(addedAt);
  static Insertable<CartItem> custom({
    Expression<int>? id,
    Expression<String>? productId,
    Expression<String>? productData,
    Expression<int>? quantity,
    Expression<String>? selectedSize,
    Expression<String>? selectedColor,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (productData != null) 'product_data': productData,
      if (quantity != null) 'quantity': quantity,
      if (selectedSize != null) 'selected_size': selectedSize,
      if (selectedColor != null) 'selected_color': selectedColor,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  CartItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? productId,
      Value<String>? productData,
      Value<int>? quantity,
      Value<String?>? selectedSize,
      Value<String?>? selectedColor,
      Value<DateTime>? addedAt}) {
    return CartItemsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productData: productData ?? this.productData,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productData.present) {
      map['product_data'] = Variable<String>(productData.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (selectedSize.present) {
      map['selected_size'] = Variable<String>(selectedSize.value);
    }
    if (selectedColor.present) {
      map['selected_color'] = Variable<String>(selectedColor.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('quantity: $quantity, ')
          ..write('selectedSize: $selectedSize, ')
          ..write('selectedColor: $selectedColor, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productDataMeta =
      const VerificationMeta('productData');
  @override
  late final GeneratedColumn<String> productData = GeneratedColumn<String>(
      'product_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [productId, productData, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_data')) {
      context.handle(
          _productDataMeta,
          productData.isAcceptableOrUnknown(
              data['product_data']!, _productDataMeta));
    } else if (isInserting) {
      context.missing(_productDataMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      productData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_data'])!,
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final String productId;
  final String productData;
  final DateTime addedAt;
  const Favorite(
      {required this.productId,
      required this.productData,
      required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['product_data'] = Variable<String>(productData);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      productId: Value(productId),
      productData: Value(productData),
      addedAt: Value(addedAt),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      productId: serializer.fromJson<String>(json['productId']),
      productData: serializer.fromJson<String>(json['productData']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'productData': serializer.toJson<String>(productData),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  Favorite copyWith(
          {String? productId, String? productData, DateTime? addedAt}) =>
      Favorite(
        productId: productId ?? this.productId,
        productData: productData ?? this.productData,
        addedAt: addedAt ?? this.addedAt,
      );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      productId: data.productId.present ? data.productId.value : this.productId,
      productData:
          data.productData.present ? data.productData.value : this.productData,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, productData, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.productId == this.productId &&
          other.productData == this.productData &&
          other.addedAt == this.addedAt);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<String> productId;
  final Value<String> productData;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const FavoritesCompanion({
    this.productId = const Value.absent(),
    this.productData = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritesCompanion.insert({
    required String productId,
    required String productData,
    required DateTime addedAt,
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        productData = Value(productData),
        addedAt = Value(addedAt);
  static Insertable<Favorite> custom({
    Expression<String>? productId,
    Expression<String>? productData,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (productData != null) 'product_data': productData,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritesCompanion copyWith(
      {Value<String>? productId,
      Value<String>? productData,
      Value<DateTime>? addedAt,
      Value<int>? rowid}) {
    return FavoritesCompanion(
      productId: productId ?? this.productId,
      productData: productData ?? this.productData,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productData.present) {
      map['product_data'] = Variable<String>(productData.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecentlyViewedTable extends RecentlyViewed
    with TableInfo<$RecentlyViewedTable, RecentlyViewedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentlyViewedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productDataMeta =
      const VerificationMeta('productData');
  @override
  late final GeneratedColumn<String> productData = GeneratedColumn<String>(
      'product_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _viewedAtMeta =
      const VerificationMeta('viewedAt');
  @override
  late final GeneratedColumn<DateTime> viewedAt = GeneratedColumn<DateTime>(
      'viewed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [productId, productData, viewedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recently_viewed';
  @override
  VerificationContext validateIntegrity(Insertable<RecentlyViewedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_data')) {
      context.handle(
          _productDataMeta,
          productData.isAcceptableOrUnknown(
              data['product_data']!, _productDataMeta));
    } else if (isInserting) {
      context.missing(_productDataMeta);
    }
    if (data.containsKey('viewed_at')) {
      context.handle(_viewedAtMeta,
          viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta));
    } else if (isInserting) {
      context.missing(_viewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  RecentlyViewedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentlyViewedData(
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      productData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_data'])!,
      viewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}viewed_at'])!,
    );
  }

  @override
  $RecentlyViewedTable createAlias(String alias) {
    return $RecentlyViewedTable(attachedDatabase, alias);
  }
}

class RecentlyViewedData extends DataClass
    implements Insertable<RecentlyViewedData> {
  final String productId;
  final String productData;
  final DateTime viewedAt;
  const RecentlyViewedData(
      {required this.productId,
      required this.productData,
      required this.viewedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['product_data'] = Variable<String>(productData);
    map['viewed_at'] = Variable<DateTime>(viewedAt);
    return map;
  }

  RecentlyViewedCompanion toCompanion(bool nullToAbsent) {
    return RecentlyViewedCompanion(
      productId: Value(productId),
      productData: Value(productData),
      viewedAt: Value(viewedAt),
    );
  }

  factory RecentlyViewedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentlyViewedData(
      productId: serializer.fromJson<String>(json['productId']),
      productData: serializer.fromJson<String>(json['productData']),
      viewedAt: serializer.fromJson<DateTime>(json['viewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'productData': serializer.toJson<String>(productData),
      'viewedAt': serializer.toJson<DateTime>(viewedAt),
    };
  }

  RecentlyViewedData copyWith(
          {String? productId, String? productData, DateTime? viewedAt}) =>
      RecentlyViewedData(
        productId: productId ?? this.productId,
        productData: productData ?? this.productData,
        viewedAt: viewedAt ?? this.viewedAt,
      );
  RecentlyViewedData copyWithCompanion(RecentlyViewedCompanion data) {
    return RecentlyViewedData(
      productId: data.productId.present ? data.productId.value : this.productId,
      productData:
          data.productData.present ? data.productData.value : this.productData,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentlyViewedData(')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, productData, viewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentlyViewedData &&
          other.productId == this.productId &&
          other.productData == this.productData &&
          other.viewedAt == this.viewedAt);
}

class RecentlyViewedCompanion extends UpdateCompanion<RecentlyViewedData> {
  final Value<String> productId;
  final Value<String> productData;
  final Value<DateTime> viewedAt;
  final Value<int> rowid;
  const RecentlyViewedCompanion({
    this.productId = const Value.absent(),
    this.productData = const Value.absent(),
    this.viewedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecentlyViewedCompanion.insert({
    required String productId,
    required String productData,
    required DateTime viewedAt,
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        productData = Value(productData),
        viewedAt = Value(viewedAt);
  static Insertable<RecentlyViewedData> custom({
    Expression<String>? productId,
    Expression<String>? productData,
    Expression<DateTime>? viewedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (productData != null) 'product_data': productData,
      if (viewedAt != null) 'viewed_at': viewedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecentlyViewedCompanion copyWith(
      {Value<String>? productId,
      Value<String>? productData,
      Value<DateTime>? viewedAt,
      Value<int>? rowid}) {
    return RecentlyViewedCompanion(
      productId: productId ?? this.productId,
      productData: productData ?? this.productData,
      viewedAt: viewedAt ?? this.viewedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productData.present) {
      map['product_data'] = Variable<String>(productData.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<DateTime>(viewedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentlyViewedCompanion(')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('viewedAt: $viewedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaveForLaterTable extends SaveForLater
    with TableInfo<$SaveForLaterTable, SaveForLaterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaveForLaterTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productDataMeta =
      const VerificationMeta('productData');
  @override
  late final GeneratedColumn<String> productData = GeneratedColumn<String>(
      'product_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _selectedSizeMeta =
      const VerificationMeta('selectedSize');
  @override
  late final GeneratedColumn<String> selectedSize = GeneratedColumn<String>(
      'selected_size', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _selectedColorMeta =
      const VerificationMeta('selectedColor');
  @override
  late final GeneratedColumn<String> selectedColor = GeneratedColumn<String>(
      'selected_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _savedAtMeta =
      const VerificationMeta('savedAt');
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
      'saved_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productId,
        productData,
        quantity,
        selectedSize,
        selectedColor,
        savedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'save_for_later';
  @override
  VerificationContext validateIntegrity(Insertable<SaveForLaterData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_data')) {
      context.handle(
          _productDataMeta,
          productData.isAcceptableOrUnknown(
              data['product_data']!, _productDataMeta));
    } else if (isInserting) {
      context.missing(_productDataMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('selected_size')) {
      context.handle(
          _selectedSizeMeta,
          selectedSize.isAcceptableOrUnknown(
              data['selected_size']!, _selectedSizeMeta));
    }
    if (data.containsKey('selected_color')) {
      context.handle(
          _selectedColorMeta,
          selectedColor.isAcceptableOrUnknown(
              data['selected_color']!, _selectedColorMeta));
    }
    if (data.containsKey('saved_at')) {
      context.handle(_savedAtMeta,
          savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta));
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaveForLaterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaveForLaterData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      productData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_data'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      selectedSize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_size']),
      selectedColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_color']),
      savedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}saved_at'])!,
    );
  }

  @override
  $SaveForLaterTable createAlias(String alias) {
    return $SaveForLaterTable(attachedDatabase, alias);
  }
}

class SaveForLaterData extends DataClass
    implements Insertable<SaveForLaterData> {
  final int id;
  final String productId;
  final String productData;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final DateTime savedAt;
  const SaveForLaterData(
      {required this.id,
      required this.productId,
      required this.productData,
      required this.quantity,
      this.selectedSize,
      this.selectedColor,
      required this.savedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<String>(productId);
    map['product_data'] = Variable<String>(productData);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || selectedSize != null) {
      map['selected_size'] = Variable<String>(selectedSize);
    }
    if (!nullToAbsent || selectedColor != null) {
      map['selected_color'] = Variable<String>(selectedColor);
    }
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  SaveForLaterCompanion toCompanion(bool nullToAbsent) {
    return SaveForLaterCompanion(
      id: Value(id),
      productId: Value(productId),
      productData: Value(productData),
      quantity: Value(quantity),
      selectedSize: selectedSize == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedSize),
      selectedColor: selectedColor == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedColor),
      savedAt: Value(savedAt),
    );
  }

  factory SaveForLaterData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaveForLaterData(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      productData: serializer.fromJson<String>(json['productData']),
      quantity: serializer.fromJson<int>(json['quantity']),
      selectedSize: serializer.fromJson<String?>(json['selectedSize']),
      selectedColor: serializer.fromJson<String?>(json['selectedColor']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<String>(productId),
      'productData': serializer.toJson<String>(productData),
      'quantity': serializer.toJson<int>(quantity),
      'selectedSize': serializer.toJson<String?>(selectedSize),
      'selectedColor': serializer.toJson<String?>(selectedColor),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  SaveForLaterData copyWith(
          {int? id,
          String? productId,
          String? productData,
          int? quantity,
          Value<String?> selectedSize = const Value.absent(),
          Value<String?> selectedColor = const Value.absent(),
          DateTime? savedAt}) =>
      SaveForLaterData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productData: productData ?? this.productData,
        quantity: quantity ?? this.quantity,
        selectedSize:
            selectedSize.present ? selectedSize.value : this.selectedSize,
        selectedColor:
            selectedColor.present ? selectedColor.value : this.selectedColor,
        savedAt: savedAt ?? this.savedAt,
      );
  SaveForLaterData copyWithCompanion(SaveForLaterCompanion data) {
    return SaveForLaterData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      productData:
          data.productData.present ? data.productData.value : this.productData,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      selectedSize: data.selectedSize.present
          ? data.selectedSize.value
          : this.selectedSize,
      selectedColor: data.selectedColor.present
          ? data.selectedColor.value
          : this.selectedColor,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaveForLaterData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('quantity: $quantity, ')
          ..write('selectedSize: $selectedSize, ')
          ..write('selectedColor: $selectedColor, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, productData, quantity,
      selectedSize, selectedColor, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaveForLaterData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.productData == this.productData &&
          other.quantity == this.quantity &&
          other.selectedSize == this.selectedSize &&
          other.selectedColor == this.selectedColor &&
          other.savedAt == this.savedAt);
}

class SaveForLaterCompanion extends UpdateCompanion<SaveForLaterData> {
  final Value<int> id;
  final Value<String> productId;
  final Value<String> productData;
  final Value<int> quantity;
  final Value<String?> selectedSize;
  final Value<String?> selectedColor;
  final Value<DateTime> savedAt;
  const SaveForLaterCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productData = const Value.absent(),
    this.quantity = const Value.absent(),
    this.selectedSize = const Value.absent(),
    this.selectedColor = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  SaveForLaterCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    required String productData,
    required int quantity,
    this.selectedSize = const Value.absent(),
    this.selectedColor = const Value.absent(),
    required DateTime savedAt,
  })  : productId = Value(productId),
        productData = Value(productData),
        quantity = Value(quantity),
        savedAt = Value(savedAt);
  static Insertable<SaveForLaterData> custom({
    Expression<int>? id,
    Expression<String>? productId,
    Expression<String>? productData,
    Expression<int>? quantity,
    Expression<String>? selectedSize,
    Expression<String>? selectedColor,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (productData != null) 'product_data': productData,
      if (quantity != null) 'quantity': quantity,
      if (selectedSize != null) 'selected_size': selectedSize,
      if (selectedColor != null) 'selected_color': selectedColor,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  SaveForLaterCompanion copyWith(
      {Value<int>? id,
      Value<String>? productId,
      Value<String>? productData,
      Value<int>? quantity,
      Value<String?>? selectedSize,
      Value<String?>? selectedColor,
      Value<DateTime>? savedAt}) {
    return SaveForLaterCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productData: productData ?? this.productData,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productData.present) {
      map['product_data'] = Variable<String>(productData.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (selectedSize.present) {
      map['selected_size'] = Variable<String>(selectedSize.value);
    }
    if (selectedColor.present) {
      map['selected_color'] = Variable<String>(selectedColor.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaveForLaterCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productData: $productData, ')
          ..write('quantity: $quantity, ')
          ..write('selectedSize: $selectedSize, ')
          ..write('selectedColor: $selectedColor, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [entityType, lastSyncAt, syncStatus, errorMessage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(Insertable<SyncMetadataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    } else if (isInserting) {
      context.missing(_lastSyncAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entityType};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String entityType;
  final DateTime lastSyncAt;
  final String syncStatus;
  final String? errorMessage;
  const SyncMetadataData(
      {required this.entityType,
      required this.lastSyncAt,
      required this.syncStatus,
      this.errorMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entity_type'] = Variable<String>(entityType);
    map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      entityType: Value(entityType),
      lastSyncAt: Value(lastSyncAt),
      syncStatus: Value(syncStatus),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory SyncMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      entityType: serializer.fromJson<String>(json['entityType']),
      lastSyncAt: serializer.fromJson<DateTime>(json['lastSyncAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entityType': serializer.toJson<String>(entityType),
      'lastSyncAt': serializer.toJson<DateTime>(lastSyncAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  SyncMetadataData copyWith(
          {String? entityType,
          DateTime? lastSyncAt,
          String? syncStatus,
          Value<String?> errorMessage = const Value.absent()}) =>
      SyncMetadataData(
        entityType: entityType ?? this.entityType,
        lastSyncAt: lastSyncAt ?? this.lastSyncAt,
        syncStatus: syncStatus ?? this.syncStatus,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
      );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('entityType: $entityType, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(entityType, lastSyncAt, syncStatus, errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.entityType == this.entityType &&
          other.lastSyncAt == this.lastSyncAt &&
          other.syncStatus == this.syncStatus &&
          other.errorMessage == this.errorMessage);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> entityType;
  final Value<DateTime> lastSyncAt;
  final Value<String> syncStatus;
  final Value<String?> errorMessage;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.entityType = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String entityType,
    required DateTime lastSyncAt,
    required String syncStatus,
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : entityType = Value(entityType),
        lastSyncAt = Value(lastSyncAt),
        syncStatus = Value(syncStatus);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? entityType,
    Expression<DateTime>? lastSyncAt,
    Expression<String>? syncStatus,
    Expression<String>? errorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entityType != null) 'entity_type': entityType,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (errorMessage != null) 'error_message': errorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith(
      {Value<String>? entityType,
      Value<DateTime>? lastSyncAt,
      Value<String>? syncStatus,
      Value<String?>? errorMessage,
      Value<int>? rowid}) {
    return SyncMetadataCompanion(
      entityType: entityType ?? this.entityType,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      syncStatus: syncStatus ?? this.syncStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('entityType: $entityType, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $AddressesTable addresses = $AddressesTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  late final $WishlistsTable wishlists = $WishlistsTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $CouponsTable coupons = $CouponsTable(this);
  late final $PendingOperationsTable pendingOperations =
      $PendingOperationsTable(this);
  late final $CartItemsTable cartItems = $CartItemsTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $RecentlyViewedTable recentlyViewed = $RecentlyViewedTable(this);
  late final $SaveForLaterTable saveForLater = $SaveForLaterTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        products,
        categories,
        orders,
        addresses,
        reviews,
        wishlists,
        notifications,
        subscriptions,
        coupons,
        pendingOperations,
        cartItems,
        favorites,
        recentlyViewed,
        saveForLater,
        syncMetadata
      ];
}

typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required String id,
  required String name,
  required String description,
  required double price,
  Value<double?> originalPrice,
  required String imageUrl,
  required String images,
  required String category,
  required double rating,
  required int reviewCount,
  required bool inStock,
  required String sizes,
  required String colors,
  Value<String?> brand,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<double> price,
  Value<double?> originalPrice,
  Value<String> imageUrl,
  Value<String> images,
  Value<String> category,
  Value<double> rating,
  Value<int> reviewCount,
  Value<bool> inStock,
  Value<String> sizes,
  Value<String> colors,
  Value<String?> brand,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get originalPrice => $composableBuilder(
      column: $table.originalPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get images => $composableBuilder(
      column: $table.images, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get inStock => $composableBuilder(
      column: $table.inStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sizes => $composableBuilder(
      column: $table.sizes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colors => $composableBuilder(
      column: $table.colors, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get originalPrice => $composableBuilder(
      column: $table.originalPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get images => $composableBuilder(
      column: $table.images, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get inStock => $composableBuilder(
      column: $table.inStock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sizes => $composableBuilder(
      column: $table.sizes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colors => $composableBuilder(
      column: $table.colors, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get originalPrice => $composableBuilder(
      column: $table.originalPrice, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get images =>
      $composableBuilder(column: $table.images, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => column);

  GeneratedColumn<bool> get inStock =>
      $composableBuilder(column: $table.inStock, builder: (column) => column);

  GeneratedColumn<String> get sizes =>
      $composableBuilder(column: $table.sizes, builder: (column) => column);

  GeneratedColumn<String> get colors =>
      $composableBuilder(column: $table.colors, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<double?> originalPrice = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
            Value<String> images = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<int> reviewCount = const Value.absent(),
            Value<bool> inStock = const Value.absent(),
            Value<String> sizes = const Value.absent(),
            Value<String> colors = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            name: name,
            description: description,
            price: price,
            originalPrice: originalPrice,
            imageUrl: imageUrl,
            images: images,
            category: category,
            rating: rating,
            reviewCount: reviewCount,
            inStock: inStock,
            sizes: sizes,
            colors: colors,
            brand: brand,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String description,
            required double price,
            Value<double?> originalPrice = const Value.absent(),
            required String imageUrl,
            required String images,
            required String category,
            required double rating,
            required int reviewCount,
            required bool inStock,
            required String sizes,
            required String colors,
            Value<String?> brand = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            name: name,
            description: description,
            price: price,
            originalPrice: originalPrice,
            imageUrl: imageUrl,
            images: images,
            category: category,
            rating: rating,
            reviewCount: reviewCount,
            inStock: inStock,
            sizes: sizes,
            colors: colors,
            brand: brand,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  Value<String?> iconName,
  Value<String?> imageUrl,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> iconName,
  Value<String?> imageUrl,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconName => $composableBuilder(
      column: $table.iconName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> iconName = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            iconName: iconName,
            imageUrl: imageUrl,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> iconName = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            iconName: iconName,
            imageUrl: imageUrl,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()>;
typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  required String id,
  required String userId,
  required String items,
  required double subtotal,
  required double discount,
  required double shippingCost,
  required double tax,
  required double totalAmount,
  required String status,
  required String paymentStatus,
  required String paymentMethod,
  required DateTime orderDate,
  Value<DateTime?> deliveryDate,
  Value<DateTime?> estimatedDelivery,
  required String shippingAddress,
  Value<String?> billingAddress,
  Value<String?> trackingNumber,
  Value<String?> couponCode,
  Value<String?> orderNotes,
  required bool isGift,
  Value<String?> giftMessage,
  required String statusUpdates,
  Value<bool> isSynced,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> items,
  Value<double> subtotal,
  Value<double> discount,
  Value<double> shippingCost,
  Value<double> tax,
  Value<double> totalAmount,
  Value<String> status,
  Value<String> paymentStatus,
  Value<String> paymentMethod,
  Value<DateTime> orderDate,
  Value<DateTime?> deliveryDate,
  Value<DateTime?> estimatedDelivery,
  Value<String> shippingAddress,
  Value<String?> billingAddress,
  Value<String?> trackingNumber,
  Value<String?> couponCode,
  Value<String?> orderNotes,
  Value<bool> isGift,
  Value<String?> giftMessage,
  Value<String> statusUpdates,
  Value<bool> isSynced,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get items => $composableBuilder(
      column: $table.items, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get shippingCost => $composableBuilder(
      column: $table.shippingCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get tax => $composableBuilder(
      column: $table.tax, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get orderDate => $composableBuilder(
      column: $table.orderDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deliveryDate => $composableBuilder(
      column: $table.deliveryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get estimatedDelivery => $composableBuilder(
      column: $table.estimatedDelivery,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shippingAddress => $composableBuilder(
      column: $table.shippingAddress,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get billingAddress => $composableBuilder(
      column: $table.billingAddress,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trackingNumber => $composableBuilder(
      column: $table.trackingNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get couponCode => $composableBuilder(
      column: $table.couponCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderNotes => $composableBuilder(
      column: $table.orderNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isGift => $composableBuilder(
      column: $table.isGift, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get giftMessage => $composableBuilder(
      column: $table.giftMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statusUpdates => $composableBuilder(
      column: $table.statusUpdates, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get items => $composableBuilder(
      column: $table.items, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get shippingCost => $composableBuilder(
      column: $table.shippingCost,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get tax => $composableBuilder(
      column: $table.tax, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get orderDate => $composableBuilder(
      column: $table.orderDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deliveryDate => $composableBuilder(
      column: $table.deliveryDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get estimatedDelivery => $composableBuilder(
      column: $table.estimatedDelivery,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shippingAddress => $composableBuilder(
      column: $table.shippingAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get billingAddress => $composableBuilder(
      column: $table.billingAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trackingNumber => $composableBuilder(
      column: $table.trackingNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get couponCode => $composableBuilder(
      column: $table.couponCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderNotes => $composableBuilder(
      column: $table.orderNotes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isGift => $composableBuilder(
      column: $table.isGift, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get giftMessage => $composableBuilder(
      column: $table.giftMessage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statusUpdates => $composableBuilder(
      column: $table.statusUpdates,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get items =>
      $composableBuilder(column: $table.items, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get shippingCost => $composableBuilder(
      column: $table.shippingCost, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<DateTime> get orderDate =>
      $composableBuilder(column: $table.orderDate, builder: (column) => column);

  GeneratedColumn<DateTime> get deliveryDate => $composableBuilder(
      column: $table.deliveryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get estimatedDelivery => $composableBuilder(
      column: $table.estimatedDelivery, builder: (column) => column);

  GeneratedColumn<String> get shippingAddress => $composableBuilder(
      column: $table.shippingAddress, builder: (column) => column);

  GeneratedColumn<String> get billingAddress => $composableBuilder(
      column: $table.billingAddress, builder: (column) => column);

  GeneratedColumn<String> get trackingNumber => $composableBuilder(
      column: $table.trackingNumber, builder: (column) => column);

  GeneratedColumn<String> get couponCode => $composableBuilder(
      column: $table.couponCode, builder: (column) => column);

  GeneratedColumn<String> get orderNotes => $composableBuilder(
      column: $table.orderNotes, builder: (column) => column);

  GeneratedColumn<bool> get isGift =>
      $composableBuilder(column: $table.isGift, builder: (column) => column);

  GeneratedColumn<String> get giftMessage => $composableBuilder(
      column: $table.giftMessage, builder: (column) => column);

  GeneratedColumn<String> get statusUpdates => $composableBuilder(
      column: $table.statusUpdates, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$OrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (Order, BaseReferences<_$AppDatabase, $OrdersTable, Order>),
    Order,
    PrefetchHooks Function()> {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> items = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> discount = const Value.absent(),
            Value<double> shippingCost = const Value.absent(),
            Value<double> tax = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> paymentStatus = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<DateTime> orderDate = const Value.absent(),
            Value<DateTime?> deliveryDate = const Value.absent(),
            Value<DateTime?> estimatedDelivery = const Value.absent(),
            Value<String> shippingAddress = const Value.absent(),
            Value<String?> billingAddress = const Value.absent(),
            Value<String?> trackingNumber = const Value.absent(),
            Value<String?> couponCode = const Value.absent(),
            Value<String?> orderNotes = const Value.absent(),
            Value<bool> isGift = const Value.absent(),
            Value<String?> giftMessage = const Value.absent(),
            Value<String> statusUpdates = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion(
            id: id,
            userId: userId,
            items: items,
            subtotal: subtotal,
            discount: discount,
            shippingCost: shippingCost,
            tax: tax,
            totalAmount: totalAmount,
            status: status,
            paymentStatus: paymentStatus,
            paymentMethod: paymentMethod,
            orderDate: orderDate,
            deliveryDate: deliveryDate,
            estimatedDelivery: estimatedDelivery,
            shippingAddress: shippingAddress,
            billingAddress: billingAddress,
            trackingNumber: trackingNumber,
            couponCode: couponCode,
            orderNotes: orderNotes,
            isGift: isGift,
            giftMessage: giftMessage,
            statusUpdates: statusUpdates,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String items,
            required double subtotal,
            required double discount,
            required double shippingCost,
            required double tax,
            required double totalAmount,
            required String status,
            required String paymentStatus,
            required String paymentMethod,
            required DateTime orderDate,
            Value<DateTime?> deliveryDate = const Value.absent(),
            Value<DateTime?> estimatedDelivery = const Value.absent(),
            required String shippingAddress,
            Value<String?> billingAddress = const Value.absent(),
            Value<String?> trackingNumber = const Value.absent(),
            Value<String?> couponCode = const Value.absent(),
            Value<String?> orderNotes = const Value.absent(),
            required bool isGift,
            Value<String?> giftMessage = const Value.absent(),
            required String statusUpdates,
            Value<bool> isSynced = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion.insert(
            id: id,
            userId: userId,
            items: items,
            subtotal: subtotal,
            discount: discount,
            shippingCost: shippingCost,
            tax: tax,
            totalAmount: totalAmount,
            status: status,
            paymentStatus: paymentStatus,
            paymentMethod: paymentMethod,
            orderDate: orderDate,
            deliveryDate: deliveryDate,
            estimatedDelivery: estimatedDelivery,
            shippingAddress: shippingAddress,
            billingAddress: billingAddress,
            trackingNumber: trackingNumber,
            couponCode: couponCode,
            orderNotes: orderNotes,
            isGift: isGift,
            giftMessage: giftMessage,
            statusUpdates: statusUpdates,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (Order, BaseReferences<_$AppDatabase, $OrdersTable, Order>),
    Order,
    PrefetchHooks Function()>;
typedef $$AddressesTableCreateCompanionBuilder = AddressesCompanion Function({
  required String id,
  required String userId,
  required String fullName,
  required String phoneNumber,
  required String addressLine1,
  Value<String?> addressLine2,
  required String city,
  required String state,
  required String country,
  required String zipCode,
  Value<String?> landmark,
  required bool isDefault,
  required String type,
  Value<bool> isSynced,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$AddressesTableUpdateCompanionBuilder = AddressesCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> fullName,
  Value<String> phoneNumber,
  Value<String> addressLine1,
  Value<String?> addressLine2,
  Value<String> city,
  Value<String> state,
  Value<String> country,
  Value<String> zipCode,
  Value<String?> landmark,
  Value<bool> isDefault,
  Value<String> type,
  Value<bool> isSynced,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$AddressesTableFilterComposer
    extends Composer<_$AppDatabase, $AddressesTable> {
  $$AddressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get addressLine1 => $composableBuilder(
      column: $table.addressLine1, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get addressLine2 => $composableBuilder(
      column: $table.addressLine2, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get landmark => $composableBuilder(
      column: $table.landmark, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$AddressesTableOrderingComposer
    extends Composer<_$AppDatabase, $AddressesTable> {
  $$AddressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get addressLine1 => $composableBuilder(
      column: $table.addressLine1,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get addressLine2 => $composableBuilder(
      column: $table.addressLine2,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get landmark => $composableBuilder(
      column: $table.landmark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$AddressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AddressesTable> {
  $$AddressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get addressLine1 => $composableBuilder(
      column: $table.addressLine1, builder: (column) => column);

  GeneratedColumn<String> get addressLine2 => $composableBuilder(
      column: $table.addressLine2, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);

  GeneratedColumn<String> get landmark =>
      $composableBuilder(column: $table.landmark, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$AddressesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AddressesTable,
    AddressesData,
    $$AddressesTableFilterComposer,
    $$AddressesTableOrderingComposer,
    $$AddressesTableAnnotationComposer,
    $$AddressesTableCreateCompanionBuilder,
    $$AddressesTableUpdateCompanionBuilder,
    (
      AddressesData,
      BaseReferences<_$AppDatabase, $AddressesTable, AddressesData>
    ),
    AddressesData,
    PrefetchHooks Function()> {
  $$AddressesTableTableManager(_$AppDatabase db, $AddressesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AddressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AddressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AddressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String> phoneNumber = const Value.absent(),
            Value<String> addressLine1 = const Value.absent(),
            Value<String?> addressLine2 = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<String> zipCode = const Value.absent(),
            Value<String?> landmark = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AddressesCompanion(
            id: id,
            userId: userId,
            fullName: fullName,
            phoneNumber: phoneNumber,
            addressLine1: addressLine1,
            addressLine2: addressLine2,
            city: city,
            state: state,
            country: country,
            zipCode: zipCode,
            landmark: landmark,
            isDefault: isDefault,
            type: type,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String fullName,
            required String phoneNumber,
            required String addressLine1,
            Value<String?> addressLine2 = const Value.absent(),
            required String city,
            required String state,
            required String country,
            required String zipCode,
            Value<String?> landmark = const Value.absent(),
            required bool isDefault,
            required String type,
            Value<bool> isSynced = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AddressesCompanion.insert(
            id: id,
            userId: userId,
            fullName: fullName,
            phoneNumber: phoneNumber,
            addressLine1: addressLine1,
            addressLine2: addressLine2,
            city: city,
            state: state,
            country: country,
            zipCode: zipCode,
            landmark: landmark,
            isDefault: isDefault,
            type: type,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AddressesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AddressesTable,
    AddressesData,
    $$AddressesTableFilterComposer,
    $$AddressesTableOrderingComposer,
    $$AddressesTableAnnotationComposer,
    $$AddressesTableCreateCompanionBuilder,
    $$AddressesTableUpdateCompanionBuilder,
    (
      AddressesData,
      BaseReferences<_$AppDatabase, $AddressesTable, AddressesData>
    ),
    AddressesData,
    PrefetchHooks Function()>;
typedef $$ReviewsTableCreateCompanionBuilder = ReviewsCompanion Function({
  required String id,
  required String productId,
  required String userId,
  required double rating,
  Value<String?> title,
  required String comment,
  required bool isVerified,
  required int helpfulCount,
  required DateTime timestamp,
  Value<bool> isSynced,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$ReviewsTableUpdateCompanionBuilder = ReviewsCompanion Function({
  Value<String> id,
  Value<String> productId,
  Value<String> userId,
  Value<double> rating,
  Value<String?> title,
  Value<String> comment,
  Value<bool> isVerified,
  Value<int> helpfulCount,
  Value<DateTime> timestamp,
  Value<bool> isSynced,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$ReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get helpfulCount => $composableBuilder(
      column: $table.helpfulCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$ReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comment => $composableBuilder(
      column: $table.comment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get helpfulCount => $composableBuilder(
      column: $table.helpfulCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$ReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => column);

  GeneratedColumn<int> get helpfulCount => $composableBuilder(
      column: $table.helpfulCount, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$ReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, BaseReferences<_$AppDatabase, $ReviewsTable, Review>),
    Review,
    PrefetchHooks Function()> {
  $$ReviewsTableTableManager(_$AppDatabase db, $ReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String> comment = const Value.absent(),
            Value<bool> isVerified = const Value.absent(),
            Value<int> helpfulCount = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReviewsCompanion(
            id: id,
            productId: productId,
            userId: userId,
            rating: rating,
            title: title,
            comment: comment,
            isVerified: isVerified,
            helpfulCount: helpfulCount,
            timestamp: timestamp,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String productId,
            required String userId,
            required double rating,
            Value<String?> title = const Value.absent(),
            required String comment,
            required bool isVerified,
            required int helpfulCount,
            required DateTime timestamp,
            Value<bool> isSynced = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ReviewsCompanion.insert(
            id: id,
            productId: productId,
            userId: userId,
            rating: rating,
            title: title,
            comment: comment,
            isVerified: isVerified,
            helpfulCount: helpfulCount,
            timestamp: timestamp,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReviewsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, BaseReferences<_$AppDatabase, $ReviewsTable, Review>),
    Review,
    PrefetchHooks Function()>;
typedef $$WishlistsTableCreateCompanionBuilder = WishlistsCompanion Function({
  required String id,
  required String userId,
  required String name,
  required String type,
  required String products,
  required DateTime createdAt,
  required bool isPrivate,
  Value<String?> description,
  Value<bool> isSynced,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$WishlistsTableUpdateCompanionBuilder = WishlistsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<String> type,
  Value<String> products,
  Value<DateTime> createdAt,
  Value<bool> isPrivate,
  Value<String?> description,
  Value<bool> isSynced,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$WishlistsTableFilterComposer
    extends Composer<_$AppDatabase, $WishlistsTable> {
  $$WishlistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get products => $composableBuilder(
      column: $table.products, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$WishlistsTableOrderingComposer
    extends Composer<_$AppDatabase, $WishlistsTable> {
  $$WishlistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get products => $composableBuilder(
      column: $table.products, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$WishlistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishlistsTable> {
  $$WishlistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get products =>
      $composableBuilder(column: $table.products, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$WishlistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WishlistsTable,
    Wishlist,
    $$WishlistsTableFilterComposer,
    $$WishlistsTableOrderingComposer,
    $$WishlistsTableAnnotationComposer,
    $$WishlistsTableCreateCompanionBuilder,
    $$WishlistsTableUpdateCompanionBuilder,
    (Wishlist, BaseReferences<_$AppDatabase, $WishlistsTable, Wishlist>),
    Wishlist,
    PrefetchHooks Function()> {
  $$WishlistsTableTableManager(_$AppDatabase db, $WishlistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> products = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isPrivate = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistsCompanion(
            id: id,
            userId: userId,
            name: name,
            type: type,
            products: products,
            createdAt: createdAt,
            isPrivate: isPrivate,
            description: description,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String name,
            required String type,
            required String products,
            required DateTime createdAt,
            required bool isPrivate,
            Value<String?> description = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            type: type,
            products: products,
            createdAt: createdAt,
            isPrivate: isPrivate,
            description: description,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WishlistsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WishlistsTable,
    Wishlist,
    $$WishlistsTableFilterComposer,
    $$WishlistsTableOrderingComposer,
    $$WishlistsTableAnnotationComposer,
    $$WishlistsTableCreateCompanionBuilder,
    $$WishlistsTableUpdateCompanionBuilder,
    (Wishlist, BaseReferences<_$AppDatabase, $WishlistsTable, Wishlist>),
    Wishlist,
    PrefetchHooks Function()>;
typedef $$NotificationsTableCreateCompanionBuilder = NotificationsCompanion
    Function({
  required String id,
  required String title,
  required String message,
  required String type,
  required DateTime timestamp,
  required bool isRead,
  Value<String?> imageUrl,
  Value<String?> actionUrl,
  Value<String?> data,
  Value<bool> isSynced,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$NotificationsTableUpdateCompanionBuilder = NotificationsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> message,
  Value<String> type,
  Value<DateTime> timestamp,
  Value<bool> isRead,
  Value<String?> imageUrl,
  Value<String?> actionUrl,
  Value<String?> data,
  Value<bool> isSynced,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actionUrl => $composableBuilder(
      column: $table.actionUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actionUrl => $composableBuilder(
      column: $table.actionUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get actionUrl =>
      $composableBuilder(column: $table.actionUrl, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$NotificationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationsTable,
    Notification,
    $$NotificationsTableFilterComposer,
    $$NotificationsTableOrderingComposer,
    $$NotificationsTableAnnotationComposer,
    $$NotificationsTableCreateCompanionBuilder,
    $$NotificationsTableUpdateCompanionBuilder,
    (
      Notification,
      BaseReferences<_$AppDatabase, $NotificationsTable, Notification>
    ),
    Notification,
    PrefetchHooks Function()> {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> actionUrl = const Value.absent(),
            Value<String?> data = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationsCompanion(
            id: id,
            title: title,
            message: message,
            type: type,
            timestamp: timestamp,
            isRead: isRead,
            imageUrl: imageUrl,
            actionUrl: actionUrl,
            data: data,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String message,
            required String type,
            required DateTime timestamp,
            required bool isRead,
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> actionUrl = const Value.absent(),
            Value<String?> data = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationsCompanion.insert(
            id: id,
            title: title,
            message: message,
            type: type,
            timestamp: timestamp,
            isRead: isRead,
            imageUrl: imageUrl,
            actionUrl: actionUrl,
            data: data,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationsTable,
    Notification,
    $$NotificationsTableFilterComposer,
    $$NotificationsTableOrderingComposer,
    $$NotificationsTableAnnotationComposer,
    $$NotificationsTableCreateCompanionBuilder,
    $$NotificationsTableUpdateCompanionBuilder,
    (
      Notification,
      BaseReferences<_$AppDatabase, $NotificationsTable, Notification>
    ),
    Notification,
    PrefetchHooks Function()>;
typedef $$SubscriptionsTableCreateCompanionBuilder = SubscriptionsCompanion
    Function({
  required String id,
  required String userId,
  required String productId,
  required int quantity,
  required String frequency,
  required double price,
  required String status,
  required DateTime startDate,
  Value<DateTime?> nextDeliveryDate,
  Value<DateTime?> endDate,
  required int totalOrders,
  Value<bool> isSynced,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$SubscriptionsTableUpdateCompanionBuilder = SubscriptionsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> productId,
  Value<int> quantity,
  Value<String> frequency,
  Value<double> price,
  Value<String> status,
  Value<DateTime> startDate,
  Value<DateTime?> nextDeliveryDate,
  Value<DateTime?> endDate,
  Value<int> totalOrders,
  Value<bool> isSynced,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$SubscriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextDeliveryDate => $composableBuilder(
      column: $table.nextDeliveryDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextDeliveryDate => $composableBuilder(
      column: $table.nextDeliveryDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDeliveryDate => $composableBuilder(
      column: $table.nextDeliveryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$SubscriptionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SubscriptionsTable,
    Subscription,
    $$SubscriptionsTableFilterComposer,
    $$SubscriptionsTableOrderingComposer,
    $$SubscriptionsTableAnnotationComposer,
    $$SubscriptionsTableCreateCompanionBuilder,
    $$SubscriptionsTableUpdateCompanionBuilder,
    (
      Subscription,
      BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>
    ),
    Subscription,
    PrefetchHooks Function()> {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> nextDeliveryDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<int> totalOrders = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubscriptionsCompanion(
            id: id,
            userId: userId,
            productId: productId,
            quantity: quantity,
            frequency: frequency,
            price: price,
            status: status,
            startDate: startDate,
            nextDeliveryDate: nextDeliveryDate,
            endDate: endDate,
            totalOrders: totalOrders,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String productId,
            required int quantity,
            required String frequency,
            required double price,
            required String status,
            required DateTime startDate,
            Value<DateTime?> nextDeliveryDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            required int totalOrders,
            Value<bool> isSynced = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SubscriptionsCompanion.insert(
            id: id,
            userId: userId,
            productId: productId,
            quantity: quantity,
            frequency: frequency,
            price: price,
            status: status,
            startDate: startDate,
            nextDeliveryDate: nextDeliveryDate,
            endDate: endDate,
            totalOrders: totalOrders,
            isSynced: isSynced,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SubscriptionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SubscriptionsTable,
    Subscription,
    $$SubscriptionsTableFilterComposer,
    $$SubscriptionsTableOrderingComposer,
    $$SubscriptionsTableAnnotationComposer,
    $$SubscriptionsTableCreateCompanionBuilder,
    $$SubscriptionsTableUpdateCompanionBuilder,
    (
      Subscription,
      BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>
    ),
    Subscription,
    PrefetchHooks Function()>;
typedef $$CouponsTableCreateCompanionBuilder = CouponsCompanion Function({
  required String id,
  required String code,
  required String title,
  required String description,
  required String discountType,
  required double discountValue,
  Value<double?> minPurchase,
  Value<double?> maxDiscount,
  Value<DateTime?> expiryDate,
  required bool isActive,
  Value<int?> usageLimit,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CouponsTableUpdateCompanionBuilder = CouponsCompanion Function({
  Value<String> id,
  Value<String> code,
  Value<String> title,
  Value<String> description,
  Value<String> discountType,
  Value<double> discountValue,
  Value<double?> minPurchase,
  Value<double?> maxDiscount,
  Value<DateTime?> expiryDate,
  Value<bool> isActive,
  Value<int?> usageLimit,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CouponsTableFilterComposer
    extends Composer<_$AppDatabase, $CouponsTable> {
  $$CouponsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get discountType => $composableBuilder(
      column: $table.discountType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountValue => $composableBuilder(
      column: $table.discountValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minPurchase => $composableBuilder(
      column: $table.minPurchase, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxDiscount => $composableBuilder(
      column: $table.maxDiscount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get usageLimit => $composableBuilder(
      column: $table.usageLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CouponsTableOrderingComposer
    extends Composer<_$AppDatabase, $CouponsTable> {
  $$CouponsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get discountType => $composableBuilder(
      column: $table.discountType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountValue => $composableBuilder(
      column: $table.discountValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minPurchase => $composableBuilder(
      column: $table.minPurchase, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxDiscount => $composableBuilder(
      column: $table.maxDiscount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usageLimit => $composableBuilder(
      column: $table.usageLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CouponsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CouponsTable> {
  $$CouponsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get discountType => $composableBuilder(
      column: $table.discountType, builder: (column) => column);

  GeneratedColumn<double> get discountValue => $composableBuilder(
      column: $table.discountValue, builder: (column) => column);

  GeneratedColumn<double> get minPurchase => $composableBuilder(
      column: $table.minPurchase, builder: (column) => column);

  GeneratedColumn<double> get maxDiscount => $composableBuilder(
      column: $table.maxDiscount, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get usageLimit => $composableBuilder(
      column: $table.usageLimit, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CouponsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CouponsTable,
    Coupon,
    $$CouponsTableFilterComposer,
    $$CouponsTableOrderingComposer,
    $$CouponsTableAnnotationComposer,
    $$CouponsTableCreateCompanionBuilder,
    $$CouponsTableUpdateCompanionBuilder,
    (Coupon, BaseReferences<_$AppDatabase, $CouponsTable, Coupon>),
    Coupon,
    PrefetchHooks Function()> {
  $$CouponsTableTableManager(_$AppDatabase db, $CouponsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CouponsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CouponsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CouponsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> discountType = const Value.absent(),
            Value<double> discountValue = const Value.absent(),
            Value<double?> minPurchase = const Value.absent(),
            Value<double?> maxDiscount = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int?> usageLimit = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CouponsCompanion(
            id: id,
            code: code,
            title: title,
            description: description,
            discountType: discountType,
            discountValue: discountValue,
            minPurchase: minPurchase,
            maxDiscount: maxDiscount,
            expiryDate: expiryDate,
            isActive: isActive,
            usageLimit: usageLimit,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String code,
            required String title,
            required String description,
            required String discountType,
            required double discountValue,
            Value<double?> minPurchase = const Value.absent(),
            Value<double?> maxDiscount = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            required bool isActive,
            Value<int?> usageLimit = const Value.absent(),
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CouponsCompanion.insert(
            id: id,
            code: code,
            title: title,
            description: description,
            discountType: discountType,
            discountValue: discountValue,
            minPurchase: minPurchase,
            maxDiscount: maxDiscount,
            expiryDate: expiryDate,
            isActive: isActive,
            usageLimit: usageLimit,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CouponsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CouponsTable,
    Coupon,
    $$CouponsTableFilterComposer,
    $$CouponsTableOrderingComposer,
    $$CouponsTableAnnotationComposer,
    $$CouponsTableCreateCompanionBuilder,
    $$CouponsTableUpdateCompanionBuilder,
    (Coupon, BaseReferences<_$AppDatabase, $CouponsTable, Coupon>),
    Coupon,
    PrefetchHooks Function()>;
typedef $$PendingOperationsTableCreateCompanionBuilder
    = PendingOperationsCompanion Function({
  Value<int> id,
  required String operationType,
  required String entityType,
  required String entityId,
  required String endpoint,
  required String method,
  required String payload,
  required String status,
  Value<int> retryCount,
  required DateTime createdAt,
  Value<DateTime?> lastAttemptAt,
  Value<String?> errorMessage,
});
typedef $$PendingOperationsTableUpdateCompanionBuilder
    = PendingOperationsCompanion Function({
  Value<int> id,
  Value<String> operationType,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> endpoint,
  Value<String> method,
  Value<String> payload,
  Value<String> status,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttemptAt,
  Value<String?> errorMessage,
});

class $$PendingOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operationType => $composableBuilder(
      column: $table.operationType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endpoint => $composableBuilder(
      column: $table.endpoint, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));
}

class $$PendingOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operationType => $composableBuilder(
      column: $table.operationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endpoint => $composableBuilder(
      column: $table.endpoint, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));
}

class $$PendingOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
      column: $table.operationType, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get endpoint =>
      $composableBuilder(column: $table.endpoint, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);
}

class $$PendingOperationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PendingOperationsTable,
    PendingOperation,
    $$PendingOperationsTableFilterComposer,
    $$PendingOperationsTableOrderingComposer,
    $$PendingOperationsTableAnnotationComposer,
    $$PendingOperationsTableCreateCompanionBuilder,
    $$PendingOperationsTableUpdateCompanionBuilder,
    (
      PendingOperation,
      BaseReferences<_$AppDatabase, $PendingOperationsTable, PendingOperation>
    ),
    PendingOperation,
    PrefetchHooks Function()> {
  $$PendingOperationsTableTableManager(
      _$AppDatabase db, $PendingOperationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingOperationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingOperationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingOperationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> operationType = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> endpoint = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
          }) =>
              PendingOperationsCompanion(
            id: id,
            operationType: operationType,
            entityType: entityType,
            entityId: entityId,
            endpoint: endpoint,
            method: method,
            payload: payload,
            status: status,
            retryCount: retryCount,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
            errorMessage: errorMessage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String operationType,
            required String entityType,
            required String entityId,
            required String endpoint,
            required String method,
            required String payload,
            required String status,
            Value<int> retryCount = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
          }) =>
              PendingOperationsCompanion.insert(
            id: id,
            operationType: operationType,
            entityType: entityType,
            entityId: entityId,
            endpoint: endpoint,
            method: method,
            payload: payload,
            status: status,
            retryCount: retryCount,
            createdAt: createdAt,
            lastAttemptAt: lastAttemptAt,
            errorMessage: errorMessage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingOperationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PendingOperationsTable,
    PendingOperation,
    $$PendingOperationsTableFilterComposer,
    $$PendingOperationsTableOrderingComposer,
    $$PendingOperationsTableAnnotationComposer,
    $$PendingOperationsTableCreateCompanionBuilder,
    $$PendingOperationsTableUpdateCompanionBuilder,
    (
      PendingOperation,
      BaseReferences<_$AppDatabase, $PendingOperationsTable, PendingOperation>
    ),
    PendingOperation,
    PrefetchHooks Function()>;
typedef $$CartItemsTableCreateCompanionBuilder = CartItemsCompanion Function({
  Value<int> id,
  required String productId,
  required String productData,
  required int quantity,
  Value<String?> selectedSize,
  Value<String?> selectedColor,
  required DateTime addedAt,
});
typedef $$CartItemsTableUpdateCompanionBuilder = CartItemsCompanion Function({
  Value<int> id,
  Value<String> productId,
  Value<String> productData,
  Value<int> quantity,
  Value<String?> selectedSize,
  Value<String?> selectedColor,
  Value<DateTime> addedAt,
});

class $$CartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnFilters(column));
}

class $$CartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnOrderings(column));
}

class $$CartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize, builder: (column) => column);

  GeneratedColumn<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$CartItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CartItemsTable,
    CartItem,
    $$CartItemsTableFilterComposer,
    $$CartItemsTableOrderingComposer,
    $$CartItemsTableAnnotationComposer,
    $$CartItemsTableCreateCompanionBuilder,
    $$CartItemsTableUpdateCompanionBuilder,
    (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
    CartItem,
    PrefetchHooks Function()> {
  $$CartItemsTableTableManager(_$AppDatabase db, $CartItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> productData = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String?> selectedSize = const Value.absent(),
            Value<String?> selectedColor = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
          }) =>
              CartItemsCompanion(
            id: id,
            productId: productId,
            productData: productData,
            quantity: quantity,
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            addedAt: addedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String productId,
            required String productData,
            required int quantity,
            Value<String?> selectedSize = const Value.absent(),
            Value<String?> selectedColor = const Value.absent(),
            required DateTime addedAt,
          }) =>
              CartItemsCompanion.insert(
            id: id,
            productId: productId,
            productData: productData,
            quantity: quantity,
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            addedAt: addedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CartItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CartItemsTable,
    CartItem,
    $$CartItemsTableFilterComposer,
    $$CartItemsTableOrderingComposer,
    $$CartItemsTableAnnotationComposer,
    $$CartItemsTableCreateCompanionBuilder,
    $$CartItemsTableUpdateCompanionBuilder,
    (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
    CartItem,
    PrefetchHooks Function()>;
typedef $$FavoritesTableCreateCompanionBuilder = FavoritesCompanion Function({
  required String productId,
  required String productData,
  required DateTime addedAt,
  Value<int> rowid,
});
typedef $$FavoritesTableUpdateCompanionBuilder = FavoritesCompanion Function({
  Value<String> productId,
  Value<String> productData,
  Value<DateTime> addedAt,
  Value<int> rowid,
});

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnFilters(column));
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnOrderings(column));
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoritesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoritesTable,
    Favorite,
    $$FavoritesTableFilterComposer,
    $$FavoritesTableOrderingComposer,
    $$FavoritesTableAnnotationComposer,
    $$FavoritesTableCreateCompanionBuilder,
    $$FavoritesTableUpdateCompanionBuilder,
    (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
    Favorite,
    PrefetchHooks Function()> {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> productId = const Value.absent(),
            Value<String> productData = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FavoritesCompanion(
            productId: productId,
            productData: productData,
            addedAt: addedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String productId,
            required String productData,
            required DateTime addedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              FavoritesCompanion.insert(
            productId: productId,
            productData: productData,
            addedAt: addedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FavoritesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoritesTable,
    Favorite,
    $$FavoritesTableFilterComposer,
    $$FavoritesTableOrderingComposer,
    $$FavoritesTableAnnotationComposer,
    $$FavoritesTableCreateCompanionBuilder,
    $$FavoritesTableUpdateCompanionBuilder,
    (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
    Favorite,
    PrefetchHooks Function()>;
typedef $$RecentlyViewedTableCreateCompanionBuilder = RecentlyViewedCompanion
    Function({
  required String productId,
  required String productData,
  required DateTime viewedAt,
  Value<int> rowid,
});
typedef $$RecentlyViewedTableUpdateCompanionBuilder = RecentlyViewedCompanion
    Function({
  Value<String> productId,
  Value<String> productData,
  Value<DateTime> viewedAt,
  Value<int> rowid,
});

class $$RecentlyViewedTableFilterComposer
    extends Composer<_$AppDatabase, $RecentlyViewedTable> {
  $$RecentlyViewedTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get viewedAt => $composableBuilder(
      column: $table.viewedAt, builder: (column) => ColumnFilters(column));
}

class $$RecentlyViewedTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentlyViewedTable> {
  $$RecentlyViewedTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get viewedAt => $composableBuilder(
      column: $table.viewedAt, builder: (column) => ColumnOrderings(column));
}

class $$RecentlyViewedTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentlyViewedTable> {
  $$RecentlyViewedTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => column);

  GeneratedColumn<DateTime> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);
}

class $$RecentlyViewedTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecentlyViewedTable,
    RecentlyViewedData,
    $$RecentlyViewedTableFilterComposer,
    $$RecentlyViewedTableOrderingComposer,
    $$RecentlyViewedTableAnnotationComposer,
    $$RecentlyViewedTableCreateCompanionBuilder,
    $$RecentlyViewedTableUpdateCompanionBuilder,
    (
      RecentlyViewedData,
      BaseReferences<_$AppDatabase, $RecentlyViewedTable, RecentlyViewedData>
    ),
    RecentlyViewedData,
    PrefetchHooks Function()> {
  $$RecentlyViewedTableTableManager(
      _$AppDatabase db, $RecentlyViewedTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentlyViewedTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentlyViewedTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentlyViewedTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> productId = const Value.absent(),
            Value<String> productData = const Value.absent(),
            Value<DateTime> viewedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecentlyViewedCompanion(
            productId: productId,
            productData: productData,
            viewedAt: viewedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String productId,
            required String productData,
            required DateTime viewedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RecentlyViewedCompanion.insert(
            productId: productId,
            productData: productData,
            viewedAt: viewedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecentlyViewedTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecentlyViewedTable,
    RecentlyViewedData,
    $$RecentlyViewedTableFilterComposer,
    $$RecentlyViewedTableOrderingComposer,
    $$RecentlyViewedTableAnnotationComposer,
    $$RecentlyViewedTableCreateCompanionBuilder,
    $$RecentlyViewedTableUpdateCompanionBuilder,
    (
      RecentlyViewedData,
      BaseReferences<_$AppDatabase, $RecentlyViewedTable, RecentlyViewedData>
    ),
    RecentlyViewedData,
    PrefetchHooks Function()>;
typedef $$SaveForLaterTableCreateCompanionBuilder = SaveForLaterCompanion
    Function({
  Value<int> id,
  required String productId,
  required String productData,
  required int quantity,
  Value<String?> selectedSize,
  Value<String?> selectedColor,
  required DateTime savedAt,
});
typedef $$SaveForLaterTableUpdateCompanionBuilder = SaveForLaterCompanion
    Function({
  Value<int> id,
  Value<String> productId,
  Value<String> productData,
  Value<int> quantity,
  Value<String?> selectedSize,
  Value<String?> selectedColor,
  Value<DateTime> savedAt,
});

class $$SaveForLaterTableFilterComposer
    extends Composer<_$AppDatabase, $SaveForLaterTable> {
  $$SaveForLaterTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnFilters(column));
}

class $$SaveForLaterTableOrderingComposer
    extends Composer<_$AppDatabase, $SaveForLaterTable> {
  $$SaveForLaterTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnOrderings(column));
}

class $$SaveForLaterTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaveForLaterTable> {
  $$SaveForLaterTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productData => $composableBuilder(
      column: $table.productData, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize, builder: (column) => column);

  GeneratedColumn<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SaveForLaterTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SaveForLaterTable,
    SaveForLaterData,
    $$SaveForLaterTableFilterComposer,
    $$SaveForLaterTableOrderingComposer,
    $$SaveForLaterTableAnnotationComposer,
    $$SaveForLaterTableCreateCompanionBuilder,
    $$SaveForLaterTableUpdateCompanionBuilder,
    (
      SaveForLaterData,
      BaseReferences<_$AppDatabase, $SaveForLaterTable, SaveForLaterData>
    ),
    SaveForLaterData,
    PrefetchHooks Function()> {
  $$SaveForLaterTableTableManager(_$AppDatabase db, $SaveForLaterTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaveForLaterTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaveForLaterTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaveForLaterTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> productData = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String?> selectedSize = const Value.absent(),
            Value<String?> selectedColor = const Value.absent(),
            Value<DateTime> savedAt = const Value.absent(),
          }) =>
              SaveForLaterCompanion(
            id: id,
            productId: productId,
            productData: productData,
            quantity: quantity,
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            savedAt: savedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String productId,
            required String productData,
            required int quantity,
            Value<String?> selectedSize = const Value.absent(),
            Value<String?> selectedColor = const Value.absent(),
            required DateTime savedAt,
          }) =>
              SaveForLaterCompanion.insert(
            id: id,
            productId: productId,
            productData: productData,
            quantity: quantity,
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            savedAt: savedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SaveForLaterTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SaveForLaterTable,
    SaveForLaterData,
    $$SaveForLaterTableFilterComposer,
    $$SaveForLaterTableOrderingComposer,
    $$SaveForLaterTableAnnotationComposer,
    $$SaveForLaterTableCreateCompanionBuilder,
    $$SaveForLaterTableUpdateCompanionBuilder,
    (
      SaveForLaterData,
      BaseReferences<_$AppDatabase, $SaveForLaterTable, SaveForLaterData>
    ),
    SaveForLaterData,
    PrefetchHooks Function()>;
typedef $$SyncMetadataTableCreateCompanionBuilder = SyncMetadataCompanion
    Function({
  required String entityType,
  required DateTime lastSyncAt,
  required String syncStatus,
  Value<String?> errorMessage,
  Value<int> rowid,
});
typedef $$SyncMetadataTableUpdateCompanionBuilder = SyncMetadataCompanion
    Function({
  Value<String> entityType,
  Value<DateTime> lastSyncAt,
  Value<String> syncStatus,
  Value<String?> errorMessage,
  Value<int> rowid,
});

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);
}

class $$SyncMetadataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncMetadataTable,
    SyncMetadataData,
    $$SyncMetadataTableFilterComposer,
    $$SyncMetadataTableOrderingComposer,
    $$SyncMetadataTableAnnotationComposer,
    $$SyncMetadataTableCreateCompanionBuilder,
    $$SyncMetadataTableUpdateCompanionBuilder,
    (
      SyncMetadataData,
      BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>
    ),
    SyncMetadataData,
    PrefetchHooks Function()> {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> entityType = const Value.absent(),
            Value<DateTime> lastSyncAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataCompanion(
            entityType: entityType,
            lastSyncAt: lastSyncAt,
            syncStatus: syncStatus,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entityType,
            required DateTime lastSyncAt,
            required String syncStatus,
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataCompanion.insert(
            entityType: entityType,
            lastSyncAt: lastSyncAt,
            syncStatus: syncStatus,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncMetadataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncMetadataTable,
    SyncMetadataData,
    $$SyncMetadataTableFilterComposer,
    $$SyncMetadataTableOrderingComposer,
    $$SyncMetadataTableAnnotationComposer,
    $$SyncMetadataTableCreateCompanionBuilder,
    $$SyncMetadataTableUpdateCompanionBuilder,
    (
      SyncMetadataData,
      BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>
    ),
    SyncMetadataData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$AddressesTableTableManager get addresses =>
      $$AddressesTableTableManager(_db, _db.addresses);
  $$ReviewsTableTableManager get reviews =>
      $$ReviewsTableTableManager(_db, _db.reviews);
  $$WishlistsTableTableManager get wishlists =>
      $$WishlistsTableTableManager(_db, _db.wishlists);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$CouponsTableTableManager get coupons =>
      $$CouponsTableTableManager(_db, _db.coupons);
  $$PendingOperationsTableTableManager get pendingOperations =>
      $$PendingOperationsTableTableManager(_db, _db.pendingOperations);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db, _db.cartItems);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$RecentlyViewedTableTableManager get recentlyViewed =>
      $$RecentlyViewedTableTableManager(_db, _db.recentlyViewed);
  $$SaveForLaterTableTableManager get saveForLater =>
      $$SaveForLaterTableTableManager(_db, _db.saveForLater);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
}
