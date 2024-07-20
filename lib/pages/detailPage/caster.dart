import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Caster extends StatefulWidget {
  const Caster({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<Caster> createState() => _CasterState();
}

class _CasterState extends State<Caster> {
  final List<Cast> casts = [
    Cast(
      title: 'Robert Downey Jr.',
      image:
          'https://m.media-amazon.com/images/M/MV5BNzg1MTUyNDYxOF5BMl5BanBnXkFtZTgwNTQ4MTE2MjE@._V1_.jpg',
      description:
          'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.',
    ),
    Cast(
      title: 'Chris Evans',
      image:
          'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSAYaNvIozXqfG0QAbpCZ6cRnXJg2gdNT0puCY2f-KGHk6Z5ire',
      description:
          'When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
    ),
    Cast(
      title: 'Chris Hemsworth',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzGME_ao9C5iaCyx7uAVzBkj5ztIJYEcMFQ&s',
      description:
          'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
    ),
    Cast(
      title: 'Mark Ruffalo',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Mark_Ruffalo_%2836201774756%29_%28cropped%29.jpg/1200px-Mark_Ruffalo_%2836201774756%29_%28cropped%29.jpg',
      description:
          'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: casts
            .map((e) => Builder(
                  builder: (context) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 4),
                          child: SizedBox(
                            width: widget.size.width / 4.5,
                            height: widget.size.height / 8,
                            child: e.image.isNotEmpty
                                ? Image.network(
                                    e.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/MovieLogo.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/images/default_image.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          // decoration: const BoxDecoration(
                          //     image: DecorationImage(
                          //         image: NetworkImage(
                          //             'https://movienew.cybersoft.edu.vn/hinhanh/nobita-va-ban-giao-huong-dia-cau_gp09.jpg'),
                          //         fit: BoxFit.cover)),
                        ),
                        Text(
                          e.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}

class Cast {
  late String title;
  late String image;
  late String description;

  Cast({
    required this.title,
    required this.image,
    required this.description,
  });
}
