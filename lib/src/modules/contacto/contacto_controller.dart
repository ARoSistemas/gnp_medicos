import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/contacto/contacto_page.dart';
import 'package:url_launcher/url_launcher.dart';

part 'contacto_model.dart';

class ContactoController extends GetxController
    with StateMixin<_ContactoModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;
  List<ItemsContacts> items = [];
  @override
  void onInit() {
    super.onInit();

    items = [
      ItemsContacts(
        title: esMessages.mx.webSite.value,
        contact: 'gnp.com.mx',
        isLink: true,
        onTap: () => launchWeb('https://www.gnp.com.mx/'),
      ),
      ItemsContacts(
        title: esMessages.mx.gnpLine.value,
        contact: '+525552279000',
        isLink: true,
        onTap: () => launchPhoneContact('5552279000'),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        contact: '+525552279000',
        isLink: false,
        img: 'icono_contactanos_facebook.png',
        jwt: jwt,
        onTap: () => launchWeb(
          'https://www.facebook.com/gnpseguros/',
        ),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        img: 'icono_contactanos_x.png',
        isLink: false,
        jwt: jwt,
        onTap: () => launchWeb('https://twitter.com/gnpseguros'),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        img: 'icono_contactanos_instagram.png',
        isLink: false,
        jwt: jwt,
        onTap: () => launchWeb(
          'https://www.instagram.com/gnpseguros/',
        ),
      ),
    ];
  }

  Future<void> launchPhoneContact(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchWeb(String socialNetwork) async {
    final Uri url = Uri.parse(socialNetwork);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchEmail(String email, {String? subject}) async {
    String? encodeQueryParameters(Map<String, String> params) => params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject ?? '',
      }),
    );

    // launchUrl(emailLaunchUri);
    await launchUrl(emailLaunchUri);
  }
}
