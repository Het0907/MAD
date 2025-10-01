class Resume {
  String fullName;
  String email;
  String phone;
  String address;
  String? profileImagePath;
  String objective;
  List<Education> education;
  List<Experience> experience;
  List<String> skills;
  List<Project> projects;
  List<String> languages;
  List<String> certifications;

  Resume({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.profileImagePath,
    this.objective = '',
    this.education = const [],
    this.experience = const [],
    this.skills = const [],
    this.projects = const [],
    this.languages = const [],
    this.certifications = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'profileImagePath': profileImagePath,
      'objective': objective,
      'education': education.map((e) => e.toJson()).toList(),
      'experience': experience.map((e) => e.toJson()).toList(),
      'skills': skills,
      'projects': projects.map((p) => p.toJson()).toList(),
      'languages': languages,
      'certifications': certifications,
    };
  }

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      profileImagePath: json['profileImagePath'],
      objective: json['objective'] ?? '',
      education: (json['education'] as List? ?? [])
          .map((e) => Education.fromJson(e))
          .toList(),
      experience: (json['experience'] as List? ?? [])
          .map((e) => Experience.fromJson(e))
          .toList(),
      skills: List<String>.from(json['skills'] ?? []),
      projects: (json['projects'] as List? ?? [])
          .map((p) => Project.fromJson(p))
          .toList(),
      languages: List<String>.from(json['languages'] ?? []),
      certifications: List<String>.from(json['certifications'] ?? []),
    );
  }
}

class Education {
  String degree;
  String institution;
  String year;
  String? grade;

  Education({
    this.degree = '',
    this.institution = '',
    this.year = '',
    this.grade,
  });

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'year': year,
      'grade': grade,
    };
  }

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'] ?? '',
      institution: json['institution'] ?? '',
      year: json['year'] ?? '',
      grade: json['grade'],
    );
  }
}

class Experience {
  String jobTitle;
  String company;
  String duration;
  String description;

  Experience({
    this.jobTitle = '',
    this.company = '',
    this.duration = '',
    this.description = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'company': company,
      'duration': duration,
      'description': description,
    };
  }

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      jobTitle: json['jobTitle'] ?? '',
      company: json['company'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Project {
  String name;
  String description;
  String technologies;
  String? duration;

  Project({
    this.name = '',
    this.description = '',
    this.technologies = '',
    this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'technologies': technologies,
      'duration': duration,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      technologies: json['technologies'] ?? '',
      duration: json['duration'],
    );
  }
}