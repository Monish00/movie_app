import 'package:flutter/material.dart';
import 'package:movie_app/assets/Colors.dart';
import 'package:movie_app/classes/MoviesList.dart';
import 'package:provider/provider.dart';

import '../helpers/sqflit_provider.dart';

class ListCard {
  static Widget card(BuildContext context, MoviesList movie) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/MovieDetails', arguments: movie);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          height: 146,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.poster}',
                  height: 118,
                  width: 70,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          movie.releaseDate,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: AppColor.lightText),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.overView,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: AppColor.lightText,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<SqfliteProvider>().createItem(movie);
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
