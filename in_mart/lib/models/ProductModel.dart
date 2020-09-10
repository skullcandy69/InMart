class Products {
  List<ProductData> data;

  Products({this.data});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ProductData>();
      json['data'].forEach((v) {
        data.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  int id;
  String title;
  int subCategoryId;
  String website;
  String imageUrl;
  String link;
  String company;
  String description;
  dynamic price;
  bool isTrending;
  bool isDod;
  bool frequentlyBought;
  String productType;
  bool isActive;
  String createdAt;
  String updatedAt;

  ProductData(
      {this.id,
      this.title,
      this.subCategoryId,
      this.website,
      this.imageUrl,
      this.link,
      this.company,
      this.description,
      this.price,
      this.isTrending,
      this.isDod,
      this.frequentlyBought,
      this.productType,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subCategoryId = json['sub_category_id'];
    website = json['website'];
    imageUrl = json['image_url'];
    link = json['link'];
    company = json['company'];
    description = json['description'];
    price = json['price'];
    isTrending = json['is_trending'];
    isDod = json['is_dod'];
    frequentlyBought = json['frequently_bought'];
    productType = json['product_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_category_id'] = this.subCategoryId;
    data['website'] = this.website;
    data['image_url'] = this.imageUrl;
    data['link'] = this.link;
    data['company'] = this.company;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_trending'] = this.isTrending;
    data['is_dod'] = this.isDod;
    data['frequently_bought'] = this.frequentlyBought;
    data['product_type'] = this.productType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
