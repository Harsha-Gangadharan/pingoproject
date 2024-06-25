import 'package:cloud_firestore/cloud_firestore.dart';

class CartSummary {
  String id;
  String uid;
  List<CartItem> items;
  double total;
  Timestamp orderPlacedDate;
  String deliveryDate;
  String status;
  String paymentMode;

  CartSummary({
    required this.id,
    required this.uid,
    required this.items,
    required this.total,
    required this.orderPlacedDate,
    required this.deliveryDate,
    required this.status,
    required this.paymentMode, required int selectedOption,
  });

  factory CartSummary.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return CartSummary(
      id: data['id'] ?? '',
      uid: data['uid'] ?? '',
      items: (data['items'] as List<dynamic>)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      total: data['total'].toDouble(),
      orderPlacedDate: data['orderPlacedDate'],
      deliveryDate: data['deliveryDate'] ?? '',
      status: data['Status'] ?? '',
      paymentMode: data['paymentMode'] ?? '', selectedOption: 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'uid': uid,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'orderPlacedDate': orderPlacedDate,
      'deliveryDate': deliveryDate,
      'Status': status,
      'paymentMode': paymentMode,
    };
  }
}

class CartItem {
  String productId;
  int qty;
  double amount;
  String productImage;
  String sellerImage;
  String sellerName;
  String sellerUid;
  BuyerAddress buyerAddress;
  String paymentMode;

  CartItem({
    required this.productId,
    required this.qty,
    required this.amount,
    required this.productImage,
    required this.sellerImage,
    required this.sellerName,
    required this.sellerUid,
    required this.buyerAddress,
    required this.paymentMode,
  });

  factory CartItem.fromMap(Map<String, dynamic> data) {
    return CartItem(
      productId: data['productId'] ?? '',
      qty: data['qty'] ?? 0,
      amount: data['amount'].toDouble(),
      productImage: data['productImage'] ?? '',
      sellerImage: data['sellerImage'] ?? '',
      sellerName: data['sellerName'] ?? '',
      sellerUid: data['sellerUid'] ?? '',
      buyerAddress: BuyerAddress.fromMap(data['buyerAddress']),
      paymentMode: data['paymentMode'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'qty': qty,
      'amount': amount,
      'productImage': productImage,
      'sellerImage': sellerImage,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'buyerAddress': buyerAddress.toMap(),
      'paymentMode': paymentMode,
    };
  }
}

class BuyerAddress {
  String name;
  Address address;
  String contactNumber;

  BuyerAddress({
    required this.name,
    required this.address,
    required this.contactNumber,
  });

  factory BuyerAddress.fromMap(Map<String, dynamic> data) {
    return BuyerAddress(
      name: data['name'] ?? '',
      address: Address.fromMap(data['address']),
      contactNumber: data['contactNumber'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address.toMap(),
      'contactNumber': contactNumber,
    };
  }
}

class Address {
  String houseNumber;
  String roadAreaColony;
  String nearFamousPlace;
  String city;
  String state;
  String pincode;

  Address({
    required this.houseNumber,
    required this.roadAreaColony,
    required this.nearFamousPlace,
    required this.city,
    required this.state,
    required this.pincode,
  });

  factory Address.fromMap(Map<String, dynamic> data) {
    return Address(
      houseNumber: data['houseNumber'] ?? '',
      roadAreaColony: data['roadAreaColony'] ?? '',
      nearFamousPlace: data['nearFamousPlace'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      pincode: data['pincode'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'houseNumber': houseNumber,
      'roadAreaColony': roadAreaColony,
      'nearFamousPlace': nearFamousPlace,
      'city': city,
      'state': state,
      'pincode': pincode,
    };
  }
}
