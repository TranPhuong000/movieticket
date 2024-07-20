import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBookingHistory extends StatelessWidget {
  final Map<String, dynamic> ve;

  const DetailBookingHistory({Key? key, required this.ve}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('from detailBookingHistory $ve');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết vé'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Image.network(
                  ve['hinhAnh'],
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ve['tenPhim'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Text('4.9'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Thời Lượng: ${ve['thoiLuongPhim']} min'),
                      const SizedBox(height: 8),
                      Text(
                        'Ngày đặt vé: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(ve['ngayDat']))}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            _buildInfoRow('Mã ID:', ve['maVe'].toString()),
            _buildInfoRow('Rạp:', '${ve['tenCumRap']} - ${ve['tenRap']}'),
            _buildInfoRow('Số ghế:', _formatSeats(ve['danhSachGhe'])),
            _buildInfoRow('Số lượng:', '1'),
            _buildInfoRow('Tổng thanh toán:', '${ve['giaVe']} VND'),
            _buildInfoRow('Giảm giá:', '0 VND'),
            _buildInfoRow('Còn lại:', '${ve['giaVe']} VND'),
            const Divider(height: 32),
            Center(
              child: Image.asset(
                'assets/images/qr.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'ID Order\n22081996',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSeats(List<dynamic> seats) {
    return seats.map((seat) => seat['tenGhe']).join(', ');
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
