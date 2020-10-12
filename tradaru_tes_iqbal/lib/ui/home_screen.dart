import 'dart:io';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradaru_tes_iqbal/models/category.dart';
import 'package:tradaru_tes_iqbal/models/product.dart';
import 'package:tradaru_tes_iqbal/services/navigation_service.dart';
import 'package:tradaru_tes_iqbal/utilities/style.dart';
import 'package:tradaru_tes_iqbal/constant/route_names.dart' as routes;
import '../locator.dart';
final NavigationService navigationService = locator<NavigationService>();
class HomeScreen extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<HomeScreen>{
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences pref;
  int page = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  List ListProduct, ListProductSneakers,ListProductWatch,ListProductBag,Listcategory;
  LoadData(){
    ListProductSneakers = [
      Product('nike_1','sneakers','Nike Air Max 270','220.00',5.0,30,true),
      Product('nike_2','sneakers','Asics Quantum 180 5','200.00',4.0,0,false),
      Product('nike_3','sneakers','Nike Air Max 270','20.00',3.0,0,false),
      Product('nike_4','sneakers','Nike Air Max 2090','220.00',4.0,30,false),
    ];
    ListProductWatch = [
      Product('watch_1','watch','Kogan Active+ Smart Watch','69.99',5.0,30,true),
      Product('watch_2','watch','Kogan Pulse (Mulberry Gold)','49.99',5.0,0,false),
      Product('watch_3','watch','Kogan Hybrid (Arctic White)','69.99',5.0,0,false),
    ];
    ListProductBag = [
      Product('bag_1','bag','Nike Sportswear Elemental Backpack','49.99',5.0,30,true),
      Product('bag_2','bag','Nike Youth Brasilia Backpack','39.99',5.0,0,false),
    ];
    Listcategory = [
      Category('sneakers','Sneakers','assets/images/sneakers.png'),
      Category('watch','Watch','assets/images/watchs.png'),
      Category('backpack','Backpacks','assets/images/bags.png'),
    ];
  }
  Future < Map > RefreshData() {
    setState(() {});
    return LoadData();
  }
  Future<Map> getSession() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
    });
  }
  @override
  void initState() {
    LoadData();
    ListProduct = ListProductSneakers;
    super.initState();
  }
  @override
  void dispose() {
    LoadData();
    getSession();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MainContent();
  }
  Widget MainContent() {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.drafts, size: 30, color:primaryColor),
          Icon(Icons.favorite, size: 30, color:greyColor),
          Icon(Icons.shopping_cart, size: 30, color:(Page == 2) ? primaryColor : primaryColor),
          Icon(Icons.assignment, size: 30, color:greyColor),
          Icon(Icons.person, size: 30,color:greyColor),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
            LoadData();
          });
        },
      ),
      key:scaffoldKey,
      // appBar: AppBar(title: Text("Raja Derek")),
      body: contentPage(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(40),
                  // bottomRight: Radius.circular(150),
                  // topRight: Radius.circular(100)
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                ],
              ),
            ),
            itemMenu('logout','Keluar',LineAwesomeIcons.sign_out,"logout"),
          ],
        ),
      ),
    );
  }
  Widget contentPage(){
    if(page == 0 || page == 2){
      return pageProduct();
    } else {
      return pageBlank();
    }
  }
  Widget pageBlank(){
   return AnnotatedRegion<SystemUiOverlayStyle>(
     value: SystemUiOverlayStyle.light,
     child: Container(
       decoration: BoxDecoration(
           color: bgColor
       ),
       child: Stack(
         children: [
           SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                   child: Padding(
                     padding: EdgeInsets.all(20),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[

                       ],
                     ),
                   ),
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
  Widget pageProduct(){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        decoration: BoxDecoration(
            color: bgColor
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 130,),
                          (ListProduct != null) ?
                          Column(
                            children: [
                              // orderBerjalanCard(DataOngoing),
                              GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: (itemWidth / itemHeight),
                                controller: new ScrollController(keepScrollOffset: false),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: ListProduct.map((data) {
                                  return  itemProductCard(data);
                                }).toList(),
                              ),
                            ],
                          )
                              : VisibleText(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  color: bgColor,
                  // margin: EdgeInsets.only(top:80),
                  padding: EdgeInsets.only(top:80,left: 16,bottom: 8,right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Our Product",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 110,left: 8,right: 8,bottom: 10),
                  height: 50,
                  child: new ListView.builder(
                    itemCount: Listcategory.length,
                    itemBuilder: (context, index){
                    return itemCategory(Listcategory[index]);
                  }, scrollDirection: Axis.horizontal,),
                ),
              ],
            ),
            headerWidget(),
          ],
        ),
      ),
    );
  }
  Widget itemCategory(item){
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          print(item.Code);
          LoadData();
          setState(() {
            if(item.Code == "sneakers"){
              ListProduct = ListProductSneakers;
            } else if(item.Code == "watch"){
              ListProduct = ListProductWatch;
            } else if(item.Code == "backpack"){
              ListProduct = ListProductBag;
            } else {
              ListProduct = null;
            }
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(item.Image,height: 50,width: 50,),
            Text(item.Name,style: TextStyle(fontSize:12,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
  Widget itemProductCard(item){
    var product_image = "assets/images/${item.Code}_1.jpg";
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal:16.0),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(18),
      // ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     spreadRadius: 0.2,
          //     // blurRadius: 0.1,
          //   ),
          // ],
      ),
      child: InkWell(
        onTap: (){
          navigationService.navigateTo(routes.DetailScreenRoute,arguments: item);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemDiscount(item.Discount),
                  itemWithList(item.WishList),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(product_image),
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: AutoSizeText("${item.Name}" ?? "",maxLines: 1,style: TextStyle(color: primaryColor,fontSize: 14)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("\$",style: TextStyle(color: primaryColor,fontSize: 11,fontWeight: FontWeight.bold),),
                  Text(item.Price,style: TextStyle(color: primaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            itemRating(item.Rating),
          ],
        ),
      )
    );
  }
  itemDiscount(Discount){
    return (Discount > 0) ? Container(
      height: 16,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:2,bottom:2,right: 5,left: 5),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text("${Discount}%",style: TextStyle(fontSize:10,fontWeight: FontWeight.bold),),
    ): VisibleText();
  }
  itemWithList(Discount){
    return (Discount == true) ? Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(Icons.favorite,color: Colors.white,size: 13,),
    ) : Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      padding: EdgeInsets.all(2),
      child: Icon(Icons.favorite,color: greyColor,size: 13,),
    );
  }
  itemRating(Rating){
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemStar(Rating,1),
              itemStar(Rating,2),
              itemStar(Rating,3),
              itemStar(Rating,4),
              itemStar(Rating,5),
            ],
          ),
          Text("(${Rating})",style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
  itemStar(Rating,Num){
    return (Rating >= Num) ? Icon(Icons.star,color: yellowColor,size: 13,) : Icon(Icons.star_border,color: yellowColor,size: 13,);
  }
  itemMenu(method, title,icon,route){
    return ListTile(
      leading: icon != null ? Icon(icon,color: Colors.black,) : Text(""),
      title: Text(title),
      onTap: () async {
        if(route == "logout"){
          LogOut();
        }
      },
    );
  }
  headerWidget(){
    return Column(
      children: <Widget>[
        Container(
          color: bgColor,
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
                    LoadData();
                    scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    LineAwesomeIcons.navicon,
                    color: blackColor,
                  ),
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

                  },
                  child: Icon(
                    Icons.search,
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  LogOut() async {
    pref = await SharedPreferences.getInstance();
    pref?.clear();
    return exit(0);
  }
}