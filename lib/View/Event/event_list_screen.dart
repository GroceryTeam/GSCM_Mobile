import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gscm_store_owner/Accessories/dialog.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/View/Event/even_detail_screen.dart';
import 'package:gscm_store_owner/ViewModel/Event/event_notifier.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sự kiện'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActiveEvent(),
                const SizedBox(height: 20),
                _buildEventList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveEvent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kNeutralColor100,
        boxShadow: [
          BoxShadow(
            color: kNeutralColor.withOpacity(0.2),
            offset: const Offset(0, 7),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đang diễn ra',
            style: kListTilePrimaryText.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final eventState = ref.watch(eventNotifierProvider);
              return eventState.when(
                loading: () => const SizedBox.shrink(),
                data: (currentEvent, eventList) {
                  return Text(
                    currentEvent?.name ?? 'Chưa có sự kiện nào đang diễn ra',
                    maxLines: 2,
                    style: TextStyle(
                      color: (currentEvent != null)
                          ? kPrimaryColor
                          : kNeutralColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kNeutralColor100,
        boxShadow: [
          BoxShadow(
            color: kNeutralColor.withOpacity(0.2),
            offset: const Offset(0, 7),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Danh sách sự kiện',
                style: kListTilePrimaryText.copyWith(fontSize: 16),
              ),
              IconButton(
                onPressed: () {
                  Get.to(
                    () => EventDetailScreen(
                      currentEvent: null,
                      isCreating: true,
                    ),
                  );
                },
                icon: const Icon(Icons.add_circle_outline_rounded),
                splashColor: Colors.transparent,
              )
            ],
          ),
          const Divider(
            height: 0,
            thickness: 1.125,
          ),
          Consumer(
            builder: (context, ref, child) {
              final eventState = ref.watch(eventNotifierProvider);
              return eventState.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                data: (currentEvent, eventList) => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: eventList.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    thickness: 1.125,
                  ),
                  itemBuilder: (context, index) => ListTile(
                    title: Text(eventList[index].name),
                    trailing: Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: (eventList[index].status == 0),
                        fillColor: MaterialStateProperty.all(kPrimaryColor),
                        shape: const CircleBorder(),
                        onChanged: (bool? value) {
                          late int status;
                          if (value!) {
                            status = 0;
                          } else {
                            status = 1;
                          }
                          showLoadingDialog();
                          ref
                              .read(eventNotifierProvider.notifier)
                              .updateEventStatus(status, eventList[index].id);
                          hideDialog();
                        },
                      ),
                    ),
                    onTap: () => Get.to(
                      () => EventDetailScreen(currentEvent: eventList[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
