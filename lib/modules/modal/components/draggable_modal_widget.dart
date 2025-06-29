import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_telegram_mini_app/modules/modal/entities/modal_sheet_state.dart';
import 'package:test_telegram_mini_app/modules/modal/entities/request_state.dart';
import 'package:test_telegram_mini_app/modules/modal/modal_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DraggableModalWidget extends GetView<ModalController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.sheetState.value == ModalSheetState.closed) {
        return const SizedBox.shrink();
      }
      return AnimatedPositioned(
        duration: controller.animationDuration,
        curve: Curves.ease,
        left: 0,
        right: 0,
        bottom: controller.sheetHeight.value - Get.height,
        child: SizedBox(
          height: Get.height,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onVerticalDragStart: (details) {
                    controller.onDragStart();
                  },
                  onVerticalDragUpdate: (details) {
                    controller.onDragUpdate(details.delta.dy);
                  },
                  onVerticalDragEnd: (details) {
                    controller.onDragEnd();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: controller.animationDuration,
                        height: controller.sheetState.value ==
                                ModalSheetState.expanded
                            ? MediaQuery.of(context).padding.top
                            : 0,
                      ),
                      AnimatedCrossFade(
                        firstChild: _buildHeader(context),
                        secondChild: const SizedBox.shrink(),
                        crossFadeState: controller.sheetHeight.value == 0
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: controller.animationDuration,
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (controller.connectivityService.haveConnection.value ==
                      false) {
                    return const Center(
                        child: Text(
                      'No internet',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ));
                  } else if (controller.requestState.value ==
                      RequestState.loading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else if (controller.requestState.value ==
                      RequestState.error) {
                    return const Center(
                      child: Text(
                        'ERROR!',
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: WebViewWidget(
                          controller: controller.webViewController),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        if (controller.sheetState.value == ModalSheetState.collapsed)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: controller.close,
          )
        else
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: controller.collapse,
          ),
        // ... ще можна додати drag handle
      ],
    );
  }
}
