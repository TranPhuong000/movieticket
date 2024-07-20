import 'package:flutter/material.dart';
import 'package:movie/pages/homePage/homePage.dart';
import 'package:movie/pages/selectCinema/selectCinamaPage.dart';

class ComingSoon extends StatelessWidget {
  ComingSoon({
    super.key,
  });

  final List<dynamic> _movies = [
    {
      'title': 'Avengers',
      'image':
          'https://movienew.cybersoft.edu.vn/hinhanh/avengers-endgame_gp01.jpg',
      'description':
          'When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
      'duration': '1 giờ 55 phút'
    },
    {
      'title': 'Tấm vé đến thiên đường',
      'image':
          'https://movienew.cybersoft.edu.vn/hinhanh/tam-ve-den-thien-duong_gp01.png',
      'description':
          'When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
      'duration': '1 giờ 40 phút'
    },
    {
      'title': 'Đất rừng phương Nam',
      'image':
          'https://movienew.cybersoft.edu.vn/hinhanh/dat-rung-phuong-nam_gp01.jpg',
      'description':
          'When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
      'duration': '1 giờ 45 phút'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        children: movies
            .map((e) => Builder(
                  builder: (context) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const SelectCinemaPage()),
                          // );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 200, // Đặt chiều rộng cố định cho hình ảnh
                          height: 180, // Đặt chiều cao cố định cho hình ảnh
                          child: Image.network(
                            e.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}

class Movie {
  late String title;
  late String image;
  late String description;

  Movie({
    required this.title,
    required this.image,
    required this.description,
  });
}

final List<Movie> movies = [
  Movie(
    title: 'Đất rừng phương Nam',
    image:
        'https://movienew.cybersoft.edu.vn/hinhanh/dat-rung-phuong-nam_gp01.jpg',
    description:
        'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.',
  ),
  Movie(
    title: 'Money Heist',
    image: 'https://movienew.cybersoft.edu.vn/hinhanh/money-heist_gp03.jpg',
    description:
        'When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
  ),
  Movie(
    title: 'Tấm vé đến thiên đường',
    image:
        'https://movienew.cybersoft.edu.vn/hinhanh/tam-ve-den-thien-duong_gp01.png',
    description:
        'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
  ),
];
