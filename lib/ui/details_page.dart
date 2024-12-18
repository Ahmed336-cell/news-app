import 'package:flutter/material.dart';
import 'package:news/model/news/news.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.newsArt});
  final NewsArt newsArt;

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(newsArt.url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }else{
      throw 'Could not launch ${newsArt.url}';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(newsArt.urlToImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                newsArt.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Author
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "By ${newsArt.author}",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Expandable Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  Text(
                    newsArt.description,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),

            ),
            const SizedBox(height: 20),

            // Open Link Button
            Center(
              child: ElevatedButton(
                onPressed: _launchURL,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  "Read Full Article",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
