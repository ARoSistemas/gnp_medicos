import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';

part 'responsive/not_found_desktop_page.dart';

part 'responsive/not_found_phone_page.dart';

part 'responsive/not_found_tablet_page.dart';

class NotFoundPage extends GetResponsiveView {
  NotFoundPage({super.key});

  static final GetPage page = GetPage(
    name: '/not-found',
    page: NotFoundPage.new,
  );

  @override
  Widget? phone() => const _NotFoundPhonePage();

  @override
  Widget? tablet() => const _NotFoundTabletPage();

  @override
  Widget? desktop() => const _NotFoundDesktopPage();
}
