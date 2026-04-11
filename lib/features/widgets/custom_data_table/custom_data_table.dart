import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> headers;
  final List<CustomDataTableRowModel> data;
  final bool isLoading;
  final bool isPaginationLoading;
  final ScrollController? scrollController;
  final bool showIndex;
  final List<int>? columnFlex;

  const CustomDataTable({
    super.key,
    required this.headers,
    required this.data,
    this.isLoading = false,
    this.isPaginationLoading = false,
    this.scrollController,
    this.showIndex = true,
    this.columnFlex,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: context.colorScheme.outline.withValues(alpha: 0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
            ),
          ),
          child: DefaultTextStyle(
            style: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            child: Row(
              children: [
                SizedBox(width: 56.w), 
                if (showIndex) _buildHeaderCell(context.tr('number'), flex: 1),
                ...List.generate(headers.length, (index) {
                  return _buildHeaderCell(
                    headers[index],
                    flex: columnFlex != null && columnFlex!.length > index
                        ? columnFlex![index]
                        : 2,
                  );
                }),
                SizedBox(width: 150.w), 
              ],
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: data.length + (isPaginationLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == data.length) {
                return Padding(
                  padding: EdgeInsets.all(16.r),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              final item = data[index];
              final isEven = index % 2 == 0;

              return Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isEven
                      ? context.colorScheme.surface
                      : context.colorScheme.surfaceVariant,
                  border: Border(
                    bottom: BorderSide(
                      color: context.colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 56.w,
                      child: Center(
                        child: Checkbox(
                          value: false,
                          onChanged: (v) {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          side: BorderSide(color: context.colorScheme.outline),
                        ),
                      ),
                    ),

                    if (showIndex) _buildDataCell("${index + 1}", flex: 1),

                    ...List.generate(item.rowTexts.length, (rowIndex) {
                      return _buildDataCell(
                        item.rowTexts[rowIndex],
                        flex: columnFlex != null && columnFlex!.length > rowIndex
                            ? columnFlex![rowIndex]
                            : 2,
                      );
                    }),

                    SizedBox(
                      width: 150.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.more_horiz),
                            onPressed: item.onOptions,
                            splashRadius: 20.r,
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.delete_outline,
                              color: context.colorScheme.error,
                            ),
                            onPressed: item.onAction,
                            splashRadius: 20.r,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 2}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: flex == 1
            ? Alignment.center
            : AlignmentDirectional.centerStart,
        child: Text(
          text,
          textAlign: flex == 1 ? TextAlign.center : TextAlign.start,
          style: const TextStyle(inherit: true),
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {int flex = 2}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: flex == 1
            ? Alignment.center
            : AlignmentDirectional.centerStart,
        child: Text(
          text,
          textAlign: flex == 1 ? TextAlign.center : TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
