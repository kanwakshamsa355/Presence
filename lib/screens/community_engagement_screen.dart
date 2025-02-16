import 'package:flutter/material.dart';

void main() {
  runApp(const CommunityChatApp());
}

class CommunityChatApp extends StatelessWidget {
  const CommunityChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Community Chat',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const CommunityEngagementScreen(),
    );
  }
}

class CommunityEngagementScreen extends StatefulWidget {
  const CommunityEngagementScreen({super.key});

  @override
  _CommunityEngagementScreenState createState() => _CommunityEngagementScreenState();
}

class _CommunityEngagementScreenState extends State<CommunityEngagementScreen> {
  final List<Map<String, String>> groups = [
    {
      "name": "Beginner Gestures",
      "description": "Learn the basics of sign language gestures in this group."
    },
    {
      "name": "Intermediate Gestures",
      "description": "Enhance your skills with more complex gestures."
    },
    {
      "name": "Advanced Gestures",
      "description": "Master high-level gestures and communicate fluently."
    },
  ];

  void openGroupDetails(String groupName, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailScreen(groupName: groupName, description: description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Engagement')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: groups.map((group) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(group["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(group["description"]!),
                trailing: const Icon(Icons.arrow_forward, color: Colors.teal),
                onTap: () => openGroupDetails(group["name"]!, group["description"]!),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class GroupDetailScreen extends StatelessWidget {
  final String groupName;
  final String description;

  const GroupDetailScreen({super.key, required this.groupName, required this.description});

  void joinGroup(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChatRoomScreen(groupName: groupName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(groupName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: const TextStyle(fontSize: 16, height: 1.5)),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => joinGroup(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text("Join Group", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  final String groupName;
  const ChatRoomScreen({super.key, required this.groupName});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    messages.addAll(getInitialMessages(widget.groupName));
  }

  List<String> getInitialMessages(String groupName) {
    switch (groupName) {
      case 'Beginner Gestures':
        return ['Welcome to Beginner Gestures!', 'Let’s learn the basics together.', 'Ask any questions here!'];
      case 'Intermediate Gestures':
        return ['Welcome to Intermediate Gestures!', 'Ready to level up?', 'Feel free to share your progress!'];
      case 'Advanced Gestures':
        return ['Welcome to Advanced Gestures!', 'Master the art of gestures here.', 'Discuss complex movements!'];
      default:
        return [];
    }
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add(_messageController.text);
        autoReply(_messageController.text);
        _messageController.clear();
      });
    }
  }

  void autoReply(String message) {
    final lowerMessage = message.toLowerCase();
    Map<String, String> autoResponses = {
      'hello': 'Hi there! How can I assist you?',
      'help': 'Sure! I can help with:\n- Basic gestures\n- Advanced techniques\n- Connecting with other learners',
      'good morning': 'Good morning! Have a great day!',
      'how are you': 'I’m a chatbot, but I’m here to help! How are you?',
      'thank you': 'You’re welcome! Let me know if you need anything else.',
      'bye': 'Goodbye! Keep practicing your gestures!',
    };

    for (var key in autoResponses.keys) {
      if (lowerMessage.contains(key)) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            messages.add(autoResponses[key]!);
          });
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.groupName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        messages[index],
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.teal),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
