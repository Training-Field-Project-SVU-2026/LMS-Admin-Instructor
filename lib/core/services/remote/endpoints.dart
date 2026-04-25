class EndPoint {
  static String localUrl = "http://lcoalhost/api/";
  static String remoteUrl =
      "http://lms-env.eba-8nbnpx42.us-east-1.elasticbeanstalk.com/api";

  static String baseUrl = remoteUrl;

  // auth
  static String login = "/auth/login/";
  static String register = "/auth/register/";
  static String logout = "/auth/logout/";
  static String forgotPassword = "/auth/forgot-password/";
  static String resetPassword = "/auth/reset-password/";
  static String refreshToken = "/auth/token/refresh/";
  static String checkToken = "/auth/check-token/";
  static String resendOtp = "/auth/resend-otp/";

  static String getUserDataEndPoint(id) {
    return "/user/get-user/$id";
  }

  //?***********************************************************************?

  //? Students
  static String studentsAdmin = "/admin/students/";
  static String deleteStudentAdmin(String slug) =>
      "/admin/students/$slug/delete/";

  //?***********************************************************************?
  //? Courses' Instructor
  static String coursesInstructor(String instructorSlug) =>
      "/instructor/$instructorSlug/courses/";

  //? instructor
  static String instructorAdmin = "/instructors/";
  static String addInstructor = "/instructors/create/";
  static String deleteInstructor(String slug) => "/instructors/$slug/delete/";
  static String addCourse = "/courses/create/";
  static String courseInfo(String slug) => "/courses/$slug/";
}

class ApiKey {
  static String message = "message";
  static String authorization = "Authorization";
  static String firstName = "first_name";
  static String lastName = "last_name";
  static String email = "email";
  static String password = "password";
  static String role = "role";
  static String slug = "slug";
  static String isActive = "is_active";
  static String isVerified = "is_verified";
  static String student = "student";
  static String accessToken = "access";
  static String refreshToken = "refresh";
  static String user = "user";
  static String isLoggedIn = "is_logged_in";
  static String oldPassword = "old_password";
  static String newPassword = "new_password";
  static String image = "image";
  static String title = "title";
  static String description = "description";
  static String price = "price";
  static String category = "category";
  static String level = "level";
}
