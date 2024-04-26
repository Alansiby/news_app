// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/home_screen_controller.dart';
import 'package:news_app/view/news_screen/news_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().getDataByCategory();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenController>();
    return DefaultTabController(
      length: HomeScreenController.categoryList.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            onTap: (value) {
              context.read<HomeScreenController>().onCategorySelection(value);
            },
            tabs: List.generate(
              HomeScreenController.categoryList.length,
              (index) => Tab(
                child: Text(
                    "${HomeScreenController.categoryList[index].toUpperCase()}"),
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     context.read<HomeScreenController>().getData();
        //   },
        // ),
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                padding:
                    EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
                itemCount: provider.resModel?.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  return
                      // ListTile(
                      //   title:
                      //       Text(provider.resModel?.articles?[index].title ?? ""),
                      // );
                      InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsScreen(
                                article: provider.resModel?.articles?[index]),
                          ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 129, 116, 116),
                      ),
                      // color: Colors.grey.shade100,
                      child: Column(
                        children: [
                          provider.resModel?.articles?[index].urlToImage ==
                                      null ||
                                  provider.resModel?.articles?[index]
                                          .urlToImage ==
                                      ""
                              ? SizedBox()
                              : Container(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${provider.resModel?.articles?[index].urlToImage}",
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    // Image.network(
                                    //     fit: BoxFit.cover,
                                    //     "${provider.resModel?.articles?[index].urlToImage}"),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "${provider.resModel?.articles?[index].title?.toUpperCase()}"),
                          Text(
                            "${provider.resModel?.articles?[index].description?.toUpperCase()}",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    )),
      ),
    );
  }
}
