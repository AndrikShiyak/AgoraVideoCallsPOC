import 'package:agora_test_app/preview_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _appIdController = TextEditingController();
  final _tokenController = TextEditingController();
  final _channelNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _appIdController.dispose();
    _tokenController.dispose();
    _channelNameController.dispose();
  }

  void _connect() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PreviewScreen(
          appId: _appIdController.text.trim(),
          token: _tokenController.text.trim(),
          channelName: _channelNameController.text.trim(),
        ),
      ),
    );
  }

  String? _validate(String? value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get started with Video Calling'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: _appIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'App ID',
                ),
                validator: (value) => _validate(value, 'Enter App ID'),
              ),
              TextFormField(
                controller: _tokenController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Token',
                ),
                validator: (value) => _validate(value, 'Enter Token'),
              ),
              TextFormField(
                controller: _channelNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Channel Name',
                ),
                validator: (value) => _validate(value, 'Enter Channel Name'),
              ),
              ElevatedButton(
                onPressed: _connect,
                child: const Text("Connect"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
