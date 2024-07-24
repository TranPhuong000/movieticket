import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Trailer extends StatefulWidget {
  final String trailerUrl;
  final String imageUrl;

  const Trailer({required this.trailerUrl, required this.imageUrl});

  @override
  State<Trailer> createState() => _TrailerState();
}

class _TrailerState extends State<Trailer> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeYoutubePlayer();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  Future<void> _initializeYoutubePlayer() async {
    try {
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.trailerUrl)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } catch (e) {
      print('Error initializing YouTube player: $e');
      // Show an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'Failed to load the video trailer. Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TrailerItem(
            trailerUrl: widget.trailerUrl,
            imageUrl: widget.imageUrl,
            youtubePlayerController: _youtubePlayerController,
          ),
          // Add more TrailerItem widgets or customize further
        ],
      ),
    );
  }
}

class TrailerItem extends StatefulWidget {
  final String trailerUrl;
  final String imageUrl;
  final YoutubePlayerController youtubePlayerController;

  const TrailerItem({
    required this.trailerUrl,
    required this.imageUrl,
    required this.youtubePlayerController,
  });

  @override
  State<TrailerItem> createState() => _TrailerItemState();
}

class _TrailerItemState extends State<TrailerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  onPressed: () {
                    _playTrailer();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Watch Trailer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap to play',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8), // Adjust spacing as needed
                ElevatedButton(
                  onPressed: () {
                    _playTrailer();
                  },
                  child: Text(
                    'Play Trailer',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Center(
              child: YoutubePlayer(
                controller: widget.youtubePlayerController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.white,
                onReady: () {
                  // Optional: perform additional actions when the player is ready
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _playTrailer() {
    if (widget.youtubePlayerController.value.isReady) {
      if (widget.youtubePlayerController.value.isPlaying) {
        widget.youtubePlayerController.pause();
      } else {
        widget.youtubePlayerController.play();
      }
      setState(() {});
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// class Trailer extends StatelessWidget {
//   final String trailerUrl;
//   final String imageUrl;

//   const Trailer({required this.trailerUrl, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           TrailerItem(trailerUrl: trailerUrl, imageUrl: imageUrl),
//           // Add more TrailerItem widgets or customize further
//         ],
//       ),
//     );
//   }
// }

// class TrailerItem extends StatelessWidget {
//   final String trailerUrl;
//   final String imageUrl;

//   const TrailerItem({required this.trailerUrl, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 200,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.play_arrow,
//                     color: Colors.white,
//                     size: 50.0,
//                   ),
//                   onPressed: () {
//                     _launchURL(
//                         trailerUrl); // Gọi hàm mở đường dẫn khi nhấn vào nút
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: 10,
//             right: 10,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Watch Trailer',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Tap to play',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.8),
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 8), // Adjust spacing as needed
//                 ElevatedButton(
//                   onPressed: () {
//                     // _launchURL(
//                     //     trailerUrl); // Gọi hàm mở đường dẫn khi nhấn vào nút
//                   },
//                   child: Text(
//                     'Play Trailer',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Hàm để mở đường dẫn URL bằng trình duyệt hoặc ứng dụng khác
//   // void _launchURL(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(url);
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }
//   Future<void> _launchURL(String url) async {
//     if (await canLaunchUrlString(url)) {
//       await launchUrlString(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
