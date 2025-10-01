import 'package:flutter/material.dart';
import 'package:practical_5/models/resume.dart';
import 'package:practical_5/services/storage_service.dart';
import 'package:practical_5/screens/resume_preview_screen.dart';
import 'package:practical_5/screens/resume_form_screen.dart';

class SavedResumesScreen extends StatefulWidget {
  const SavedResumesScreen({super.key});

  @override
  State<SavedResumesScreen> createState() => _SavedResumesScreenState();
}

class _SavedResumesScreenState extends State<SavedResumesScreen> {
  List<MapEntry<String, Resume>> savedResumes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedResumes();
  }

  Future<void> _loadSavedResumes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final resumeIds = await StorageService.getResumeIds();
      final resumes = <MapEntry<String, Resume>>[];

      for (String id in resumeIds) {
        final resume = await StorageService.loadResume(id);
        if (resume != null) {
          resumes.add(MapEntry(id, resume));
        }
      }

      setState(() {
        savedResumes = resumes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading resumes: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Resumes'),
        actions: [
          IconButton(
            onPressed: _loadSavedResumes,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : savedResumes.isEmpty
              ? _buildEmptyState()
              : _buildResumesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ResumeFormScreen(),
            ),
          ).then((_) => _loadSavedResumes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 120,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            'No Saved Resumes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Create your first resume to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResumeFormScreen(),
                ),
              ).then((_) => _loadSavedResumes());
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Resume'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: savedResumes.length,
      itemBuilder: (context, index) {
        final resumeEntry = savedResumes[index];
        final resumeId = resumeEntry.key;
        final resume = resumeEntry.value;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 30,
              child: Text(
                resume.fullName.isNotEmpty
                    ? resume.fullName.substring(0, 1).toUpperCase()
                    : 'R',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            title: Text(
              resume.fullName.isNotEmpty ? resume.fullName : 'Untitled Resume',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (resume.email.isNotEmpty)
                  Text(
                    resume.email,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                if (resume.phone.isNotEmpty)
                  Text(
                    resume.phone,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.school, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      '${resume.education.length} Education',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.work, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      '${resume.experience.length} Experience',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) => _handleMenuAction(value, resumeId, resume),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(Icons.visibility),
                      SizedBox(width: 8),
                      Text('View'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Row(
                    children: [
                      Icon(Icons.copy),
                      SizedBox(width: 8),
                      Text('Duplicate'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumePreviewScreen(resume: resume),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _handleMenuAction(String action, String resumeId, Resume resume) async {
    switch (action) {
      case 'view':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResumePreviewScreen(resume: resume),
          ),
        );
        break;
      case 'edit':
        // For now, just navigate to form - in a real app, you'd prefill the form
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResumeFormScreen(),
          ),
        ).then((_) => _loadSavedResumes());
        break;
      case 'duplicate':
        await _duplicateResume(resume);
        break;
      case 'delete':
        await _deleteResume(resumeId, resume);
        break;
    }
  }

  Future<void> _duplicateResume(Resume resume) async {
    try {
      final newId = DateTime.now().millisecondsSinceEpoch.toString();
      final duplicatedResume = Resume(
        fullName: '${resume.fullName} (Copy)',
        email: resume.email,
        phone: resume.phone,
        address: resume.address,
        objective: resume.objective,
        education: resume.education,
        experience: resume.experience,
        skills: resume.skills,
        projects: resume.projects,
        languages: resume.languages,
        certifications: resume.certifications,
      );

      await StorageService.saveResume(duplicatedResume, newId);
      await _loadSavedResumes();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Resume duplicated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error duplicating resume: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteResume(String resumeId, Resume resume) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Resume'),
        content: Text(
          'Are you sure you want to delete "${resume.fullName.isNotEmpty ? resume.fullName : 'Untitled Resume'}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await StorageService.deleteResume(resumeId);
        await _loadSavedResumes();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Resume deleted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting resume: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}