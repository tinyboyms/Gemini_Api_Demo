import 'package:flutter/material.dart';
import 'package:gemini/Models/contentProvider.dart';
import 'package:gemini/Models/dimension.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dimension = Provider.of<Dimension>(context, listen: false);
      final size = MediaQuery.of(context).size;
      dimension.setScreenSize(size.height, size.width);
    });

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dimension = Provider.of<Dimension>(context);
    final provider = Provider.of<ContentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini API Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(dimension.height * 0.03),
        child: Column(
          children: [
            TextField(
              controller: provider.controller,
              decoration: const InputDecoration(
                labelText: 'Enter your prompt',
              ),
            ),

            SizedBox(height: dimension.height * 0.01),

            SizedBox(height: dimension.height * 0.02),

            //generate content btn

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await provider.generateContent();
                  },
                  child: const Text('Generate Content'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (provider.result != null &&
                        provider.result!.isNotEmpty) {
                      provider
                          .clearResult(); // Clear the result using the model
                    }
                  },
                  child: const Text('Clear Result'),
                ),
              ],
            ),

            SizedBox(height: dimension.height * 0.01),

            provider.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Text(provider.result.toString()),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
