import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gscm_store_owner/Accessories/shimmer_block.dart';
import 'package:gscm_store_owner/Constant/app_theme.dart';
import 'package:gscm_store_owner/Model/event.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sự kiện đang diễn ra:'),
              Consumer(
                builder: (context, ref, child) {
                  final eventState = ref.watch(eventNotifierProvider);
                  return eventState.when(
                    loading: () => const ShimmerBlock(
                        width: double.infinity, height: 60),
                    data: (currentEvent, eventList) {
                      return _buildActiveEvent(currentEvent);
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Danh sách sự kiện'),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline_rounded),
                  )
                ],
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final eventState = ref.watch(eventNotifierProvider);
                    return eventState.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      data: (currentEvent, eventList) => ListView.separated(
                        itemCount: eventList.length,
                        separatorBuilder: (context, index) => const Divider(
                        height: 0,
                        thickness: 1.125,
                      ),
                        itemBuilder: (context, index) => ListTile(
                          title: Text(eventList[index].name),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveEvent(Event? event) {
    bool isActive = event != null;
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? kPrimaryColor : kNeutralColor,
            width: 3,
          )),
      child: Center(
        child: Text(
          isActive ? event.name : 'Chưa có sự kiện nào đang diễn ra',
          maxLines: 2,
          style: TextStyle(
            color: isActive ? kPrimaryColor : kNeutralColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
