import 'translate.dart';
final String language = allTranslations.currentLanguage;
class AllText {
  var foreCanvass = 'foreCanvass';
  var next = allTranslations.text('Next ');
  var back = allTranslations.text('Back ');
  var editLabels = [
    allTranslations.text('First Name '),
    allTranslations.text('Last Name '),
    allTranslations.text('Address '),
    allTranslations.text('Phone Number '),
    allTranslations.text('Email Address '),
    allTranslations.text('Supporter '),
    allTranslations.text('Notes '),
    allTranslations.text('Last edit '),
    allTranslations.text('Submit ')
  ];

  var validateText = allTranslations.text('Please enter ');

  var yesNo = [allTranslations.text('Yes'), allTranslations.text('No')];

  double radioTextSize = 20;

  var lawnSign = 'Lawn sign';

  var donate = 'Donate';

  var volunteer = 'Volunteer';

  var streetListTitle = allTranslations.text('Streets');

  var streetNumberListTitle = allTranslations.text('Street Numbers');

  var tenantListTitle = allTranslations.text('People');

  var loginText = 'Login';
}
