import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailBookingHistory extends StatelessWidget {
  final Map<String, dynamic> ve;

  const DetailBookingHistory({super.key, required this.ve});

  @override
  Widget build(BuildContext context) {
    print('from detailBookingHistory $ve');

    // Create a NumberFormat instance for currency formatting
    final currencyFormatter =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');

    // Extract tenHeThongRap from the first seat in danhSachGhe
    final String tenHeThongRap = ve['danhSachGhe'].isNotEmpty
        ? ve['danhSachGhe'][0]['tenHeThongRap']
        : '';
    final String tenRap =
        ve['danhSachGhe'].isNotEmpty ? ve['danhSachGhe'][0]['tenCumRap'] : '';
    // Convert ve data to JSON string to encode in QR code
    final String qrData = ve.toString();

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
                      const Row(
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
            _buildInfoRow('Mã vé:', ve['maVe'].toString()),
            _buildInfoRow('Hệ thống rạp:', tenHeThongRap),
            _buildInfoRow('Hệ thống rạp:', tenRap),
            _buildInfoRow('Số ghế:', _formatSeats(ve['danhSachGhe'])),
            _buildInfoRow('Số lượng:', ve['danhSachGhe'].length.toString()),
            _buildInfoRow('Giá tiền:', currencyFormatter.format(ve['giaVe'])),
            _buildInfoRow('Giảm giá:', currencyFormatter.format(0)),
            _buildInfoRow(
                'Tổng thanh toán:', currencyFormatter.format(ve['giaVe'])),
            const Divider(height: 32),
            Center(
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'ID Order\n${ve['maVe']}',
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
