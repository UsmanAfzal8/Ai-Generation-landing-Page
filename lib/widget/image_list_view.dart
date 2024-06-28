import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ImageListView extends StatefulWidget {
  const ImageListView(
      {required this.startIndex, required this.duration, super.key});
  final int startIndex;
  final int duration;
  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  ScrollController _scrollController = ScrollController();
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        _autoScroll();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       _autoScroll();
    });
  }

  _autoScroll() {
    final _currentScrollPosition = _scrollController.offset;
    final _scrollEndPosition = _scrollController.position.maxScrollExtent;

    scheduleMicrotask(() {
      _scrollController.animateTo(
          _currentScrollPosition == _scrollEndPosition ? 0 : _scrollEndPosition,
          duration: Duration(seconds: widget.duration),
          curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 1.96 * pi,
      child: SizedBox(
        height: 130,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _imageTile(
                image:
                    'assets/generations/image${widget.startIndex + index}.png');
          },
          itemCount: 8,
        ),
      ),
    );
  }

  Widget _imageTile({required String image}) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          image,
          width: 130,
        ),
      ),
    );
  }
}
