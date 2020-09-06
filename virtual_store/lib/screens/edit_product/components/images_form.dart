
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {

  final Product product;


  const ImagesForm({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state){
        return AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                dotSize: 6,
                autoplay: false,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                images: state.value.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if(image is String)
                        Image.network(image, fit: BoxFit.cover,)
                      else
                        Image.file(image as File, fit: BoxFit.cover,),

                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          color: Colors.red,
                          onPressed: (){
                            state.value.remove(image);
                            state.didChange(state.value);
                          },
                        ),

                      )
                    ],
                  );
                }).toList()..add(
                  Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo,color: primaryColor,size: 50,), 
                      onPressed: (){
                        if(Platform.isAndroid){
                          showModalBottomSheet(
                            context: context, 
                            builder: (_)=> ImageSourceSheet()
                          );
                        }else if(Platform.isIOS){
                          showCupertinoModalPopup(
                            context: context, 
                            builder: (_)=> ImageSourceSheet()
                          );
                        }
                        
                      }),
                  )
                ),
              ),
            );
      },
    );
  }
}