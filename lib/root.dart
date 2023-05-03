class Root {
    int? productId;
    String? productName;
    String? brandName;
    String? category;
    String? imageUrl;
    int? price;
    int? rating;

    Root({this.productId, this.productName, this.brandName, this.category, this.imageUrl, this.price, this.rating}); 

    Root.fromJson(Map<String, dynamic> json) {
        productId = json['ProductId'];
        productName = json['ProductName'];
        brandName = json['BrandName'];
        category = json['Category'];
        imageUrl = json['ImageUrl'];
        price = json['Price'];
        rating = json['Rating'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['ProductId'] = productId;
        data['ProductName'] = productName;
        data['BrandName'] = brandName;
        data['Category'] = category;
        data['ImageUrl'] = imageUrl;
        data['Price'] = price;
        data['Rating'] = rating;
        return data;
    }
}
