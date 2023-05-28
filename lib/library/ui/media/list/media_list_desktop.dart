import 'package:flutter/material.dart';

import '../../../data/project.dart';

class MediaListDesktop extends StatefulWidget {
  final Project project;

  const MediaListDesktop(this.project, {super.key});

  @override
  MediaListDesktopState createState() => MediaListDesktopState();
}

class MediaListDesktopState extends State<MediaListDesktop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
