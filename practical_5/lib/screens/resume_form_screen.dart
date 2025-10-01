import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practical_5/models/resume.dart';
import 'package:practical_5/screens/resume_preview_screen.dart';
import 'package:practical_5/services/storage_service.dart';
import 'package:practical_5/widgets/custom_text_field.dart';
import 'package:practical_5/widgets/section_header.dart';

class ResumeFormScreen extends StatefulWidget {
  const ResumeFormScreen({super.key});

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Controllers for form fields
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _objectiveController = TextEditingController();

  // Lists for dynamic sections
  List<Education> _education = [Education()];
  List<Experience> _experience = [Experience()];
  List<String> _skills = [''];
  List<Project> _projects = [Project()];
  List<String> _languages = [''];
  List<String> _certifications = [''];

  String? _profileImagePath;
  Uint8List? _webImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _objectiveController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget _getProfileImageWidget() {
    if (kIsWeb && _webImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          _webImage!,
          fit: BoxFit.cover,
        ),
      );
    } else if (!kIsWeb && _profileImagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(_profileImagePath!),
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Icon(
        Icons.person,
        size: 50,
        color: Colors.grey[600],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Resume'),
        actions: [
          TextButton(
            onPressed: _previewResume,
            child: const Text(
              'Preview',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildPersonalInfoPage(),
                _buildEducationPage(),
                _buildExperiencePage(),
                _buildSkillsAndOthersPage(),
              ],
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: List.generate(4, (index) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 4,
              decoration: BoxDecoration(
                color: index <= _currentPage ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Personal Information'),
            const SizedBox(height: 16),
            _buildProfileImagePicker(),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _fullNameController,
              label: 'Full Name',
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _addressController,
              label: 'Address',
              icon: Icons.location_on,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _objectiveController,
              label: 'Career Objective',
              icon: Icons.assignment,
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your career objective';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: ClipOval(
            child: (kIsWeb && _webImage != null)
                ? Image.memory(
                    _webImage!,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  )
                : (!kIsWeb && _profileImagePath != null)
                    ? Image.file(
                        File(_profileImagePath!),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.blue,
                      ),
          ),
        ),
      ),
    );
  }

  Widget _buildEducationPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(title: 'Education'),
              IconButton(
                onPressed: _addEducation,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          ..._education.asMap().entries.map((entry) {
            int index = entry.key;
            Education edu = entry.value;
            return _buildEducationCard(edu, index);
          }),
        ],
      ),
    );
  }

  Widget _buildEducationCard(Education education, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Education ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (_education.length > 1)
                  IconButton(
                    onPressed: () => _removeEducation(index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextField(
              initialValue: education.degree,
              label: 'Degree/Course',
              icon: Icons.school,
              onChanged: (value) => education.degree = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: education.institution,
              label: 'Institution/University',
              icon: Icons.business,
              onChanged: (value) => education.institution = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: education.year,
              label: 'Year of Graduation',
              icon: Icons.calendar_today,
              onChanged: (value) => education.year = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: education.grade ?? '',
              label: 'Grade/CGPA (Optional)',
              icon: Icons.grade,
              onChanged: (value) => education.grade = value.isEmpty ? null : value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperiencePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(title: 'Work Experience'),
              IconButton(
                onPressed: _addExperience,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          ..._experience.asMap().entries.map((entry) {
            int index = entry.key;
            Experience exp = entry.value;
            return _buildExperienceCard(exp, index);
          }),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(title: 'Projects'),
              IconButton(
                onPressed: _addProject,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          ..._projects.asMap().entries.map((entry) {
            int index = entry.key;
            Project project = entry.value;
            return _buildProjectCard(project, index);
          }),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(Experience experience, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Experience ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (_experience.length > 1)
                  IconButton(
                    onPressed: () => _removeExperience(index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextField(
              initialValue: experience.jobTitle,
              label: 'Job Title',
              icon: Icons.work,
              onChanged: (value) => experience.jobTitle = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: experience.company,
              label: 'Company',
              icon: Icons.business,
              onChanged: (value) => experience.company = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: experience.duration,
              label: 'Duration',
              icon: Icons.date_range,
              onChanged: (value) => experience.duration = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: experience.description,
              label: 'Job Description',
              icon: Icons.description,
              maxLines: 3,
              onChanged: (value) => experience.description = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (_projects.length > 1)
                  IconButton(
                    onPressed: () => _removeProject(index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextField(
              initialValue: project.name,
              label: 'Project Name',
              icon: Icons.folder,
              onChanged: (value) => project.name = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: project.description,
              label: 'Description',
              icon: Icons.description,
              maxLines: 3,
              onChanged: (value) => project.description = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: project.technologies,
              label: 'Technologies Used',
              icon: Icons.code,
              onChanged: (value) => project.technologies = value,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              initialValue: project.duration ?? '',
              label: 'Duration (Optional)',
              icon: Icons.timer,
              onChanged: (value) => project.duration = value.isEmpty ? null : value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsAndOthersPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildListSection(
            'Skills',
            _skills,
            Icons.build,
            _addSkill,
            _removeSkill,
          ),
          const SizedBox(height: 20),
          _buildListSection(
            'Languages',
            _languages,
            Icons.language,
            _addLanguage,
            _removeLanguage,
          ),
          const SizedBox(height: 20),
          _buildListSection(
            'Certifications',
            _certifications,
            Icons.verified,
            _addCertification,
            _removeCertification,
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(
    String title,
    List<String> items,
    IconData icon,
    VoidCallback onAdd,
    Function(int) onRemove,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionHeader(title: title),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      initialValue: item,
                      label: title.substring(0, title.length - 1),
                      icon: icon,
                      onChanged: (value) => items[index] = value,
                    ),
                  ),
                  if (items.length > 1)
                    IconButton(
                      onPressed: () => onRemove(index),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage > 0
              ? ElevatedButton(
                  onPressed: _previousPage,
                  child: const Text('Previous'),
                )
              : const SizedBox(),
          _currentPage < 3
              ? ElevatedButton(
                  onPressed: _nextPage,
                  child: const Text('Next'),
                )
              : ElevatedButton(
                  onPressed: _previewResume,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Generate Resume'),
                ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        // For web platform
        final bytes = await image.readAsBytes();
        setState(() {
          _webImage = bytes;
          _profileImagePath = image.name; // Store filename for web
        });
      } else {
        // For mobile platforms
        setState(() {
          _profileImagePath = image.path;
        });
      }
    }
  }

  void _addEducation() {
    setState(() {
      _education.add(Education());
    });
  }

  void _removeEducation(int index) {
    setState(() {
      _education.removeAt(index);
    });
  }

  void _addExperience() {
    setState(() {
      _experience.add(Experience());
    });
  }

  void _removeExperience(int index) {
    setState(() {
      _experience.removeAt(index);
    });
  }

  void _addProject() {
    setState(() {
      _projects.add(Project());
    });
  }

  void _removeProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
  }

  void _addSkill() {
    setState(() {
      _skills.add('');
    });
  }

  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
  }

  void _addLanguage() {
    setState(() {
      _languages.add('');
    });
  }

  void _removeLanguage(int index) {
    setState(() {
      _languages.removeAt(index);
    });
  }

  void _addCertification() {
    setState(() {
      _certifications.add('');
    });
  }

  void _removeCertification(int index) {
    setState(() {
      _certifications.removeAt(index);
    });
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previewResume() async {
    // Remove empty entries
    _skills.removeWhere((skill) => skill.trim().isEmpty);
    _languages.removeWhere((lang) => lang.trim().isEmpty);
    _certifications.removeWhere((cert) => cert.trim().isEmpty);

    final resume = Resume(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      profileImagePath: _profileImagePath,
      objective: _objectiveController.text,
      education: _education,
      experience: _experience,
      skills: _skills,
      projects: _projects,
      languages: _languages,
      certifications: _certifications,
    );

    // Save the resume
    try {
      final resumeId = DateTime.now().millisecondsSinceEpoch.toString();
      await StorageService.saveResume(resume, resumeId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Resume saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving resume: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumePreviewScreen(resume: resume),
      ),
    );
  }
}