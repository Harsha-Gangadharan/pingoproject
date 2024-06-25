class Complaints {
  String sellerId;
  String productid;
  int count;
  // String? docId;

  Complaints({
    required this.sellerId,
    required this.productid,
    required this.count,
      // this.docId,
  });

  factory Complaints.fromJson(Map<String, dynamic> json) {
    return Complaints(
      sellerId: json['sellerId'] ?? '',
      productid: json['productid'] ?? '',
      count: json['count'] ?? 0,
      // docId: json['docId'] ?? '',
    );
  }

  Map<String, dynamic> toJson( ) {
    return {
      'sellerId': sellerId,
      'productid': productid,
      'count': count,
      // 'docId': docId,
    };
  }
}
