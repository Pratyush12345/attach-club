import 'package:attach_club/bloc/search_connections/search_connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchConnectionsTextField extends StatelessWidget {
  final TextEditingController controller;

  const SearchConnectionsTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: 20,
      ),
      child: CustomTextField(
        type: TextFieldType.RegularTextField,
        controller: controller,
        hintText: "Search name...",
        
        color: const Color(0xFF181B2F),
        height: 48,
        fontSize: 16,
        onChanged: (String val){
          if(val.isEmpty){
            context
                .read<SearchConnectionsBloc>().resultsList = [];
          }
        },
        onSubmitted: (String val) {
          if(controller.text.isNotEmpty){
            context
                .read<SearchConnectionsBloc>()
                .add(SearchTriggered(controller.text));
          }
          else{
            context
                .read<SearchConnectionsBloc>().resultsList = [];
          }
          },
        suffixIcon: IconButton(
          onPressed: () {
           if(controller.text.isNotEmpty){
            context
                .read<SearchConnectionsBloc>()
                .add(SearchTriggered(controller.text));
          }
          },
          icon: const Icon(
            Icons.search,
            color: Color(0xFF94969F),
          ),
        ),
        // prefixWidget: const Icon(
        //   Icons.search,
        //   color: Color(0xFF94969F),
        // ),
      ),
    );
  }
}
