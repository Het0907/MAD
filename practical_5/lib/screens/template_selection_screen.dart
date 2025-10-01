import 'package:flutter/material.dart';
import 'package:practical_5/screens/resume_form_screen.dart';

class TemplateSelectionScreen extends StatelessWidget {
  const TemplateSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Template'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: templates.length,
          itemBuilder: (context, index) {
            final template = templates[index];
            return GestureDetector(
              onTap: () => _selectTemplate(context, template),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: template.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Icon(
                          template.icon,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              template.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              template.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _selectTemplate(BuildContext context, ResumeTemplate template) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${template.name} Template'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(template.description),
              const SizedBox(height: 16),
              const Text(
                'Features:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...template.features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check, size: 16, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(feature)),
                  ],
                ),
              )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResumeFormScreen(),
                  ),
                );
              },
              child: const Text('Use Template'),
            ),
          ],
        );
      },
    );
  }
}

class ResumeTemplate {
  final String name;
  final String description;
  final Color primaryColor;
  final IconData icon;
  final List<String> features;

  ResumeTemplate({
    required this.name,
    required this.description,
    required this.primaryColor,
    required this.icon,
    required this.features,
  });
}

final List<ResumeTemplate> templates = [
  ResumeTemplate(
    name: 'Professional',
    description: 'Clean and modern design for corporate environments',
    primaryColor: Colors.blue,
    icon: Icons.business,
    features: [
      'Clean layout',
      'Professional typography',
      'ATS-friendly format',
      'Perfect for corporate jobs',
    ],
  ),
  ResumeTemplate(
    name: 'Creative',
    description: 'Eye-catching design for creative professionals',
    primaryColor: Colors.purple,
    icon: Icons.palette,
    features: [
      'Creative layout',
      'Colorful design',
      'Visual elements',
      'Great for design roles',
    ],
  ),
  ResumeTemplate(
    name: 'Minimalist',
    description: 'Simple and elegant design with focus on content',
    primaryColor: Colors.grey,
    icon: Icons.minimize,
    features: [
      'Minimal design',
      'Content-focused',
      'Easy to read',
      'Universal appeal',
    ],
  ),
  ResumeTemplate(
    name: 'Modern',
    description: 'Contemporary design with modern elements',
    primaryColor: Colors.teal,
    icon: Icons.dashboard,
    features: [
      'Modern layout',
      'Contemporary design',
      'Balanced sections',
      'Tech industry friendly',
    ],
  ),
  ResumeTemplate(
    name: 'Executive',
    description: 'Sophisticated design for senior positions',
    primaryColor: Colors.indigo,
    icon: Icons.star,
    features: [
      'Executive style',
      'Sophisticated look',
      'Leadership focused',
      'Senior position ready',
    ],
  ),
  ResumeTemplate(
    name: 'Academic',
    description: 'Structured format for academic and research roles',
    primaryColor: Colors.green,
    icon: Icons.school,
    features: [
      'Academic format',
      'Research focused',
      'Publication ready',
      'Education emphasis',
    ],
  ),
];