import 'package:flutter/material.dart';

class BlogsScreen extends StatelessWidget {
  BlogsScreen({super.key});

  final List<Map<String, String>> blogs = [
    {
      "title": "Understanding Sign Language",
      "description": "Sign language is a vital tool for communication...",
      "content": "Sign language is a vital tool for communication among the deaf community. It consists of gestures, facial expressions, and body movements..."
    },
    {
      "title": "Advancements in Gesture Recognition",
      "description": "Recent AI-powered tools are improving gesture recognition...",
      "content": "Recent AI-powered tools are improving gesture recognition, enabling better communication between sign language users and non-signers..."
    },
    {
      "title": "How to Learn Sign Language Easily",
      "description": "Learning sign language can be easy with these tips...",
      "content": "Learning sign language can be easy with the right approach, including online courses, practice with native signers, and using gesture apps..."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        backgroundColor: const Color(0xFF24988F),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                blogs[index]["title"]!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(blogs[index]["description"]!),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailScreen(blog: blogs[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BlogDetailScreen extends StatelessWidget {
  final Map<String, String> blog;
  
  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog["title"]!),
        backgroundColor: const Color(0xFF24988F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          blog["content"]!,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
