// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_api_res_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.article});
  final Article? article;

  @override
  Widget build(BuildContext context) {
    // var article;
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: const Color.fromARGB(255, 129, 116, 116),
          ),
          // color: Colors.grey.shade100,
          child: Column(
            children: [
              article?.urlToImage == null || article?.urlToImage == ""
                  ? SizedBox()
                  : Container(
                      height: 200,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: "${article?.urlToImage}",
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
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
              Text("${article?.title?.toUpperCase()}"),
              Text(
                "${article?.description?.toUpperCase()}",
                style: TextStyle(fontSize: 10),
              ),
              Text(
                "${article?.content?.toUpperCase()}",
                style: TextStyle(fontSize: 10),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    !await launchUrl(Uri.parse(article?.url ?? ""));
                  },
                  child: Text("Read More"))
            ],
          ),
        ));
  }
}
