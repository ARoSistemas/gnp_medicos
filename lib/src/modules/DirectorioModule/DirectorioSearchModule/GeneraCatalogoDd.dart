import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/CatalogoDdObject.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GeneraCatalogo extends StatefulWidget {
  GeneraCatalogo({Key? key, this.dataObject, this.onChange, this.refresh, this.idDropdown}) : super(key: key);
  final CatalogoDdObject? dataObject;
  final Function? onChange;
  final Function? refresh;
  int? idDropdown;
  static int contadorIdDropdown = 0;

  @override
  _GeneraCatalogoState createState() => _GeneraCatalogoState();
}

class _GeneraCatalogoState extends State<GeneraCatalogo> {

  bool isOpen = false;
  bool disabled = false;

  @override
  void initState() {

    super.initState();
    setState(() {
      widget.idDropdown = GeneraCatalogo.contadorIdDropdown;
      GeneraCatalogo.contadorIdDropdown++;
    });
    if(widget.dataObject?.selectedItem==null){
      if(widget.dataObject?.config!.defaultSelectedIndex!=null){
        widget.dataObject?.selectedItem = widget.dataObject!.config!.defaultSelectedIndex;
      }else{
        widget.dataObject?.selectedItem = 0;
      }
    }

    if(widget.dataObject!.valores!.isEmpty){
      widget.dataObject?.valores!.add(ElementoDd(id: 0, valor: " ")); //No hay valores en la lista
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.idDropdown != null){
      if(Utils.focusDropdown != widget.idDropdown){
        setState(() {
          isOpen = false;
        });
      }
    }
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                Utils.focusDropdown = widget.idDropdown!;
                if(widget.refresh != null){
                  widget.refresh!();
                }
                //  Validación para cuando se haya seleccionado un plan o círculo contratado, no abra el dropdown, a menos que el número de póliza sea igual a Sin póliza
                if((widget.dataObject!.label!.contains("Plan") || widget.dataObject!.label!.contains("Círculo")) && Utils.vistaDirectorio.contains("search") &&
                    (widget.dataObject!.valores!.elementAt(widget.dataObject!.selectedItem!).valor!.contains("contratado") ||
                        widget.dataObject!.valores!.elementAt(widget.dataObject!.selectedItem!).valor!.contains("c...") ||
                        widget.dataObject!.valores!.elementAt(widget.dataObject!.selectedItem!).valor!.contains("  "))){
                  disabled = true;
                  isOpen= isOpen;
                } else{
                  disabled = false;
                  isOpen= !isOpen;
                }
              });
            },
            child: Container( //Inicia panel superior
              height: double.parse(widget.dataObject!.config!.dropdownSize.toString()),
              decoration: BoxDecoration(
                  color: widget.dataObject!.config!.dropdownBackgroundColor,
                  border: Border(
                      bottom: isOpen?
                      BorderSide(color: widget.dataObject?.config!.activeBorderColor!=null? widget.dataObject!.config!.activeBorderColor!: Colors.black,
                          width: widget.dataObject?.config!.borderSize!=null? double.parse( widget.dataObject!.config!.borderSize.toString()): 1 ):
                      BorderSide(color: widget.dataObject?.config!.borderColor!=null? widget.dataObject!.config!.borderColor!: Colors.grey,
                          width: widget.dataObject?.config!.borderSize!=null? double.parse( widget.dataObject!.config!.borderSize.toString()): 1 ) )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: widget.dataObject?.config!.innnerMargin!=null? double.parse(widget.dataObject!.config!.innnerMargin.toString()): 0, left: widget.dataObject?.config!.innnerMargin!=null? double.parse(widget.dataObject!.config!.innnerMargin.toString()): 0 ),
                    child: Text(widget.dataObject!.label!,
                      style: TextStyle(color: isOpen? widget.dataObject?.config!.labelColorActive != null ? widget.dataObject!.config!.labelColorActive: Colors.black:  widget.dataObject?.config!.labelColor != null?
                      widget.dataObject!.config!.labelColor:
                      Colors.black, fontSize: 14 ), textAlign: TextAlign.left ,),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, //Center Row contents horizontally,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: //widget.dataObject.valores != null && widget.dataObject.valores.isNotEmpty ? Text(widget.dataObject.valores[widget.dataObject.selectedItem].valor) : "No hay Valores",
                        widget.dataObject?.valores != null  &&  widget.dataObject!.valores!.isNotEmpty && (widget.dataObject?.selectedItem == null ? 0 : widget.dataObject!.selectedItem! ) <= widget.dataObject!.valores!.length  ?
                        Text( widget.dataObject?.valores!.elementAt(widget.dataObject?.selectedItem == null ? 0 : widget.dataObject!.selectedItem! ).valor != null ?
                        widget.dataObject!.valores!.elementAt(widget.dataObject!.selectedItem == null ? 0 : widget.dataObject!.selectedItem!).valor!: "Todos", //No hay Valores
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),) : Text("Todos",style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),//No hay Valores
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: widget.dataObject?.config!.innnerMargin!=null? double.parse(widget.dataObject!.config!.innnerMargin.toString()): 0 ) ,
                        child:widget.dataObject!.config!.icon,
                      ),

                    ],
                  ),
                  Spacer(),



                ],),
            ),
          ),
          Visibility(visible: true,
          child: Column(
            children: <Widget>[
              Visibility(
                visible:  disabled == true && isOpen == false ? false : false,
                child: Container(
                  decoration: BoxDecoration(              color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppColors.greyColor, //.withOpacity(0.5)
                          blurRadius: 3,
                          offset: Offset(0, 3))
                    ],),
                  height: double.parse(widget.dataObject!.config!.listSize.toString()),
                  child: ListView.builder(
                      itemCount: widget.dataObject!.valores!.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext ctxt, int index) {
                        return TextButton( 
                          style: TextButton.styleFrom(
                            backgroundColor: widget.dataObject!.selectedItem == index? widget.dataObject!.config!.selectedColor: Colors.white,
                            foregroundColor: widget.dataObject!.config!.selectedColor,
                          ),
                          //color: widget.dataObject.selectedItem == index? widget.dataObject.config.selectedColor: Colors.white,
                          //highlightColor: widget.dataObject.config.selectedColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start, //Center Row contents horizontally,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(widget.dataObject!.valores![index].valor!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle( color: widget.dataObject!.selectedItem == index?
                                  widget.dataObject?.config!.selectedTextItemColor !=null?
                                  widget.dataObject!.config!.selectedTextItemColor
                                      : widget.dataObject?.config!.textItemColor != null? widget.dataObject!.config!.textItemColor : Colors.black
                                      : widget.dataObject?.config!.textItemColor !=null? widget.dataObject!.config!.textItemColor : Colors.black, fontSize: 16, fontWeight: FontWeight.normal) ,),
                              ),
                            ],
                          ),
                          onPressed: (){
                            setState(() {
                              isOpen = false;
                              widget.dataObject!.selectedItem = index;
                              if(widget.onChange != null){
                                widget.onChange!();
                              }
                            });

                          },);

                      }),
                ),
              ),
              Visibility(
                visible: disabled == false && isOpen == true ? true :false,
                child: Container(
                  decoration: BoxDecoration(              color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppColors.greyColor, //.withOpacity(0.5)
                          blurRadius: 3,
                          offset: Offset(0, 3))
                    ],),
                  height: double.parse(widget.dataObject!.config!.listSize.toString()),
                  child: ListView.builder(
                      itemCount: widget.dataObject!.valores!.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext ctxt, int index) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: widget.dataObject!.selectedItem == index? widget.dataObject!.config!.selectedColor: Colors.white,
                          ), 
                          //color: widget.dataObject!.selectedItem == index? widget.dataObject!.config.selectedColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start, //Center Row contents horizontally,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(widget.dataObject!.valores![index].valor!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle( color: widget.dataObject!.selectedItem == index?
                                  widget.dataObject?.config!.selectedTextItemColor !=null?
                                  widget.dataObject!.config!.selectedTextItemColor
                                      : widget.dataObject?.config!.textItemColor != null? widget.dataObject!.config!.textItemColor : Colors.black
                                      : widget.dataObject?.config!.textItemColor !=null? widget.dataObject!.config!.textItemColor : Colors.black, fontSize: 16, fontWeight: FontWeight.normal) ,),
                              ),
                            ],
                          ),
                          onPressed: (){
                            setState(() {
                              isOpen = false;
                              widget.dataObject!.selectedItem = index;
                              if(widget.onChange != null){
                                widget.onChange!();
                              }
                            });

                          },);

                      }),
                ),
              ),
            ],
          ),
          ),


        ],
      ),
    );
  }
}

