import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/MovieLogo.png"),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white, // Màu nền
                    shape: BoxShape.circle, // Hình dạng tròn
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black, // Màu biểu tượng
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
