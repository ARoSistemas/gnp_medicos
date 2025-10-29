import 'package:flutter/material.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AlertModule/MyDialog.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsPresenter.dart';

class GNPDialogIcon extends StatelessWidget {
  final String icon, title, description;
  List<Widget> actions;

  GNPDialogIcon({
    required this.icon,
    required this.title,
    required this.description,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    if (this.actions == null) {
      this.actions = [
        Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: MaterialButton(
                color: AppColors.secondary900,
                textColor: Colors.white,
                highlightColor: AppColors.secondary800,
                disabledColor: AppColors.gnp_back_disable2,
                disabledTextColor: AppColors.disabled,
                onPressed: () {
                  Navigator.pop(context);
                  //presenter.openMap(this.servicio, selectedItem);
                },
                child: Text("Aceptar",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white))))
      ];
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: MyDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: SafeArea(
            top: false,
            child: Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                        visible: true,
                        child: Container(
                          margin: EdgeInsets.only( top: 10 ),
                          child: Image.asset('assets/img/'+ icon, width: 50, height: 50,),
              )),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: Text(this.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.azulGNP)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 8, bottom: 8, left: 16, right: 16),
                      child: Text(this.description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: AppColors.azulGNP)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: actions,
                    )
                  ]),
            )));
  }
}
