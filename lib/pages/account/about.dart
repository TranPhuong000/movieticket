import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Về Chúng Tôi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[800], // AppBar màu đỏ đậm
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeaderImage(),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Giới Thiệu'),
            const SizedBox(height: 8.0),
            _buildSectionContent(
                'Ticket Trove là rạp chiếu phim hàng đầu, cung cấp những trải nghiệm điện ảnh tuyệt vời với công nghệ tiên tiến và dịch vụ khách hàng hoàn hảo.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Sứ Mệnh'),
            const SizedBox(height: 8.0),
            _buildSectionContent(
                'Sứ mệnh của chúng tôi là mang đến cho khán giả những khoảnh khắc tuyệt vời, những cảm xúc chân thật và những trải nghiệm không thể quên qua từng bộ phim.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Tầm Nhìn'),
            const SizedBox(height: 8.0),
            _buildSectionContent(
                'Tầm nhìn của chúng tôi là trở thành rạp chiếu phim hàng đầu trong khu vực, là điểm đến lý tưởng cho những ai yêu điện ảnh.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Giá Trị Cốt Lõi'),
            const SizedBox(height: 8.0),
            _buildSectionContent(
                'Chất lượng, sáng tạo, và khách hàng là trung tâm. Chúng tôi cam kết đem lại chất lượng dịch vụ tốt nhất, luôn sáng tạo trong mọi hoạt động và đặt khách hàng làm trọng tâm của mọi quyết định.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Liên Hệ'),
            const SizedBox(height: 8.0),
            _buildSectionContent(
                'Địa chỉ: 123 Đường ABC, Quận 1, TP. HCM\nĐiện thoại: 0123 456 789\nEmail: info@tickettrove.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/Logo-removebg.png'), // Thay bằng đường dẫn tới hình ảnh của bạn
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.white70,
        height: 1.5,
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: AboutUsPage()));
}
