import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:practical_5/models/resume.dart';
import 'package:practical_5/services/pdf_service.dart';
import 'package:practical_5/widgets/section_header.dart';

class ResumePreviewScreen extends StatelessWidget {
  final Resume resume;

  const ResumePreviewScreen({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
        actions: [
          IconButton(
            onPressed: () => _generatePDF(context),
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Generate PDF',
          ),
          IconButton(
            onPressed: () => _shareResume(context),
            icon: const Icon(Icons.share),
            tooltip: 'Share Resume',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildObjective(),
              const SizedBox(height: 24),
              _buildEducation(),
              const SizedBox(height: 24),
              _buildExperience(),
              const SizedBox(height: 24),
              _buildProjects(),
              const SizedBox(height: 24),
              _buildSkills(),
              const SizedBox(height: 24),
              _buildLanguagesAndCertifications(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _generatePDF(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (resume.profileImagePath != null && !kIsWeb)
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                image: DecorationImage(
                  image: FileImage(File(resume.profileImagePath!)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (resume.profileImagePath != null && !kIsWeb) const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resume.fullName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                _buildContactInfo(Icons.email, resume.email),
                _buildContactInfo(Icons.phone, resume.phone),
                if (resume.address.isNotEmpty)
                  _buildContactInfo(Icons.location_on, resume.address),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    if (text.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjective() {
    if (resume.objective.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Career Objective'),
        const SizedBox(height: 8),
        Text(
          resume.objective,
          style: const TextStyle(fontSize: 16, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildEducation() {
    if (resume.education.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Education'),
        const SizedBox(height: 8),
        ...resume.education.map((edu) => _buildEducationItem(edu)),
      ],
    );
  }

  Widget _buildEducationItem(Education education) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            education.degree,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            education.institution,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                education.year,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              if (education.grade != null && education.grade!.isNotEmpty) ...[
                const SizedBox(width: 16),
                Icon(Icons.grade, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  education.grade!,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperience() {
    if (resume.experience.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Work Experience'),
        const SizedBox(height: 8),
        ...resume.experience.map((exp) => _buildExperienceItem(exp)),
      ],
    );
  }

  Widget _buildExperienceItem(Experience experience) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            experience.jobTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            experience.company,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.date_range, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                experience.duration,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          if (experience.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              experience.description,
              style: const TextStyle(height: 1.4),
              textAlign: TextAlign.justify,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProjects() {
    if (resume.projects.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Projects'),
        const SizedBox(height: 8),
        ...resume.projects.map((project) => _buildProjectItem(project)),
      ],
    );
  }

  Widget _buildProjectItem(Project project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          if (project.duration != null && project.duration!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.timer, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  project.duration!,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
          if (project.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              project.description,
              style: const TextStyle(height: 1.4),
              textAlign: TextAlign.justify,
            ),
          ],
          if (project.technologies.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.code, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Technologies: ${project.technologies}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSkills() {
    if (resume.skills.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Skills'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: resume.skills
              .where((skill) => skill.isNotEmpty)
              .map((skill) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue.shade300),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildLanguagesAndCertifications() {
    final hasLanguages = resume.languages.isNotEmpty &&
        resume.languages.any((lang) => lang.isNotEmpty);
    final hasCertifications = resume.certifications.isNotEmpty &&
        resume.certifications.any((cert) => cert.isNotEmpty);

    if (!hasLanguages && !hasCertifications) return const SizedBox();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLanguages)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Languages'),
                const SizedBox(height: 8),
                ...resume.languages
                    .where((lang) => lang.isNotEmpty)
                    .map((lang) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Icon(Icons.circle,
                                  size: 6, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              Expanded(child: Text(lang)),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        if (hasLanguages && hasCertifications) const SizedBox(width: 24),
        if (hasCertifications)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Certifications'),
                const SizedBox(height: 8),
                ...resume.certifications
                    .where((cert) => cert.isNotEmpty)
                    .map((cert) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Icon(Icons.verified,
                                  size: 16, color: Colors.green.shade600),
                              const SizedBox(width: 8),
                              Expanded(child: Text(cert)),
                            ],
                          ),
                        )),
              ],
            ),
          ),
      ],
    );
  }

  void _generatePDF(BuildContext context) async {
    try {
      await PDFService.generateResumePDF(resume);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating PDF: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _shareResume(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Share Resume'),
          content: const Text(
            'Choose how you want to share your resume:\n\n'
            '• Generate PDF and share\n'
            '• Save to device\n'
            '• Email resume\n'
            '• Print resume',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generatePDF(context);
              },
              child: const Text('Generate PDF'),
            ),
          ],
        );
      },
    );
  }
}