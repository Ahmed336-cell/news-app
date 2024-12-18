import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:news/model/news/news.dart';
import 'package:news/network/news_api.dart';

import 'details_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<NewsArt>> news;
  String newsName = "BBC";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNews();
  }

  void fetchNews() {
    setState(() {
      news = NewsApi().fetchNews(newsName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          children: [

            const SizedBox(
              height: 20,
            ),
             Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    NewsLabels(image: 'assets/bbc.png', name: 'BBC',
                    isSelected: newsName == 'BBC',
                      onTap: () {
                        setState(() {
                          newsName = 'BBC';
                          fetchNews();
                        });
                      },

                    ),
                    NewsLabels(image: 'assets/cnn.png', name: 'CNN',
                    isSelected: newsName == 'CNN',
                      onTap: () {
                        setState(() {
                          newsName = 'CNN';
                          fetchNews();
                        });
                      },
                    ),
                    NewsLabels(image: 'assets/newyork.png', name: 'NewYork Times',
                    isSelected: newsName == 'NewYork Times',
                      onTap: () {
                        setState(() {
                          newsName = 'NewYork Times';
                          fetchNews();
                        });
                      },
                    ),
                    NewsLabels(image: 'assets/skynews.jpg', name: 'Sky News',
                    isSelected: newsName == 'Sky News',
                      onTap: () {
                        setState(() {
                          newsName = 'Sky News';
                          fetchNews();
                        });
                      },
                    ),

                  ],
                ),
              ),
            ),

            const Divider(indent: 16,endIndent: 16, thickness: 3,),

            const Text("Top News", style: TextStyle(color: Colors.white, fontSize: 34,
              fontWeight: FontWeight.bold,
            ),),
            FutureBuilder<List<NewsArt>>(
              future: news,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final article = snapshot.data![index];
                        return NewsCard(
                          image: article.urlToImage,
                          title: article.title,
                          author: article.author,
                          date: article.publishedAt,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(newsArt: article),),);
                          },
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },

            )
          ],
        ),
      ),
    );
  }
}
class NewsLabels extends StatelessWidget {
  const NewsLabels({super.key, required this.image, required this.name, required this.isSelected, required this.onTap});

 final String image;
 final String name;
 final bool isSelected;
 final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
                backgroundColor: isSelected ? Colors.green : Colors.grey, // Highlight color
                radius: 40,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(image),
                )
            ),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 18),

            )
          ],
        ),
      ),
    );
  }
}
class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.image, required this.author, required this.date, required this.title, required this.onTap}) : super(key: key);
  final String image;
  final String author;
  final String date;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                image, // Replace with your image path
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
            ),

            // Content
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        author,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // News Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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