import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:expandable/expandable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/app_button.dart';
import 'package:gscm_store_owner/Accessories/dialog.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/event.dart';
import 'package:gscm_store_owner/Model/product.dart';
import 'package:gscm_store_owner/ViewModel/Event/event_detail_notifier.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  late final Event event;
  final bool isCreating;

  EventDetailScreen({
    Key? key,
    Event? currentEvent,
    this.isCreating = false,
  }) : super(key: key) {
    if (!isCreating && currentEvent != null) {
      event = Event.clone(currentEvent);
    } else {
      event = Event(id: -1, name: '', productCount: 0, status: 0, details: []);
    }
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  //final List<ExpandableController> _expandableControllers = [];
  //int _expControllerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(eventDetailProvider(widget.event));
    _controller.text = model.event.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
        actions: [
          IconButton(
            onPressed: () async {
              late bool result;
              showLoadingDialog();
              if (widget.isCreating) {
                result = await model.createEvent();
              } else {
                result = await model.updateEvent();
              }
              hideDialog();
              if (result) {
                Fluttertoast.showToast(
                  msg: (widget.isCreating)
                      ? 'Tạo sự kiện thành công'
                      : 'Cập nhật sự kiện thành công',
                );
                await Future.delayed(const Duration(seconds: 1));
                Get.back();
              }
            },
            icon: const Icon(Icons.check),
            splashRadius: 1,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                'Tên sự kiện',
                style: kListTilePrimaryText.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ReactiveTextField(
                controller: _controller,
                formControl: FormControl<String>(
                  value: model.event.name,
                  validators: [Validators.required],
                ),
                onSubmitted: () => model.event.name = _controller.text,
                decoration: kTextInputDecoration,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'Danh sách sản phẩm',
                  style: kListTilePrimaryText.copyWith(fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => showModelAddProduct(context, model),
                  icon: const Icon(Icons.add_circle_outline),
                  splashRadius: 1,
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: model.event.details.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                  thickness: 1.125,
                ),
                itemBuilder: (context, index) {
                  return /* ExpandableNotifier(
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        hasIcon: false,
                      ),
                      expanded: ReactiveFormBuilder(
                        form: () => fb.group(
                          {
                            'productId': model.event.details[index].productId,
                            'newPrice': [
                              model.event.details[index].newPrice,
                              Validators.required,
                            ],
                          },
                        ),
                        builder: (context, form, child) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 70),
                                const Text('Giá mới   ',
                                    style: kListTilePrimaryText),
                                SizedBox(
                                  width: 120,
                                  child: ReactiveTextField(
                                    formControlName: 'newPrice',
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      //isCollapsed: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 0),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ReactiveFormConsumer(
                                  builder: (context, formGroup, child) =>
                                      Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: TextButton(
                                      onPressed: () {
                                        if (formGroup.valid) {
                                          /* _expandableControllers[index]
                                              .toggle(); */
                                          model.changeNewPrice(formGroup.value);
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: (formGroup.valid)
                                            ? kPrimaryColor
                                            : kNeutralColor200,
                                      ),
                                      child: Text(
                                        'Lưu',
                                        style: kListTilePrimaryText.copyWith(
                                          color: (formGroup.valid)
                                              ? kWhite
                                              : kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      header: */
                      _buildProductTile(model,
                          index); /* ,
                      collapsed: const SizedBox.shrink(),
                    ),
                  ); */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTile(EventDetailNotifier model, int index) {
    String productName = model.event.details[index].productName;
    String firstLetter = productName[0];
    String sku = model.event.details[index].sku;
    String newPrice = NumberFormat.currency(locale: 'vi')
        .format(model.event.details[index].newPrice);
    String originalPrice = NumberFormat.currency(locale: 'vi')
        .format(model.event.details[index].originalPrice);
    Color boxColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return Builder(builder: (context) {
      /* final expController = ExpandableController.of(context);
      _expandableControllers.add(expController!); */
      return SizedBox(
        height: 80,
        child: SwipeActionCell(
          key: ObjectKey(model.event.details[index]),
          trailingActions: <SwipeAction>[
            SwipeAction(
              title: 'Xóa',
              color: kDangerColor,
              onTap: (CompletionHandler handler) async {
                await handler(true);
                model.event.details.removeAt(index);
                //_expandableControllers.removeAt(index);
                setState(() {});
              },
            ),
          ],
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
            onTap: () {
              changePriceDialog(ref, model.event.details[index], model);
              /* if (!_expandableControllers[index].expanded) {
                if (_expandableControllers[_expControllerIndex].expanded) {
                  _expandableControllers[_expControllerIndex].toggle();
                }
                _expControllerIndex = index;
              }
              _expandableControllers[index].toggle(); */
            },
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: boxColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      firstLetter,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: boxColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: kListTilePrimaryText,
                      ),
                      Text(
                        sku,
                        style: kListTileSecondaryText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        newPrice,
                        style: kListTileMoneyText,
                      ),
                      Text(
                        originalPrice,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void showModelAddProduct(BuildContext context, EventDetailNotifier model) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        return ReactiveFormBuilder(
          form: () => fb.group(
            {
              'product': FormControl<Product>(
                validators: [Validators.required],
              ),
              'newPrice': FormControl<int>(
                validators: [Validators.required, Validators.min(0)],
              ),
            },
          ),
          builder: (context, formGroup, child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sản phẩm', style: kInputTitleTextStyle),
                  const SizedBox(height: 5),
                  ReactiveDropdownField<Product>(
                    items: model.products
                        .map((product) => DropdownMenuItem(
                              child: Text(product.name),
                              value: product,
                            ))
                        .toList(),
                    formControlName: 'product',
                    decoration: kTextInputDecoration,
                  ),
                  const SizedBox(height: 16),
                  const Text('Giá khuyến mãi', style: kInputTitleTextStyle),
                  const SizedBox(height: 5),
                  ReactiveTextField<int>(
                    formControlName: 'newPrice',
                    keyboardType: TextInputType.number,
                    decoration: kTextInputDecoration,
                  ),
                  const SizedBox(height: 18),
                  ReactiveFormConsumer(
                    builder: ((context, formGroup, child) => MainButton(
                          onTap: () {
                            if (formGroup.valid) {
                              bool result = model.addNewProduct(formGroup.value);
                              if(!result) {
                                Fluttertoast.showToast(msg: 'Sản phẩm đã có trong danh sách');
                              }
                              Navigator.pop(context);
                            }
                          },
                          text: Text(
                            'Thêm mới',
                            style: TextStyle(
                              color: (formGroup.valid) ? kWhite : kPrimaryColor,
                              fontSize: 16,
                            ),
                          ),
                          bgColor: (formGroup.valid)
                              ? kPrimaryColor
                              : kNeutralColor200,
                          height: 45,
                          width: double.infinity,
                        )),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void changePriceDialog(WidgetRef ref, EventDetail detail, EventDetailNotifier model) async {
    TextEditingController controller = TextEditingController();
    controller.text = detail.newPrice.toString();
    await Get.dialog(
      Dialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: SizedBox(
          height: 240,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 55, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Giá gốc: ${detail.originalPrice} VNĐ', style: kInputTitleTextStyle),
                    const SizedBox(height: 10),
                    const Text('Giá mới', style: kInputTitleTextStyle),
                    const SizedBox(height: 6),
                    TextField(
                      controller: controller,
                      decoration: kTextInputDecoration,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                        onPressed: () async {
                          final data = {
                            'productId': detail.productId,
                            'newPrice': int.parse(controller.text),
                          };
                          model.changeNewPrice(data);
                          Get.back();
                        },
                        child: const Text(
                          'Lưu',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Container(
                    //color: kDangerColor,
                    decoration: BoxDecoration(
                      color: kDangerColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: kWhite,
                    ),
                  ),
                  splashColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
