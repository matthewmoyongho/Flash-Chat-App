import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  BubbleMessage({this.text, this.sender, this.isMe});
  final String? text;
  final String? sender;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: isMe!
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  sender!,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Material(
                  color: Colors.lightBlue,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Text(
                      text!,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender!,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Material(
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Text(
                      text!,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ],
            ),
    );
  }
}
