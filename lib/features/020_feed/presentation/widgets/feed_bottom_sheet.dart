import 'package:brewery_forest/features/020_feed/presentation/widgets/brewery_list.dart';
import 'package:brewery_forest/features/020_feed/presentation/widgets/feed_search_bar.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';

class FeedBottomSheet extends StatelessWidget {
  const FeedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final sheetController = DraggableScrollableController();

    return DraggableScrollableSheet(
      controller: sheetController,
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.72,
      snap: true,
      snapSizes: const [0.2, 0.4, 0.72],
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xl),
            ),
          ),
          child: Column(
            children: [
              _SheetHandleDraggable(sheetController: sheetController),

              const Padding(
                padding: .symmetric(horizontal: AppSpacing.gutter),
                child: FeedSearchBar(),
              ),

              const Gap.group(),

              Expanded(child: BreweryList(scrollController: scrollController)),
            ],
          ),
        );
      },
    );
  }
}

class _SheetHandleDraggable extends StatelessWidget {
  final DraggableScrollableController sheetController;

  const _SheetHandleDraggable({required this.sheetController});

  void _onDrag(DragUpdateDetails details, BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final delta = details.primaryDelta! / screenHeight;
    final targetSize = sheetController.size - delta;

    sheetController.jumpTo(targetSize);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .translucent,
      onVerticalDragUpdate: (d) => _onDrag(d, context),
      child: const Padding(
        padding: .symmetric(vertical: AppSpacing.gutter),
        child: SheetHandle(),
      ),
    );
  }
}
