import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/assets/Colors.dart';
import 'package:movie_app/assets/Images.dart';
import 'package:movie_app/helpers/movie_provider.dart';
import 'package:movie_app/helpers/network_provider.dart';
import 'package:movie_app/widgets/card.dart';
import 'package:provider/provider.dart';

import '../widgets/filter_dialog.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  ScrollController scrollControl = ScrollController();
  TextEditingController search = TextEditingController();
  //MoviesProvider moviesProvider=context.read<Movies Provider>();

  @override
  void initState() {
    //movieListAdder();
    scrollControl.addListener(pagination);
    context.read<MoviesProvider>().language();
    super.initState();
  }

  @override
  void dispose() {
    scrollControl.removeListener(pagination);
    super.dispose();
  }

  Future<void> movieListAdder() async {
    (context.read<NetworkProvider>().isOnline == true)
        ? context.read<MoviesProvider>().movieListAdder(false)
        : null;
  }

  pagination() {
    if (scrollControl.offset >= scrollControl.position.maxScrollExtent) {
      if (context.read<NetworkProvider>().isOnline &&
          (context.read<MoviesProvider>().totalPages >
              context.read<MoviesProvider>().currentPage)) {
        context.read<MoviesProvider>().movieListAdder(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    NetworkProvider network = context.watch<NetworkProvider>();
    return Consumer<MoviesProvider>(
      builder: (context, provider, _) {
        (network.isOnline) ? provider.movieListAdder(false) : null;
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Movies',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  FilterDialog.filterDialog(context);
                },
                icon: const Icon(
                  Icons.filter_alt,
                  size: 25.0,
                ),
              ),
              IconButton(
                icon: (provider.sortCount % 2 == 0 && provider.sortCount != 0)
                    ? Image.asset(
                        AppImages.ascendingSort,
                        height: 25,
                        width: 25,
                      )
                    : Image.asset(
                        AppImages.descendingSort,
                        height: 25,
                        width: 25,
                      ),
                onPressed: () async {
                  (provider.sortCount % 2 != 0)
                      ? {provider.ascendingSort()}
                      : provider.descendingSort();
                },
              ),
            ],
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(14, 25, 14, 25),
            child: Column(
              children: [
                TextFormField(
                  controller: search,
                  onChanged: (value) {
                    provider.movieSearch(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: (search.text.isNotEmpty)
                        ? IconButton(
                            onPressed: () {
                              search.text = '';
                              provider.movieSearch('');
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 5,
                        color: AppColor.componentColor,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    fillColor: AppColor.componentColor,
                    hintText: 'Search Movies',
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(19, 9, 9, 19),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        color: AppColor.componentColor,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                (provider.isLoading == false)
                    ? ((provider.filteredMovies.isEmpty &&
                            provider.selectedLanguage.isNotEmpty)
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: Text('Filter is not Available'),
                            ),
                          )
                        : ((provider.searchList.isEmpty &&
                                provider.searchTitle.isNotEmpty)
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text('Search is not matched'),
                                ),
                              )
                            : (provider.moviesList.isEmpty)
                                ? SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    width: MediaQuery.of(context).size.height,
                                    child: const Center(
                                      child: Text('no Movies found'),
                                    ),
                                  )
                                : Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        if (network.isOnline) {
                                          provider.movieListAdder(false);
                                        }
                                      },
                                      child: ListView.builder(
                                        shrinkWrap: false,
                                        controller: scrollControl,
                                        itemCount: provider
                                                .filteredMovies.isNotEmpty
                                            ? provider.filteredMovies.length
                                            : (provider.searchList.isEmpty
                                                ? (provider.moviesList.length +
                                                    1)
                                                : provider.searchList.length),
                                        itemBuilder: (context, index) {
                                          return (provider
                                                  .filteredMovies.isNotEmpty)
                                              ? ListCard.card(
                                                  context,
                                                  provider
                                                      .filteredMovies[index])
                                              : (provider.searchList.isEmpty &&
                                                      search.text.isEmpty)
                                                  ? ((index ==
                                                          provider.moviesList
                                                              .length)
                                                      ? const SizedBox(
                                                          height: 100,
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        )
                                                      : ListCard.card(
                                                          context,
                                                          provider.moviesList[
                                                              index]))
                                                  : ListCard.card(
                                                      context,
                                                      provider
                                                          .searchList[index]);
                                        },
                                      ),
                                    ),
                                  )))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 230,
                        width: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                (!network.isOnline)
                    ? (Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          color: Colors.black,
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Text(
                            'you are offline',
                            style: TextStyle(color: AppColor.componentColor),
                          )),
                        ),
                      ))
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
