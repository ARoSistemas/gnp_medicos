import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/contacto/contacto_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:url_launcher/url_launcher.dart';

part 'contacto_model.dart';

class ContactoController extends GetxController
    with StateMixin<_ContactoModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;
  List<ItemsContacts> items = [];
  Map? redes;
  Map? contacto;

  /// Breadcrumbs para la navegacion
  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Contacto'),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(const _ContactoModel(), status: RxStatus.loading());
    await getData();
  }

  Future<void> getData() async {
    final Map? dataFirebase = await appService.shared.realtimeService
        .getDataOnce('appConfig/modulos/contactanos');
    if (dataFirebase != null) {
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
      return;
    }
    redes = dataFirebase['redes'] as Map;
    contacto = dataFirebase['contacto'] as Map;

    items = [
      ItemsContacts(
        title: msg.webSite.value,
        contact: 'gnp.com.mx',
        isLink: true,
        onTap: () => launchWeb(dataFirebase['pagina']),
      ),
      ItemsContacts(
        title: msg.gnpLine.value,
        contact: '5552279000',
        isLink: true,
        onTap: () => launchPhoneContact(dataFirebase['telefono']),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        contact: '+525552279000',
        isLink: false,
        img: 'icono_contactanos_facebook.png',
        jwt: jwt,
        onTap: () => launchWeb(redes!['facebook']),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        img: 'icono_contactanos_x.png',
        isLink: false,
        jwt: jwt,
        onTap: () => launchWeb(redes!['x']),
      ),
      ItemsContacts(
        title: '@gnpseguros',
        img: 'icono_contactanos_instagram.png',
        isLink: false,
        jwt: jwt,
        onTap: () => launchWeb(redes!['instagram']),
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
