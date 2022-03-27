import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/di/locator.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/screen/main/tab_assist.dart';
import 'package:teamvisual/presentation/screen/main/tab_modules.dart';
import 'package:teamvisual/presentation/screen/main/tab_courses.dart';
import 'package:teamvisual/presentation/screen/main/tab_pending.dart';
import 'package:teamvisual/presentation/viewmodel/main_view_model.dart';
import 'package:teamvisual/presentation/widgets/item_drawer_menu.dart';

import '../../main.dart';
import '../widgets/custom_dialog.dart';

class MainScreen extends RootWidget<MainViewModel> {
  MainScreen() : super(getIt());

  final Map<int, Widget> _viewCache = <int, Widget>{};

  late TabModules _tabModules;
  late TabAssist _tabAssist;
  late TabCourses _tabQuiz;
  late TabPending _tabPending;

  @override
  void init(BuildContext context) {
    super.init(context);
    _tabModules = TabModules(mainViewModel: viewModel);
    _tabAssist = TabAssist();
    _tabQuiz = TabCourses();
    _tabPending = TabPending();
  }

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ValueListenableBuilder(
        valueListenable: hideMainAppBar,
        builder: (context, value, widget) {
          final hide = value as bool;
          return Scaffold(
            drawerEdgeDragWidth: hide ? 20.0 : 0.0,
            appBar: AppBar(
              automaticallyImplyLeading: hide,
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
                    icon: Icons.list_alt,
                    onClick: () {
                      viewModel.setCurrentTab(0, "Módulos");
                      Navigator.of(context).pop();
                    },
                  ),
                  if (viewModel.assistModuleOn)
                    ItemDrawerMenu(
                      title: "Asistencia",
                      icon: Icons.camera_alt,
                      onClick: () {
                        viewModel.setCurrentTab(1, "Asistencia");
                        Navigator.of(context).pop();
                      },
                    ),
                  if (viewModel.quizModuleOn)
                    ItemDrawerMenu(
                      title: "Cursos",
                      icon: Icons.playlist_add_check_outlined,
                      onClick: () {
                        viewModel.setCurrentTab(2, "Cursos");
                        Navigator.of(context).pop();
                      },
                    ),
                  if (viewModel.thirdModuleOn)
                    ItemDrawerMenu(
                      title: "Módulo 3",
                      icon: Icons.quiz_rounded,
                      onClick: () {
                      },
                    ),
                  if (viewModel.fourthModuleOn)
                    ItemDrawerMenu(
                      title: "Módulo 4",
                      icon: Icons.cloud_upload,
                      onClick: () {
                      },
                    ),
                  ItemDrawerMenu(
                    title: "Pendientes",
                    icon: Icons.cloud_upload,
                    onClick: () {
                      viewModel.setCurrentTab(5, "Pendientes");
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  ListTile(
                    title: Text(
                      "Cerrar sesión",
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.logout,
                      color: Colors.black87,
                    ),
                    onTap: () => _showDialogLogOut(context),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = _tabModules;
          break;
        case 1:
          _viewCache[index] = _tabAssist;
          break;
        case 2:
          _viewCache[index] = _tabQuiz;
          break;
        case 5:
          _viewCache[index] = _tabPending;
          break;
      }
    }
    return _viewCache[index]!;
  }

  void _showDialogLogOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Atención",
        description: "¿Desea cerrar sesión?",
        firstButtonText: "No",
        secondButtonText: "Si",
        color: Colors.blueAccent,
        icon: CupertinoIcons.checkmark_alt,
        secondClick: () => {
          Navigator.of(context).pop(),
          Navigator.of(context).pop(),
        },
      ),
    );
  }
}
