/// Returns the initials of a full name.
///
/// The function splits the full name into parts and extracts the first character
/// from each part. It then combines these characters into a single string and
/// returns the result.
///
/// Parameters:
///   fullName (String): The full name from which to extract the initials.
///
/// Returns:
///   String: The initials of the full name.
String getInitials(String fullName) {
  List<String> nameParts = fullName.split(' ');
  String initials = '';

  for (String part in nameParts) {
    if (part.isNotEmpty) {
      initials += part[0];
    }
  }

  return initials;
}
