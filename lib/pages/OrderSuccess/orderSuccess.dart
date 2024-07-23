import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/mainPage.dart';
import 'package:movie/pages/bookingHistory/bookingHistory.dart';
import 'package:movie/pages/homePage/homePage.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/orderSuccess.png',
                  height: 250,
                ),
                const Text(
                  'Đặt vé thành công!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Cảm ơn bạn đã đặt vé!!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        )),
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 30, right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const BookHistoryPage();
                        }));
                      },
                      child: const Text('Vé Của Tôi'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Homepage();
                    }));
                  },
                  child: Container(
                    child: const Text(
                      'Quay lại trang chủ!',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
