class OrderModel {
  final int id;
  final int user_id;
  final int order_list_id;
  final int product_id;
  final int quantity;
  final int vendor_id;
  final String payment_id;
  final int status_id;
  // final String follow_status_user;

  OrderModel(this.id, this.user_id, this.order_list_id, this.product_id,
      this.quantity, this.vendor_id, this.payment_id, this.status_id);
}
