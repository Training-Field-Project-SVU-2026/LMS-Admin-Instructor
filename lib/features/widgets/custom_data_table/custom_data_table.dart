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

  const CustomDataTable({
    super.key,
    required this.headers,
    required this.data,
    this.isLoading = false,
    this.isPaginationLoading = false,
    this.scrollController,
    this.showIndex = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Table Header
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
                SizedBox(width: 48.w),
                if (showIndex) _buildHeaderCell(context.tr('number'), flex: 1),
                ...headers.map((h) => _buildHeaderCell(h)),
                _buildHeaderCell(""),
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
                    Checkbox(
                      value: false,
                      onChanged: (v) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      side: BorderSide(color: context.colorScheme.outline),
                    ),

                    if (showIndex) _buildDataCell("${index + 1}", flex: 1),

                    ...item.rowTexts.map((text) => _buildDataCell(text)),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: item.onOptions,
                          splashRadius: 20.r,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: context.colorScheme.error,
                          ),
                          onPressed: item.onAction,
                          splashRadius: 20.r,
                        ),
                      ],
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
      child: Center(child: Text(text, textAlign: TextAlign.center)),
    );
  }

  Widget _buildDataCell(String text, {int flex = 2}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
