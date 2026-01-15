part of '../add_user_page.dart';

class _AddUserDesktopPage extends StatelessWidget {
  _AddUserDesktopPage();

  final AddUserController _c = Get.find<AddUserController>();

  Widget _tabBar(BuildContext context) => Obx(
    () => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .1,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// General data page
              Expanded(
                child: InkWell(
                  onTap: () => _c.changeTab(0),
                  child: ItemTabBarView(
                    isWeb: true,
                    isSelected: _c.selectedIndex.value == 0,
                    isCompleted: _c.selectedIndex.value > 0,
                    iconName: Icons.person_outline,
                    title: msg.generalData.tr(),
                  ),
                ),
              ),

              /// Permissions page
              Expanded(
                child: InkWell(
                  onTap: () => _c.changeTab(1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ItemTabBarView(
                      isWeb: true,
                      isSelected: _c.selectedIndex.value == 1,
                      iconName: Icons.verified_user_outlined,
                      title: msg.permissions.tr(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.transparent),
          Text(
            _c.selectedIndex.value == 0
                ? msg.stepOneOfTwo.tr()
                : msg.stepTwoOfTwo.tr(),
            style: Get.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _bodyTab(BuildContext context) => Obx(
    () => Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .1,
        ),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (_c.selectedIndex.value == 0) _UserGeneralDataDesktop(),
                if (_c.selectedIndex.value == 1) UserPermissions(),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _body(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BannerUser(
          name: _c.user.nombreCompleto,
          lastname: _c.user.apePaterno,
          rfc: _c.user.rfc,
          jwt: _c.user.token.jwt,
          medicalIdentifier: _c.user.codigoFiliacion,
          canChangeProfile: _c.user.canChangeProfile,
        ),
      ),
      _tabBar(context),

      /// Body
      _bodyTab(context),
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(
      title: _c.isNewUser.value ? msg.newUser.tr() : msg.updateUser.tr(),
    ),
    body: _c.obx(
      (state) => _body(context),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.warning,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: msg.noForm.tr(),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingForm.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );
}

class _UserGeneralDataDesktop extends StatelessWidget {
  _UserGeneralDataDesktop();

  final AddUserController _c = Get.find<AddUserController>();

  @override
  Widget build(BuildContext context) => Form(
    key: _c.formKey,
    child: Column(
      children: [
        /// Row 1: Name and LastName
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: msg.name.tr(),
                  hintText: msg.name.tr(),
                  counterText: '',
                ),
                controller: _c.nameController,
                validator: Validators.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(regexNamesChar, unicode: true),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                maxLength: 30,
                controller: _c.lastNameController,
                validator: Validators.lastName,
                decoration: InputDecoration(
                  labelText: msg.lastName.tr(),
                  hintText: msg.lastName.tr(),
                  counterText: '',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(regexNamesChar, unicode: true),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        /// Row 2: Second LastName and Email
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                maxLength: 30,
                controller: _c.secondLastNameController,
                validator: Validators.secondLastName,
                decoration: InputDecoration(
                  labelText: msg.secondLastName.tr(),
                  hintText: msg.secondLastName.tr(),
                  counterText: '',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(regexNamesChar, unicode: true),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                maxLength: 100,
                enabled: _c.isNewUser.value,
                controller: _c.emailController,
                validator: Validators.email,
                decoration: InputDecoration(
                  labelText: msg.email.tr(),
                  hintText: msg.email.tr(),
                  counterText: '',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(regexFilterEmail)),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        /// Row 3: Phone Number and Birthdate
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                maxLength: 10,
                enabled: _c.isNewUser.value,
                controller: _c.phoneNumberController,
                keyboardType: TextInputType.phone,
                validator: Validators.phone,
                decoration: InputDecoration(
                  labelText: msg.phoneNumber.tr(),
                  hintText: msg.phoneNumber.tr(),
                  counterText: '',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _c.birthdateController,
                validator: Validators.date,
                readOnly: true,
                onTap: () => _c.selectDateCalendar(context),
                decoration: InputDecoration(
                  labelText: msg.birthdate.tr(),
                  hintText: msg.birthdate.tr(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _c.selectDateCalendar(context),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        /// AsistantType - Full width
        DropdownButtonFormField(
          focusColor: ColorPalette.white,
          initialValue: _c.selectedItemType.value.value().isEmpty
              ? null
              : _c.selectedItemType.value,
          validator: Validators.option,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: msg.typeUser.tr(),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          isExpanded: true,
          onChanged: _c.selectTypeAssistant,
          items: _c.state!.assistanTypeList
              .map(
                (type) => DropdownMenuItem(
                  value: type.idTipoAsistente,
                  child: Text(
                    type.nombre,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
              .toList(),
        ),

        /// Btn Continue
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            style: Get.theme.elevatedButtonTheme.style?.copyWith(
              minimumSize: WidgetStateProperty.all(const Size(0, 48)),
            ),
            onPressed: _c.validForm,
            child: Text(
              msg.continueB.tr(),
            ),
          ),
        ),
      ],
    ),
  );
}
