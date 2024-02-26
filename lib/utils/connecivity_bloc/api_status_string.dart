

class ApiString{
  // order status
  static const String pendingOrder = 'pending';
  static const String approvedOrder = 'approved';
  static const String rejectOrder = 'reject';
  static const String completedOrder = 'completed';
  static const String deliveredOrder = 'delivered';

  // payment status
  static const String pendingPayment = 'pending';
  static const String partialPaymentPayment = 'partial_payment';
  static const String completedPayment = 'completed';
  static const String halfPayment = 'half_complete';

}