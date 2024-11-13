import 'package:blog_flutter/apis/create_post.dart';
import 'package:blog_flutter/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Post'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Image URL (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final String title = _titleController.text;
                final String content = _contentController.text;
                final String image = _imageController.text;
                await sendPost(title, content, image);
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Save Post'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendPost(String title, String content, String image) async {
    List<dynamic> response = await createPostApiCall(title, content);
    if (response[0]) {
      ToastUtils.showToast("Successfully sended the post");
    } else {
      ToastUtils.showToast("Failed to send the Post");
    }
  }
}
