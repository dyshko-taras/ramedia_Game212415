import 'package:flutter/material.dart';

/// A minimal debug/placeholder page used during early phases.
/// Shows a title and the current route for quick manual verification.
class DebugPlaceholderPage extends StatelessWidget {
  const DebugPlaceholderPage({
    super.key,
    required this.title,
    this.note,
  });

  final String title;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Route: ${ModalRoute.of(context)?.settings.name ?? '<unknown>'}',
              style: theme.textTheme.bodyMedium,
            ),
            if (note != null) ...[
              const SizedBox(height: 8),
              Text(note!, style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
