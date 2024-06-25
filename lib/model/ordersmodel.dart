class OrderModel {
  String orderId;
  String sellerName;
  String sellerId;
  String productId;
  String productImage;
  String productName;
  double amount;
  int quantity;
  String userId;
  String userName;
  String paymentMode;
  String city;
  String houseNumber;
  String roadAreaColony;
  String nearFamousPlace;
  String state;
  String pincode;
  String contactNumber;
  String status;

  OrderModel({
    required this.orderId,
    required this.sellerName,
    required this.sellerId,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.amount,
    required this.quantity,
    required this.userId,
    required this.userName,
    required this.paymentMode,
    required this.city,
    required this.houseNumber,
    required this.roadAreaColony,
    required this.nearFamousPlace,
    required this.state,
    required this.pincode,
    required this.contactNumber,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'sellerName': sellerName,
      'sellerId': sellerId,
      'productId': productId,
      'productImage': productImage,
      'productName': productName,
      'amount': amount,
      'quantity': quantity,
      'userId': userId,
      'userName': userName,
      'paymentMode': paymentMode,
      'city': city,
      'houseNumber': houseNumber,
      'roadAreaColony': roadAreaColony,
      'nearFamousPlace': nearFamousPlace,
      'state': state,
      'pincode': pincode,
      'contactNumber': contactNumber,
      'Status': status,
    };
  }

  factory OrderModel.fromjsone(Map<String, dynamic> jsone) {
    return OrderModel(
      orderId: jsone['orderId'],
      sellerName: jsone['sellerName'],
      sellerId: jsone['sellerId'],
      productId: jsone['productId'],
      productImage: jsone['productImage'],
      productName: jsone['productName'],
      amount: jsone['amount'],
      quantity: jsone['quantity'],
      userId: jsone['userId'],
      userName: jsone['userName'],
      paymentMode: jsone['paymentMode'],
      city: jsone['city'],
      houseNumber: jsone['houseNumber'],
      roadAreaColony: jsone['roadAreaColony'],
      nearFamousPlace: jsone['nearFamousPlace'],
      state: jsone['state'],
      pincode: jsone['pincode'],
      contactNumber: jsone['contactNumber'],
      status: jsone['Status'],
    );
  }
}
