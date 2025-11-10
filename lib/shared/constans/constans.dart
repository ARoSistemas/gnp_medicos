const bool isHardCode = false;
const String regexEmail = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
const String regexNames = r"^[\p{L}' -]+$";
const String regexNamesChar = r"[\p{L}' -]";
const String regexAlphanumeric = r'[\p{L}\p{N}]';
const String regexFilterEmail = r'[a-zA-Z0-9@._\-]';
const String statusRequestConvenio = '01';

class FileTypesAgree {
  static const agreement = 'Convenio';
  static const guidelines = 'Lineamientos';
}
 
