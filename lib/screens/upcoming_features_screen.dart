import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Upcoming Features',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              FeatureCard(
                title: 'Transaction templates',
                text:
                    'New feature that allows you to set up custom transaction templates which can be reused',
              ),
              SizedBox(height: 15),
              FeatureCard(
                title: 'Planed transactions',
                text:
                    'New feature that allows you to set up planed transactions that will be executed at certain date in the future.',
              ),
              FeatureCard(
                title: 'Further spendings statistics',
                text: 'Additional statistics features alongside current ones.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String text;

  const FeatureCard({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
