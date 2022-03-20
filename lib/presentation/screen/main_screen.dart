import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/di/locator.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/screen/main/tab_assist.dart';
import 'package:teamvisual/presentation/screen/main/tab_modules.dart';
import 'package:teamvisual/presentation/screen/other_page.dart';
import 'package:teamvisual/presentation/viewmodel/main_view_model.dart';
import 'package:teamvisual/presentation/widgets/item_drawer_menu.dart';

class MainScreen extends RootWidget<MainViewModel> {
  MainScreen() : super(getIt());

  final Map<int, Widget> _viewCache = <int, Widget>{};

  late TabModules _tabModules;
  late TabAssist _tabAssist;
  final _listScreen = OtherPage("hi");

  @override
  void init() {
    super.init();
    _tabModules = TabModules(mainViewModel: viewModel);
    _tabAssist = TabAssist();
  }

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            viewModel.currentTabTile,
            style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500),
          ),
          elevation: 0,
        ),
        body: getViewForIndex(viewModel.currentTabIndex),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                viewModel.userName,
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500),
              ),
              accountEmail: Text(
                viewModel.userType,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500),
              ),
              currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/img_logo.png',
                      height: 30,
                    ),
                  ),
                  onTap: () => {}),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/background_nav_drawer.jpeg'),
                ),
              ),
            ),
            ItemDrawerMenu(
              title: "Módulos",
              icon: Icons.more_time,
              onClick: () {
                viewModel.setCurrentTab(0, "Módulos");
                Navigator.of(context).pop();
              },
            ),
            if (viewModel.assistModuleOn)
              ItemDrawerMenu(
                title: "Asistencia",
                icon: Icons.quiz_rounded,
                onClick: () {
                  viewModel.setCurrentTab(1, "Asistencia");
                  Navigator.of(context).pop();
                },
              ),
            if (viewModel.quizModuleOn)
              ItemDrawerMenu(
                title: "Encuestas",
                icon: Icons.cloud_upload,
                onClick: () {
                  viewModel.setCurrentTab(2, "Encuestas");
                  Navigator.of(context).pop();
                },
              ),
            if (viewModel.thirdModuleOn)
              ItemDrawerMenu(
                title: "Módulo 3",
                icon: Icons.quiz_rounded,
                onClick: () {
                  viewModel.setCurrentTab(1, "Módulo 3");
                  Navigator.of(context).pop();
                },
              ),
            if (viewModel.fourthModuleOn)
              ItemDrawerMenu(
                title: "Módulo 4",
                icon: Icons.cloud_upload,
                onClick: () {
                  viewModel.setCurrentTab(2, "Módulo 4");
                  Navigator.of(context).pop();
                },
              ),
            const Divider(
              thickness: 1.0,
            ),
            ListTile(
              title: const Text("Close"),
              trailing: const Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        )));
  }

  Widget getViewForIndex(int index) {
    print("get view from index $index");
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = _tabModules;
          break;
        case 1:
          _viewCache[index] = _tabAssist;
          break;
        case 2:
          _viewCache[index] = _listScreen;
          break;
      }
    }
    print("view cache ${_viewCache[index]}");
    return _viewCache[index]!;
  }
}
