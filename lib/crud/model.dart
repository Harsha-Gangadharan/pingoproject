class ReportModel {
  String productId;
  String userId;

  String sellerId;
  String? id;
    int count;
  ReportModel({
    required this.productId,
    required this.id,
    required this.sellerId,
    required this.userId,
        required this.count, 
  });
  Map<String, dynamic> data(docId) => {
        'productId': productId,
        'userId': userId,
        'sellerId': sellerId,
        'id': id,
                'count': count ,
      };
  factory ReportModel.fromData(Map<String, dynamic> i) {
    return ReportModel(
        productId: i['productId'],
        id: i['id'],
        sellerId: i['sellerId'],
        
        userId: i['userId'],
        count: i['count']); 
        
  }
}
