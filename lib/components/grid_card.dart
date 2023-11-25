import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class GridCard extends StatefulWidget {
  final String gameName;
  final String imageUrl;
  final String linkUrl;
  const GridCard({
    Key? key,
    required this.gameName,
    required this.imageUrl,
    required this.linkUrl,
  }) : super(key: key);

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> with SingleTickerProviderStateMixin
{
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: Tween<double>(begin: 0, end: 1).animate(controller),
      curve: Curves.easeInOutQuad,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        launchUrl(Uri.parse(widget.linkUrl));
      },
      onHover: (e) {
        if (e) {
          controller.forward();
        } else {
          controller.reverse();
        }
      },
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Transform.scale(
              scale: 1 + (0.2 * animation.value),
              child: Container(
                // width: 240,
                // height: 350,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(widget.imageUrl),
                    fit: BoxFit.contain,
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 50 * animation.value,
                        spreadRadius: -10,
                        offset: const Offset(0, 10))
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Colors.black12,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.gameName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
