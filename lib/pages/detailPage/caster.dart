// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:movie/pages/homePage/homePage.dart';

// class Caster extends StatelessWidget {
//   const Caster({
//     super.key,
//     required this.size,
//   });

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: casts
//             .map((e) => Builder(
//                   builder: (context) {
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10, bottom: 4),
//                           child: SizedBox(
//                             width: size.width / 4.5,
//                             height: size.height / 8,
//                             child: e.image.isNotEmpty
//                                 ? Image.network(
//                                     e.image,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Image.asset(
//                                         'assets/images/MovieLogo.png',
//                                         fit: BoxFit.cover,
//                                       );
//                                     },
//                                   )
//                                 : Image.asset(
//                                     'assets/images/default_image.png',
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                           // decoration: const BoxDecoration(
//                           //     image: DecorationImage(
//                           //         image: NetworkImage(
//                           //             'https://movienew.cybersoft.edu.vn/hinhanh/nobita-va-ban-giao-huong-dia-cau_gp09.jpg'),
//                           //         fit: BoxFit.cover)),
//                         ),
//                         Text(
//                           e.title,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.white),
//                         )
//                       ],
//                     );
//                   },
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
