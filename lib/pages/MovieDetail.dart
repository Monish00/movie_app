import 'package:flutter/material.dart';
import 'package:movie_app/assets/Colors.dart';

import '../classes/MoviesList.dart';

class MovieDetial extends StatefulWidget {
  final MoviesList detial;
  const MovieDetial({Key? key, required this.detial}) : super(key: key);
  @override
  State<MovieDetial> createState() => _MovieDetialState();
}

class _MovieDetialState extends State<MovieDetial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            )),
        // leadingWidth: 100,
        centerTitle: true,
        title: Text(
          widget.detial.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${widget.detial.poster}',
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 396,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 10, 18, 18),
              child: Column(
                children: [
                  Text(
                    widget.detial.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.detial.releaseDate,
                        style: TextStyle(
                          color: AppColor.lightText,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Container(
                            width: 1, height: 50, color: AppColor.lightText),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.detial.language.toUpperCase(),
                        style: TextStyle(
                          color: AppColor.lightText,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rating-${widget.detial.voteAverage}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        width: 19,
                      ),
                      Text(
                        '(${widget.detial.voteCount})',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 21),
                  Row(
                    children: const [
                      Text(
                        'OverView',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.detial.overView,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
