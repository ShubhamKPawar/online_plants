import 'package:flutter/material.dart';

class LatestTimeline extends StatefulWidget {
  const LatestTimeline({super.key});

  @override
  State<LatestTimeline> createState() => _LatestTimelineState();
}

class _LatestTimelineState extends State<LatestTimeline> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.amber,
        child: const Text('LatestTimeline'),
      ),
    );
  }
}
