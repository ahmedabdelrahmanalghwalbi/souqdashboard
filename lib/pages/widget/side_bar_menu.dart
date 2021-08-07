import 'package:dashboardsouq/pages/advertisment/add_advertisment.dart';
import 'package:dashboardsouq/pages/allOrders/all_orders.dart';
import 'package:dashboardsouq/pages/category/category.dart';
import 'package:dashboardsouq/pages/display_products/display_products.dart';
import 'package:dashboardsouq/pages/execlusive_products/execlusive_producrs.dart';
import 'package:dashboardsouq/pages/most_selling/most_sellings.dart';
import 'package:dashboardsouq/pages/special_offers/special_offers.dart';
import 'package:dashboardsouq/pages/users/users.dart';
import 'package:flutter/material.dart';
import 'package:dashboardsouq/common/app_colors.dart';
import 'package:dashboardsouq/pages/Products/addProduct.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.bgSideMenu,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Souq PortSaid",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerListTile(
              title: "المنتجات",
              icon: "assets/menu_home.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProducts()));
              },
            ),
            DrawerListTile(
              title: "عرض المنتجات",
              icon: "assets/menu_home.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DisplayProducts()));
              },
            ),
            DrawerListTile(
              title: "الأصناف",
              icon: "assets/menu_onboarding.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Category()));
              },
            ),
            DrawerListTile(
              title: "المستخدمين",
              icon: "assets/menu_recruitment.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Users()));
              },
            ),
            DrawerListTile(
              title: "عروض خاصة",
              icon: "assets/menu_report.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SpecialOffers()));
              },
            ),
            DrawerListTile(
              title: "الأكثر مبيعا",
              icon: "assets/menu_report.png",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MostSelling()));
              },
            ),
            DrawerListTile(
              title: "منتجات خاصة",
              icon: "assets/menu_report.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExeclusiveProducts()));
              },
            ),
            DrawerListTile(
              title: "الطلبات",
              icon: "assets/menu_report.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllOrders()));
              },
            ),
            DrawerListTile(
              title: "الأعلانات",
              icon: "assets/menu_report.png",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Advertisment()));
              },
            ),
            SizedBox(height: 30,),
            Image.asset("assets/ph.png")
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, icon;
  final VoidCallback press;

  const DrawerListTile({required this.title, required this.icon, required this.press});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        icon,
        color: AppColor.white,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: AppColor.white),
      ),
    );
  }
}
