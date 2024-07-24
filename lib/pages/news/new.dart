import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie/pages/news/detailNews.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final List<dynamic> Review = [
    {
      "image": "https://i.imgur.com/cp0kb1t.jpeg",
      "title": "Cù lao xác sống là phim hay nhất 2022.",
      "content":
          "Bộ phim xoay quanh hành trình của một nhóm người cùng nhau sinh tồn và cố gắng thoát khỏi sự truy đuổi của xác sống để đến chuyến phà cuối cùng ở một cù lao, hạ lưu sông Mê Kông khi đại dịch xác sống diễn ra tại đây. Công là một thầy thuốc đông y nhưng đã mất dần niềm tin vào con người, anh đã quyết định cùng cha và con gái rời khỏi cù lao này. Trong chạy trốn, họ đã thất lạc nhau, Công đi tìm đứa con gái của mình thì vô tình gặp những người khác trên con đường giành giật lại sự sống của mình",
      "like": "100",
      "cmt": "9",
    },
    {
      "image": "https://i.imgur.com/JlQSd8E.jpeg",
      "title": "'Nhà Bà Nữ' đạt doanh thu khủng tại Mỹ.",
      "content":
          "Trên trang cá nhân, Trấn Thành hào hứng chia sẻ: Không biết dùng lời lẽ gì để cảm ơn quý vị nữa đây vì quý vị quá tuyệt vời rồi. Đây là một kỷ lục, kỳ tích dành cho ê-kíp làm phim Nhà bà Nữ lẫn lịch sử phim chiếu rạp tại Việt Nam. Trấn Thành một lần nữa cảm ơn tất cả quý vị đã chọn Nhà bà Nữ và cho Trấn Thành thêm động lực để làm nhiều phim hay hơn nữa Nam nghệ sĩ cũng cho biết trước đây, để chạm đến con số 427 tỷ đồng, phim Bố già đã mất đến 7 tuần. Trong khi đó, Nhà bà Nữ chỉ mất 17 ngày để đạt đến con số 400 tỷ đồng. Không chỉ vậy, phim vẫn đang chiếu tại rạp với tần suất khán giả đến xem rất đông.",
      "like": "10",
      "cmt": "9",
    },
    {
      "image": "https://i.imgur.com/d0UCzn1.jpeg",
      "title": "Huyền Sử Vua Đinh Cán mốc doanh thu 100 tỷ.",
      "content":
          "100 tỷ đồng là con số không hề nhỏ. Đó còn là sự công nhận những cống hiến nghệ thuật của tập thể đoàn phim - Fanpage chính thức viết.Đạo diễn Lưu Thành Luân cũng bày tỏ sự xúc động và rất biết ơn những người đã cho anh cơ hội được làm đạo diễn của một phim điện ảnh. Trên trang cá nhân, đạo diễn Võ Thanh Hòa - người đảm nhận vai trò cố vấn nghệ thuật của phim cũng chia sẻ: Sau 37 ngày cố gắng không ngừng nghỉ, cùng với sự yêu thương của khán giả! Chúng ta đã làm được. Giờ là lúc giữ đôi chân dưới mặt đất, giữ con tim nóng như lúc bắt đầu, giữ cái đầu lạnh để luôn đưa ra những quyết định đúng đắn. Ê-kíp chúng ta bắt tay vào dự án tiếp theo nàoTính đến tối 28-1, Quỷ cẩu vẫn đứng đầu doanh thu phòng vé trong ngày với gần 1,2 tỷ đồng tiền vé đã bán ra. Nhiều khả năng, phim sẽ kết thúc vị trí số 1 tuần thứ 5 liên tiếp trên bảng xếp hạng doanh thu phòng vé. Điều này cũng đồng nghĩa, bộ phim sẽ vượt qua kỷ lục trước đó của Nhà bà Nữ, xác lập vào mùa Tết 2023.",
      "like": "90",
      "cmt": "9",
    },
    {
      "image": "https://i.imgur.com/tgk5dQE.png",
      "title": "Chị Chị Em Em gây thất vọng vì không có cảnh nóng.",
      "content":
          "Bộ phim xoay quanh gia đình Thiên Kim – một MC nổi tiếng, tài năng của chương trình “Thú tội đêm khuya”. Một khán giả thường xuyên của chương trình này là Em Gái – có hoàn cảnh rất khó khăn với cái thai 3 tháng, không nhà không cửa và suýt bị cưỡng bức. Thiên Kim đã tìm gặp Em Gái và đưa cô gái trẻ về nhà mình. Từ đây những sự việc kỳ lạ, đáng sợ bắt đầu xuất hiện xung quanh Em Gái cũng như Thiên Kim và chồng cô.",
      "like": "999",
      "cmt": "1299",
    },
    {
      "image": "https://i.imgur.com/azu8Bj4.jpeg",
      "title": "Bố già là phim Việt hot nhất 2023.",
      "content":
          "Không có bộ phim nào là hoàn hảo, và tất nhiên Bố Già khi gần kết phim lại có nhiều phân đoạn khiến khán giả không thỏa mãn. Đó là khi cuối phim lại xuất hiện một nhân vật ngồi khuyên nhủ lê thê dài dòng. Hay các phân cảnh đại gia đình tập hợp phong cách Avengers, hiệu ứng slow motion, sấm sét đì đùng như các webdrama rẻ tiền, lệch hẳn so với nguyên bộ phim điện ảnh chất lượng. Diễn xuất của diễn viên Tuấn Trần xuyên suốt bộ phim vẫn chưa có sự đồng đều, ổn định. Nhiều phân đoạn Tuấn Trần thể hiện rất tốt, nhưng ngược lại nhiều phân đoạn lại rất gượng gạo, chưa tới, khiến khán giả không đồng cảm được với tâm lý nhân vật.",
      "like": "1",
      "cmt": "4",
    },
    {
      "image": "https://i.imgur.com/ztZHabY.jpeg",
      "title": "Hít drama mới với Seo Ye Ji.",
      "content":
          "Bộ phim kinh dị Warning: Do Not Play là một kỷ niệm khó quên đối với Seo Ye Ji, bởi hầu hết cảnh rùng rợn của tác phẩm này đều do diễn viên tự thực hiện kèm đạo cụ, kỹ thuật hóa trang chứ không lạm dụng kỹ xảo vi tính. Warning: Do Not Play kể về nữ đạo diễn trẻ Mi Jung (Seo Ye Ji). Cô phải vật lộn lên kịch bản cho một tác phẩm kinh dị. Bí ý tưởng khi thời hạn cận kề, Mi Jung quyết tâm “đào” lại tác phẩm từng bị cấm chiếu vĩnh viễn, đó là một cuốn phim tốt nghiệp được đồn thổi do ma quỷ làm ra. Khi cuốn phim được “khai quật” cũng là lúc bi kịch bắt đầu. Ngoài việc hóa thân thành nữ chính, Seo Ye Ji còn có nhiệm vụ lồng tiếng cho con ma trong phim. Thay vì sử dụng kỹ thuật đặc biệt, nữ diễn viên dùng biện pháp tự nhiên. Tôi dùng giọng thật, cố gắng nói thật chậm, nói trong lúc tự bóp cổ chính mình để có thể phát ra thứ âm thanh rin rít trong cổ họng. Tôi đã thử rất nhiều cách nhằm mang tới giọng nói chuẩn của ma quỷ. Chúng tôi ghi lại âm thanh đó mà không cần xử lý bằng hiệu ứng gì đặc biệt”, Soompi trích lời Seo Ye Ji.Các cảnh quay của Warning: Do Not Play đa phần diễn ra tại một rạp chiếu phim bỏ hoang phủ đầy bụi. Dẫu được cho là có biểu hiện khó thở trên phim trường, Seo Ye Ji vẫn không nhờ cậy đến diễn viên đóng thế để hoàn thành các phân đoạn của mình.",
      "like": "0",
      "cmt": "0",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Tin Tức',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ],
      ),
      body: NewsPage(newsList: Review),
    );
  }
}

class NewsPage extends StatelessWidget {
  final List<dynamic> newsList;

  const NewsPage({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BreakingNewsSection(newsList: newsList),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Mới Nhất',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 3.0,
          ),
          RecentNewsSection(newsList: newsList),
        ],
      ),
    );
  }
}

class BreakingNewsSection extends StatelessWidget {
  final List<dynamic> newsList;

  const BreakingNewsSection({Key? key, required this.newsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: newsList.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      itemBuilder: (context, index, realIdx) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(newsList[index]['image']),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.1),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsList[index]['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const Text(
                    'Ticket Trove',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RecentNewsSection extends StatelessWidget {
  final List<dynamic> newsList;

  const RecentNewsSection({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailNewsPage(
                        imageUrl: newsList[index]['image']!,
                        title: newsList[index]['title']!,
                        content: newsList[index]['content']!,
                      ),
                    ),
                  );
                },
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[50],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              newsList[index]['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      newsList[index]['title']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios,
                                      size: 20, color: Colors.white),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Optionally, add a short description or other details here
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (index <
                newsList.length - 1) // Không thêm Divider sau mục cuối cùng
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 8.0,
                endIndent: 8.0,
              ),
          ],
        );
      },
    );
  }
}
