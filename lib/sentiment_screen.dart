import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentiment_analysis/Sentiment_provider.dart';

class SentimentScreen extends StatelessWidget {
  const SentimentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SentimentProvider sentimentProvider = context.watch<SentimentProvider>();

    String status = sentimentProvider.status;

    TextEditingController controller = TextEditingController();

    String emoji = "😊";
    Color color = Colors.green;

    switch (status.toLowerCase()) {
      case 'positive':
        emoji = '😊';
        color = Colors.green;

      case 'negative':
        emoji = '😠';
        color = Colors.red;

      case 'neutral':
        emoji = '😐';
        color = Colors.yellow;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "Sentimental Analysis",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              maxLines: 2,
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Enter a text...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: sentimentProvider.isLoading
                  ? null
                  : () {
                      context
                          .read<SentimentProvider>()
                          .analyzeSentiment(controller.text);
                    },
              label: Text(
                sentimentProvider.isLoading ? 'Analyzing....' : 'Analyze',
                style: TextStyle(fontSize: 16),
              ),
              icon: Icon(
                Icons.analytics_outlined,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                  foregroundColor: Colors.white),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              // height: 200,
              // width: 200,
              padding: EdgeInsets.all(45),
              decoration: BoxDecoration(
                  color: color.withValues(alpha: .3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color, width: 3)),
              child: Column(
                children: [
                  Text(
                    emoji,
                    style: TextStyle(fontSize: 45),
                  ),
                  Text(
                    status,
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
