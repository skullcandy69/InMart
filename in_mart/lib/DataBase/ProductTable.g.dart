// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ProductDbData extends DataClass implements Insertable<ProductDbData> {
  final int productid;
  final String title;
  final String website;
  final String imageUrl;
  final String link;
  final String company;
  final String description;
  final String productType;
  final int price;
  ProductDbData(
      {@required this.productid,
      this.title,
      this.website,
      this.imageUrl,
      this.link,
      this.company,
      this.description,
      this.productType,
      this.price});
  factory ProductDbData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ProductDbData(
      productid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}productid']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      website:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}website']),
      imageUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url']),
      link: stringType.mapFromDatabaseResponse(data['${effectivePrefix}link']),
      company:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}company']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      productType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_type']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || productid != null) {
      map['productid'] = Variable<int>(productid);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || company != null) {
      map['company'] = Variable<String>(company);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || productType != null) {
      map['product_type'] = Variable<String>(productType);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    return map;
  }

  ProductDbCompanion toCompanion(bool nullToAbsent) {
    return ProductDbCompanion(
      productid: productid == null && nullToAbsent
          ? const Value.absent()
          : Value(productid),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      company: company == null && nullToAbsent
          ? const Value.absent()
          : Value(company),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      productType: productType == null && nullToAbsent
          ? const Value.absent()
          : Value(productType),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  factory ProductDbData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductDbData(
      productid: serializer.fromJson<int>(json['productid']),
      title: serializer.fromJson<String>(json['title']),
      website: serializer.fromJson<String>(json['website']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      link: serializer.fromJson<String>(json['link']),
      company: serializer.fromJson<String>(json['company']),
      description: serializer.fromJson<String>(json['description']),
      productType: serializer.fromJson<String>(json['productType']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productid': serializer.toJson<int>(productid),
      'title': serializer.toJson<String>(title),
      'website': serializer.toJson<String>(website),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'link': serializer.toJson<String>(link),
      'company': serializer.toJson<String>(company),
      'description': serializer.toJson<String>(description),
      'productType': serializer.toJson<String>(productType),
      'price': serializer.toJson<int>(price),
    };
  }

  ProductDbData copyWith(
          {int productid,
          String title,
          String website,
          String imageUrl,
          String link,
          String company,
          String description,
          String productType,
          int price}) =>
      ProductDbData(
        productid: productid ?? this.productid,
        title: title ?? this.title,
        website: website ?? this.website,
        imageUrl: imageUrl ?? this.imageUrl,
        link: link ?? this.link,
        company: company ?? this.company,
        description: description ?? this.description,
        productType: productType ?? this.productType,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('ProductDbData(')
          ..write('productid: $productid, ')
          ..write('title: $title, ')
          ..write('website: $website, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('link: $link, ')
          ..write('company: $company, ')
          ..write('description: $description, ')
          ..write('productType: $productType, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      productid.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              website.hashCode,
              $mrjc(
                  imageUrl.hashCode,
                  $mrjc(
                      link.hashCode,
                      $mrjc(
                          company.hashCode,
                          $mrjc(
                              description.hashCode,
                              $mrjc(
                                  productType.hashCode, price.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductDbData &&
          other.productid == this.productid &&
          other.title == this.title &&
          other.website == this.website &&
          other.imageUrl == this.imageUrl &&
          other.link == this.link &&
          other.company == this.company &&
          other.description == this.description &&
          other.productType == this.productType &&
          other.price == this.price);
}

class ProductDbCompanion extends UpdateCompanion<ProductDbData> {
  final Value<int> productid;
  final Value<String> title;
  final Value<String> website;
  final Value<String> imageUrl;
  final Value<String> link;
  final Value<String> company;
  final Value<String> description;
  final Value<String> productType;
  final Value<int> price;
  const ProductDbCompanion({
    this.productid = const Value.absent(),
    this.title = const Value.absent(),
    this.website = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.link = const Value.absent(),
    this.company = const Value.absent(),
    this.description = const Value.absent(),
    this.productType = const Value.absent(),
    this.price = const Value.absent(),
  });
  ProductDbCompanion.insert({
    this.productid = const Value.absent(),
    this.title = const Value.absent(),
    this.website = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.link = const Value.absent(),
    this.company = const Value.absent(),
    this.description = const Value.absent(),
    this.productType = const Value.absent(),
    this.price = const Value.absent(),
  });
  static Insertable<ProductDbData> custom({
    Expression<int> productid,
    Expression<String> title,
    Expression<String> website,
    Expression<String> imageUrl,
    Expression<String> link,
    Expression<String> company,
    Expression<String> description,
    Expression<String> productType,
    Expression<int> price,
  }) {
    return RawValuesInsertable({
      if (productid != null) 'productid': productid,
      if (title != null) 'title': title,
      if (website != null) 'website': website,
      if (imageUrl != null) 'image_url': imageUrl,
      if (link != null) 'link': link,
      if (company != null) 'company': company,
      if (description != null) 'description': description,
      if (productType != null) 'product_type': productType,
      if (price != null) 'price': price,
    });
  }

  ProductDbCompanion copyWith(
      {Value<int> productid,
      Value<String> title,
      Value<String> website,
      Value<String> imageUrl,
      Value<String> link,
      Value<String> company,
      Value<String> description,
      Value<String> productType,
      Value<int> price}) {
    return ProductDbCompanion(
      productid: productid ?? this.productid,
      title: title ?? this.title,
      website: website ?? this.website,
      imageUrl: imageUrl ?? this.imageUrl,
      link: link ?? this.link,
      company: company ?? this.company,
      description: description ?? this.description,
      productType: productType ?? this.productType,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productid.present) {
      map['productid'] = Variable<int>(productid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (productType.present) {
      map['product_type'] = Variable<String>(productType.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    return map;
  }
}

class $ProductDbTable extends ProductDb
    with TableInfo<$ProductDbTable, ProductDbData> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductDbTable(this._db, [this._alias]);
  final VerificationMeta _productidMeta = const VerificationMeta('productid');
  GeneratedIntColumn _productid;
  @override
  GeneratedIntColumn get productid => _productid ??= _constructProductid();
  GeneratedIntColumn _constructProductid() {
    return GeneratedIntColumn(
      'productid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      true,
    );
  }

  final VerificationMeta _websiteMeta = const VerificationMeta('website');
  GeneratedTextColumn _website;
  @override
  GeneratedTextColumn get website => _website ??= _constructWebsite();
  GeneratedTextColumn _constructWebsite() {
    return GeneratedTextColumn(
      'website',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  GeneratedTextColumn _imageUrl;
  @override
  GeneratedTextColumn get imageUrl => _imageUrl ??= _constructImageUrl();
  GeneratedTextColumn _constructImageUrl() {
    return GeneratedTextColumn(
      'image_url',
      $tableName,
      true,
    );
  }

  final VerificationMeta _linkMeta = const VerificationMeta('link');
  GeneratedTextColumn _link;
  @override
  GeneratedTextColumn get link => _link ??= _constructLink();
  GeneratedTextColumn _constructLink() {
    return GeneratedTextColumn(
      'link',
      $tableName,
      true,
    );
  }

  final VerificationMeta _companyMeta = const VerificationMeta('company');
  GeneratedTextColumn _company;
  @override
  GeneratedTextColumn get company => _company ??= _constructCompany();
  GeneratedTextColumn _constructCompany() {
    return GeneratedTextColumn(
      'company',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productTypeMeta =
      const VerificationMeta('productType');
  GeneratedTextColumn _productType;
  @override
  GeneratedTextColumn get productType =>
      _productType ??= _constructProductType();
  GeneratedTextColumn _constructProductType() {
    return GeneratedTextColumn(
      'product_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        productid,
        title,
        website,
        imageUrl,
        link,
        company,
        description,
        productType,
        price
      ];
  @override
  $ProductDbTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_db';
  @override
  final String actualTableName = 'product_db';
  @override
  VerificationContext validateIntegrity(Insertable<ProductDbData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('productid')) {
      context.handle(_productidMeta,
          productid.isAcceptableOrUnknown(data['productid'], _productidMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website'], _websiteMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url'], _imageUrlMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link'], _linkMeta));
    }
    if (data.containsKey('company')) {
      context.handle(_companyMeta,
          company.isAcceptableOrUnknown(data['company'], _companyMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('product_type')) {
      context.handle(
          _productTypeMeta,
          productType.isAcceptableOrUnknown(
              data['product_type'], _productTypeMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productid};
  @override
  ProductDbData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductDbData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductDbTable createAlias(String alias) {
    return $ProductDbTable(_db, alias);
  }
}

abstract class _$ProductsDb extends GeneratedDatabase {
  _$ProductsDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ProductDbTable _productDb;
  $ProductDbTable get productDb => _productDb ??= $ProductDbTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [productDb];
}
