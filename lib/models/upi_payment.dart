
import '../utils/images.dart';

List<UpiPayment> upiPaymentData = upiPaymentList();

class UpiPayment {
  String? paymentUrl;
  String? paymentName;

  UpiPayment({this.paymentUrl, this.paymentName});
}

List<UpiPayment> upiPaymentList() {
  List<UpiPayment> dataList = [];

  dataList.add(UpiPayment(paymentUrl: paytm, paymentName: "Paytm"));
  dataList.add(UpiPayment(paymentUrl: phonePay, paymentName: "PhonePe"));
  dataList.add(UpiPayment(paymentUrl: amazonPay, paymentName: "Amazon Pay"));
  dataList.add(UpiPayment(paymentUrl: freeCharge, paymentName: "Free charge"));
  dataList.add(UpiPayment(paymentUrl: olaMoney, paymentName: "Ola Money"));

  return dataList;
}
