import 'package:get/get.dart';
import 'package:test_telegram_mini_app/components/dismiss_keyboard.dart';
import 'package:test_telegram_mini_app/modules/modal/entities/request_state.dart';
import 'package:test_telegram_mini_app/services/connectivity_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'entities/modal_sheet_state.dart';

class ModalController extends GetxController {
  final ConnectivityService connectivityService =
      Get.find<ConnectivityService>();

  final Rx<ModalSheetState> sheetState = ModalSheetState.half.obs;
  final RxDouble sheetHeight = 0.0.obs;
  final RxString url = ''.obs;
  final Rx<RequestState> requestState = RequestState.loading.obs;

  late final WebViewController webViewController;

  double minHeight = 80.0;
  double halfHeight = 0.0;
  double maxHeight = 0.0;

  double? _dragStartHeight;

  final Duration animationDuration = const Duration(milliseconds: 300);

  @override
  void onInit() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            requestState.value = RequestState.success;
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {
            if (error.description.contains('net::ERR_BLOCKED_BY_ORB') ==
                false) {
              requestState.value = RequestState.error;
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    super.onInit();
    maxHeight = Get.height;
    halfHeight = Get.height * 0.5;
    minHeight = 80.0;
  }

  void open(String urlToOpen) async {
    sheetHeight.value = halfHeight;
    sheetState.value = ModalSheetState.half;
    requestState.value = RequestState.loading;
    KeyboardService.instance.dismiss();
    webViewController.loadRequest(Uri.parse(urlToOpen));
  }

  void expand() {
    sheetState.value = ModalSheetState.expanded;
    sheetHeight.value = maxHeight;
  }

  void half() {
    sheetState.value = ModalSheetState.half;
    sheetHeight.value = halfHeight;
  }

  void collapse() {
    sheetState.value = ModalSheetState.collapsed;
    sheetHeight.value = minHeight;
  }

  void close() {
    sheetState.value = ModalSheetState.closed;
    url.value = '';
    sheetHeight.value = 0.0;
  }

  void onDragUpdate(double dy) {
    if (_dragStartHeight == null) return;
    final newHeight = (_dragStartHeight! - dy * 15).clamp(minHeight, maxHeight);
    sheetHeight.value = newHeight;
  }

  void onDragEnd() {
    if (sheetHeight.value >= maxHeight * 0.85) {
      expand();
    } else if (sheetHeight.value <= minHeight + 40) {
      collapse();
    } else {
      half();
    }
  }

  void onDragStart() {
    _dragStartHeight = sheetHeight.value;
  }
}
