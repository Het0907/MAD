import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:practical_5/models/resume.dart';

class PDFService {
  static Future<void> generateResumePDF(Resume resume) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(resume),
            pw.SizedBox(height: 20),
            _buildObjective(resume),
            pw.SizedBox(height: 20),
            _buildEducation(resume),
            pw.SizedBox(height: 20),
            _buildExperience(resume),
            pw.SizedBox(height: 20),
            _buildProjects(resume),
            pw.SizedBox(height: 20),
            _buildSkills(resume),
            pw.SizedBox(height: 20),
            _buildLanguagesAndCertifications(resume),
          ];
        },
      ),
    );

    // Save the PDF
    await _savePDF(pdf, resume.fullName);
  }

  static pw.Widget _buildHeader(Resume resume) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            resume.fullName,
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          pw.SizedBox(height: 8),
          if (resume.email.isNotEmpty)
            _buildContactRow('Email: ${resume.email}'),
          if (resume.phone.isNotEmpty)
            _buildContactRow('Phone: ${resume.phone}'),
          if (resume.address.isNotEmpty)
            _buildContactRow('Address: ${resume.address}'),
        ],
      ),
    );
  }

  static pw.Widget _buildContactRow(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 12),
      ),
    );
  }

  static pw.Widget _buildObjective(Resume resume) {
    if (resume.objective.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Career Objective'),
        pw.SizedBox(height: 8),
        pw.Text(
          resume.objective,
          style: const pw.TextStyle(fontSize: 11),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }

  static pw.Widget _buildEducation(Resume resume) {
    if (resume.education.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Education'),
        pw.SizedBox(height: 8),
        ...resume.education.map((edu) => _buildEducationItem(edu)),
      ],
    );
  }

  static pw.Widget _buildEducationItem(Education education) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            education.degree,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            education.institution,
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(height: 2),
          pw.Row(
            children: [
              pw.Text(
                'Year: ${education.year}',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),
              if (education.grade != null && education.grade!.isNotEmpty) ...[
                pw.SizedBox(width: 20),
                pw.Text(
                  'Grade: ${education.grade}',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildExperience(Resume resume) {
    if (resume.experience.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Work Experience'),
        pw.SizedBox(height: 8),
        ...resume.experience.map((exp) => _buildExperienceItem(exp)),
      ],
    );
  }

  static pw.Widget _buildExperienceItem(Experience experience) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            experience.jobTitle,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            experience.company,
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            'Duration: ${experience.duration}',
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
          ),
          if (experience.description.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            pw.Text(
              experience.description,
              style: const pw.TextStyle(fontSize: 10),
              textAlign: pw.TextAlign.justify,
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildProjects(Resume resume) {
    if (resume.projects.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Projects'),
        pw.SizedBox(height: 8),
        ...resume.projects.map((project) => _buildProjectItem(project)),
      ],
    );
  }

  static pw.Widget _buildProjectItem(Project project) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            project.name,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          if (project.duration != null && project.duration!.isNotEmpty) ...[
            pw.SizedBox(height: 2),
            pw.Text(
              'Duration: ${project.duration}',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ],
          if (project.description.isNotEmpty) ...[
            pw.SizedBox(height: 6),
            pw.Text(
              project.description,
              style: const pw.TextStyle(fontSize: 10),
              textAlign: pw.TextAlign.justify,
            ),
          ],
          if (project.technologies.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              'Technologies: ${project.technologies}',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey600,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildSkills(Resume resume) {
    if (resume.skills.isEmpty) return pw.SizedBox();
    
    final skills = resume.skills.where((skill) => skill.isNotEmpty).toList();
    if (skills.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Skills'),
        pw.SizedBox(height: 8),
        pw.Wrap(
          spacing: 8,
          runSpacing: 4,
          children: skills.map((skill) => pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue100,
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Text(
              skill,
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.blue800,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  static pw.Widget _buildLanguagesAndCertifications(Resume resume) {
    final languages = resume.languages.where((lang) => lang.isNotEmpty).toList();
    final certifications = resume.certifications.where((cert) => cert.isNotEmpty).toList();
    
    if (languages.isEmpty && certifications.isEmpty) return pw.SizedBox();
    
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (languages.isNotEmpty)
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Languages'),
                pw.SizedBox(height: 8),
                ...languages.map((lang) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text('• $lang', style: const pw.TextStyle(fontSize: 10)),
                )),
              ],
            ),
          ),
        if (languages.isNotEmpty && certifications.isNotEmpty)
          pw.SizedBox(width: 20),
        if (certifications.isNotEmpty)
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Certifications'),
                pw.SizedBox(height: 8),
                ...certifications.map((cert) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text('• $cert', style: const pw.TextStyle(fontSize: 10)),
                )),
              ],
            ),
          ),
      ],
    );
  }

  static pw.Widget _buildSectionHeader(String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 4),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.blue, width: 2),
        ),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue800,
        ),
      ),
    );
  }

  static Future<void> _savePDF(pw.Document pdf, String fileName) async {
    try {
      final output = await getExternalStorageDirectory();
      if (output != null) {
        final file = File("${output.path}/${fileName.replaceAll(' ', '_')}_resume.pdf");
        await file.writeAsBytes(await pdf.save());
        
        // Also try to open the PDF
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save(),
        );
      }
    } catch (e) {
      // If external storage fails, try internal storage
      try {
        final directory = await getApplicationDocumentsDirectory();
        final file = File("${directory.path}/${fileName.replaceAll(' ', '_')}_resume.pdf");
        await file.writeAsBytes(await pdf.save());
        
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save(),
        );
      } catch (e) {
        throw Exception('Failed to save PDF: $e');
      }
    }
  }
}