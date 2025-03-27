import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfReader extends StatelessWidget {
  const PdfReader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.white,
        elevation: 1,
        scrolledUnderElevation:1,

        title: Text("Umumiy pedagogik darslik"),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: SfPdfViewer.asset(
          "assets/pdf/umumiy_pedagogika.pdf",
          onAnnotationAdded: (annotation) {
            print(annotation);
          },
          pageSpacing: 1,
          canShowPageLoadingIndicator: true,
          canShowHyperlinkDialog: true,
          canShowPaginationDialog: true,
          canShowScrollHead: true,
          canShowSignaturePadDialog: true,
          enableDoubleTapZooming: true,
          enableHyperlinkNavigation: true,
           canShowTextSelectionMenu: true,
          canShowScrollStatus: true,
          interactionMode: PdfInteractionMode.selection,
          maxZoomLevel: 5,
          pageLayoutMode: PdfPageLayoutMode.continuous,


          currentSearchTextHighlightColor: Colors.white,
          otherSearchTextHighlightColor: Colors.white,
        ),
      ),
    );
  }
}
