import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamvisual/di/locator.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/pending_view_model.dart';

class TabPending extends RootWidget<PendingViewModel> {
  TabPending() : super(getIt());

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return Column(
      children: [
        Opacity(
          opacity: viewModel.totalAssistPending > 0 ? 1.0 : 0.4,
          child: GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(
                  "Asistencia",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                trailing: Container(
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      viewModel.totalAssistPending.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              elevation: 2,
              shadowColor: Colors.indigo,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
            onTap: () => viewModel.sendAssistsPending(context),
          ),
        ),
        Opacity(
          opacity: viewModel.totalEvaluationsPending > 0 ? 1.0 : 0.4,
          child: GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(
                  "Evaluaciones",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                trailing: Container(
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      viewModel.totalEvaluationsPending.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              elevation: 2,
              shadowColor: Colors.indigo,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
            onTap: () => viewModel.sendEvaluationsPending(context),
          ),
        ),
      ],
    );
  }
}
