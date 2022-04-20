import 'dart:async';
import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_progress_type.dart';
import 'package:movie_infos/home/cubit/carousel_cubit.dart';
import 'package:movie_infos/models/tv_popylar_model.dart';
import 'package:movie_infos/outils/app_colors.dart';
import 'package:movie_infos/outils/app_future_builder.dart';
import 'package:movie_infos/widgets/glass_morphism.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late TMDB tmdb;

  late TextEditingController _searchController;

  @override
  void initState() {
    tmdb = TMDB(
      ApiKeys(
        dotenv.env['API_KEY']!,
        dotenv.env['apiReadAccessTokenv4']!,
      ),
    );
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double hieghtScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Infos"),
        actions: [
          IconButton(
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
            icon: AdaptiveTheme.of(context).mode.isDark
                ? const Icon(Icons.toggle_off)
                : const Icon(Icons.toggle_on),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: GlassMorphism(
              blur: 5,
              opacity: .1,
              radius: 5,
              child: SizedBox(
                height: hieghtScreen * .06,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          debugPrint(
                              AdaptiveTheme.of(context).mode.isDark.toString());
                        },
                      ),
                      hintText:
                          "Rechercher un films, une émissions télévisées et un artistes ...",
                      hintStyle: const TextStyle(
                        color: AppColors.grayScale,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: hieghtScreen * .025,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: RichText(
              text: TextSpan(
                text: "Populaires",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                children: const [
                  TextSpan(
                    text: " à la télévision",
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: hieghtScreen * .025,
          ),
          AppFutureBuilder<Map<dynamic, dynamic>>(
            future: tmdb.v3.tv.getPopular(),
            onSuccess: (data) {
              List<Map<dynamic, dynamic>> result =
                  List<Map<dynamic, dynamic>>.from(data!['results']);

              return Center(
                child: SizedBox(
                  height: hieghtScreen * .65, // card height
                  child: PageView.builder(
                    itemCount: result.length,
                    controller: PageController(
                      viewportFraction: .8,
                    ),
                    onPageChanged: (index) {
                      context.read<CarouselCubit>().nextpage(index);
                    },
                    itemBuilder: (_, i) {
                      var map = result[i] as Map<String, dynamic>;
                      TVPopularModel populatTV = TVPopularModel.fromMap(map);
                      var url = tmdb.images.getUrl(populatTV.posterPath);

                      return BlocBuilder<CarouselCubit, CarouselState>(
                        builder: (context, state) {
                          return AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            child: Transform.scale(
                              scale: i == state.currentIndex ? 1 : 0.9,
                              child: Transform.rotate(
                                angle: i == state.currentIndex
                                    ? 0
                                    : state.currentIndex == i + 1
                                        ? -0.05
                                        : state.currentIndex == i - 1
                                            ? 0.05
                                            : 0,
                                child: Transform.translate(
                                  offset: Offset(
                                    0,
                                    state.currentIndex == i ? 0 : 30,
                                  ),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    url!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: GFProgressBar(
                                                      circleWidth: 6,
                                                      fromRightToLeft: true,
                                                      margin: EdgeInsets.zero,
                                                      padding: EdgeInsets.zero,
                                                      percentage: populatTV
                                                                  .voteArage ==
                                                              0
                                                          ? 1
                                                          : populatTV
                                                                  .voteArage /
                                                              10,
                                                      radius: 50,
                                                      type: GFProgressType
                                                          .circular,
                                                      backgroundColor:
                                                          Colors.black,
                                                      progressBarColor:
                                                          populatTV.voteArage ==
                                                                  0
                                                              ? GFColors.DANGER
                                                              : AppColors
                                                                  .primary,
                                                      child: Center(
                                                        child: Text(
                                                          "${(populatTV.voteArage * 10).toInt().toString()} %",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 2,
                                                      horizontal: 1,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            populatTV.name,
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 21,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            populatTV
                                                                .firstAirDate,
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
