import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class GestureLearningScreen extends StatefulWidget {
  const GestureLearningScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GestureLearningScreenState createState() => _GestureLearningScreenState();
}

class _GestureLearningScreenState extends State<GestureLearningScreen> {
  final List<String> _languages = ['English', 'Spanish', 'French'];
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the meaning of a thumbs-up gesture?',
      'options': ['Approval', 'Disapproval', 'Confusion', 'Anger'],
      'answer': 'Approval'
    },
    {
      'question': 'Which gesture indicates stop?',
      'options': ['Thumbs-up', 'Open Palm', 'Fist', 'Finger Snap'],
      'answer': 'Open Palm'
    },
    {
      'question': 'What does a peace sign usually represent?',
      'options': ['Victory', 'Danger', 'Silence', 'Greeting'],
      'answer': 'Victory'
    },
    {
      'question': 'What does a wave gesture signify?',
      'options': ['Hello', 'Goodbye', 'Thank you', 'Sorry'],
      'answer': 'Hello'
    },
    {
      'question': 'What does a finger on lips gesture mean?',
      'options': ['Silence', 'Happiness', 'Sadness', 'Anger'],
      'answer': 'Silence'
    },
    {
      'question': 'What does a fist gesture usually represent?',
      'options': ['Strength', 'Weakness', 'Fear', 'Joy'],
      'answer': 'Strength'
    },
    {
      'question': 'What does a shrug gesture indicate?',
      'options': ['Indifference', 'Happiness', 'Sadness', 'Anger'],
      'answer': 'Indifference'
    },
    {
      'question': 'What does pointing with a finger usually mean?',
      'options': ['Accusation', 'Direction', 'Greeting', 'Questioning'],
      'answer': 'Direction'
    },
    {
      'question': 'What does a heart gesture represent?',
      'options': ['Love', 'Hate', 'Friendship', 'Respect'],
      'answer': 'Love'
    },
    {
      'question': 'What does a thumbs-down gesture mean?',
      'options': ['Approval', 'Disapproval', 'Confusion', 'Anger'],
      'answer': 'Disapproval'
    },
  ];

  final List<Map<String, dynamic>> _blogs = [
    {
      'title': 'The Power of Gestures in Communication',
      'image': 'assets/images/power.jpeg',
      'content': 'Gestures play a vital role in non-verbal communication...',
      'link': 'https://fos.cmb.ac.lk/blog/hand-gestures-and-communication/'
    },
    {
      'title': 'Understanding Hand Signals Across Cultures',
      'image': 'assets/images/handsignal.jpg',
      'content': 'Different cultures interpret hand gestures in unique ways...',
      'link': 'https://acutrans.com/understanding-non-verbal-communication-gestures-that-vary-across-cultures/'
    },
    {
      'title': 'The Psychology of Culture',
      'image': 'assets/images/physcelogy.jpeg',
      'content': 'Gestures can reveal a lot about a person’s emotions...',
      'link': 'https://open.maricopa.edu/culturepsychology/chapter/introduction-to-cultural-psychology/'
    },
    {
      'title': 'Gestures in Different Cultures',
      'image': 'assets/images/gesture.png',
      'content': 'Understanding how gestures vary across cultures is crucial...',
      'link': 'https://www.lingoda.com/blog/en/common-gestures-around-world/'
    },
    {
      'title': 'The Science Behind Gestures',
      'image': 'assets/images/behindgesture.jpg',
      'content': 'Research shows that gestures can enhance communication...',
      'link': 'https://www.quantamagazine.org/how-the-brain-links-gestures-perception-and-meaning-20190325/'
    },
  ];

  final List<String> _recentActivities = [];

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selectedLanguage');
    if (savedLanguage != null) {
      setState(() {
      });
    }
  }

  void _showLanguageSelectionDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Your Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _languages.map((lang) {
              return ListTile(
                title: Text(lang),
                onTap: () {
                  setState(() {
                  });
                  prefs.setString('selectedLanguage', lang);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

void _showIntroductionDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/intro.jpg', height: 150),
            SizedBox(height: 10),
            Text(
              'Gestures are movements of the body, particularly the hands and arms, that convey meaning and express emotions. '
              'They play a crucial role in non-verbal communication, enhancing verbal messages and providing context.\n\n'
              '1. Non-Verbal Communication: Gestures complement spoken language, conveying feelings and attitudes that words may not fully express.\n\n'
              '2. Cultural Variations: Gestures can have different meanings across cultures. For example, a thumbs-up is positive in many Western cultures but can be offensive in others.\n\n'
              '3. Enhancing Communication: They help clarify and emphasize points, making it easier for audiences to understand complex ideas.\n\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Optional: Justify text for better readability
            ),
          ],
        ),
      );
    },
  );
}
  void _startQuiz() {
    int questionIndex = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Map<String, dynamic> question = _questions[questionIndex];
            return AlertDialog(
              title: Text(question['question']),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: question['options'].map<Widget>((option) {
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      String feedback = option == question['answer'] ? 'Correct!' : 'Wrong!';
                      setState(() {
                        _recentActivities.add('Answered: ${question['question']} - $feedback');
                        questionIndex = (questionIndex + 1) % _questions.length;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(feedback)));
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  void _showBlogDialog(Map<String, dynamic> blog) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(blog['image']!, height: 150),
              SizedBox(height: 10),
              Text(blog['content']!, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse(blog['link']);
                  // ignore: deprecated_member_use
                  if (await canLaunch(url.toString())) {
                    // ignore: deprecated_member_use
                    await launch(url.toString());
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('Read More', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRecentActivities() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Recent Activities'),
          content: SizedBox(
            width: double.maxFinite,
            child: _recentActivities.isEmpty
                ? Center(child: Text('No recent activities.'))
                : ListView.builder(
                    itemCount: _recentActivities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_recentActivities[index]),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome to Hand Talker App!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF24988F))),
            SizedBox(height: 20),
            GestureCard(
              title: 'Select Your Language',
              onTap: _showLanguageSelectionDialog,
            ),
            SizedBox(height: 20),
            GestureCard(
              title: 'Introduction to Gestures',
              onTap: _showIntroductionDialog,
            ),
            SizedBox(height: 20),
            GestureCard(
              title: 'Quizzes & Challenges',
              onTap: _startQuiz,
            ),
            SizedBox(height: 20),
            GestureCard(
              title: 'Recent Activities',
              onTap: _showRecentActivities,
            ),
            SizedBox(height: 20),
            Text('Latest Blogs', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: _blogs.map((blog) {
                return GestureDetector(
                  onTap: () => _showBlogDialog(blog),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      height: 150, // Set a fixed height for the card
                      child: Row(
                        children: [
                          Container(
                            width: 100, // Set a fixed width for the image
                            height: 150, // Set a fixed height for the image
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                blog['image']!,
                                fit: BoxFit.cover, // Ensure the image covers the container
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                blog['title']!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2, // Limit the number of lines
                                overflow: TextOverflow.ellipsis, // Handle overflow
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

}

class GestureCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const GestureCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        onTap: onTap,
      ),
    );
  }
}