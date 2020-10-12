import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradaru_tes_iqbal/utilities/style.dart';
bool WishList = false;
int SizeNow;
String ColorNow;
var ListImage;
class DetailScreen extends StatefulWidget {
  var DataTransaction;
  DetailScreen(this.DataTransaction);
  @override
  DetailState createState() => DetailState(DataTransaction);
}
class DetailState extends State<DetailScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  SharedPreferences pref;
  var DataTransaction;
  var DataLoad;
  DetailState(this.DataTransaction);
  @override
  void initState() {
    SizeNow = 5;
    ColorNow = 'yellow';
    DataLoad = DataTransaction;
    WishList = DataLoad.WishList;
    print(DataLoad.WishList);

    ListImage = [
      'assets/images/${DataLoad.Code}_1.jpg',
      'assets/images/${DataLoad.Code}_2.jpg',
      'assets/images/${DataLoad.Code}_3.jpg'
    ];

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MainContent();
  }
  Widget MainContent() {
    return Scaffold(
      key:scaffoldKey,
      // appBar: AppBar(title: Text("Raja Derek")),
      body: contentPage(),
    );
  }
  Widget contentPage(){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 90,),
                        (DataLoad.Discount > 0) ?
                        Center(
                          child: itemDiscount(DataLoad.Discount),
                        ) : VisibleText(),
                        itemImage(),
                        itemDetail(),
                      ],
                    )
                  ),
                ],
              ),
            ),
            headerWidget(),
          ],
        ),
      ),
    );
  }
  headerWidget(){
    return Column(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(top:20),
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back, color: blackColor, size: 30,),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text("X",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Times New Roman'),),
                    Text("E",style: TextStyle(color: secondColor,fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Times New Roman'),),
                  ],
                ),
              ),
              Flexible(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      WishList = WishList == true ? false : true;
                    });
                  },
                  child: (WishList == true) ? Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: redColor.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                    ),

                    child: Icon(Icons.favorite,color: Colors.white,size: 20,),
                  ) : Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.favorite,color: greyColor,size: 23,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  itemDiscount(Discount){
    return (Discount > 0) ? Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 30,
      width: 60,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:2,bottom:2,right: 5,left: 5),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text("${Discount}%",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
    ): VisibleText();
  }
  itemImage(){
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height:  MediaQuery.of(context).size.height / 3,
      color: Colors.white,
      child: Widgetlide(ListImage),
    );
  }
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  List < Widget > buildPageIndicator(ListData) {
    List < Widget > list = [];
    for (int i = 0; i < ListData.length; i++) {
      list.add(i == currentPage ? indicator(true) : indicator(false));
    }
    return list;
  }
  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10,
      width: isActive ? 10 : 10,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }
  Widget Widgetlide(ListImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: (MediaQuery.of(context).size.height / 3) - 10,
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              print(ListImage);
              return Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(ListImage[index]),
                    )
                ),
              );
            },
            itemCount: ListImage.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildPageIndicator(ListImage),
        ),
      ],
    );
  }

  itemDetail(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height / 1.89,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
            topRight:  Radius.circular(30),
            topLeft: Radius.circular(30)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top:16,right: 16,bottom: 8,left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 132,
                  child: AutoSizeText("${DataLoad.Name}" ?? "",maxLines: 1,style: TextStyle(color: primaryColor,fontSize: 25,fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.star,color: yellowColor,size: 25,),
                      Text("(${DataLoad.Rating})",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 16,bottom: 16,left: 16),
            child: AutoSizeText("Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book." ?? "",maxLines: 6,style: TextStyle(color: primaryColor,fontSize: 17)),
          ),
          itemSize(),
          itemColor(),
          itemPrice(),
        ],
      ),
    );
  }
  Widget itemSize(){
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 35,
            child: Text("Size : "),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: Row(
              children: [
                chooseSize(5),
                chooseSize(7),
                chooseSize(8),
                chooseSize(9),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget chooseSize(size){
    return Container(
      margin: EdgeInsets.all(5),
      height: 25,
      width: 40,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:2,bottom:2,right: 5,left: 5),
      decoration: BoxDecoration(
        color: SizeNow == size ? secondColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          setState(() {
            SizeNow = size;
          });
        },
        child: Text("US ${size}",style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),),
      ),
    );
  }
  Widget itemColor(){
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text("Available Color : "),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 132,
            child: Row(
              children: [
                chooseColor('yellow',yellowColor),
                chooseColor('red',redColor),
                chooseColor('pink',pinkColor),
                chooseColor('blue',blueColor),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget chooseColor(value,color){
    return Container(
      margin: EdgeInsets.all(5),
      height: 25,
      width: 25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:2,bottom:2,right: 5,left: 5),
      decoration: BoxDecoration(
        color: ColorNow == value ? color : color,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: ColorNow == value ? color.withOpacity(1.0) : color.withOpacity(0.0),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),

      child: InkWell(
        onTap: (){
          setState(() {
            ColorNow = value;
          });
        },
        child: Text("A",style: TextStyle(color: color),),
      ),
    );
  }
  Widget itemPrice(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: EdgeInsets.only(top: 25,left: 16,right: 16,bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight:  Radius.circular(30),
              topLeft: Radius.circular(30)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\$",style: TextStyle(color: blackColor,fontSize: 20,fontWeight: FontWeight.bold),),
                Text(DataLoad.Price,style: TextStyle(color: blackColor,fontSize: 30,fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),
    );
  }
}