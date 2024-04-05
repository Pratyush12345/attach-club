import 'dart:async';

import 'package:attach_club/core/models/social_media.dart';
import 'package:attach_club/features/on_board3/data/models/social_link.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_board3_event.dart';

part 'on_board3_state.dart';

class OnBoard3Bloc extends Bloc<OnBoard3Event, OnBoard3State> {
  OnBoard3Bloc() : super(OnBoard3Initial()) {
    on<SocialLinkAdded>((event, emit) {
      final socialLink = SocialLink(
        label: event.label,
        socialMedia: event.socialMedia,
        link: event.link,
      );
      emit(AddToList(socialLink));
      emit(OnBoard3Initial());
    });
    on<EditSocialLink>((event, emit){
      final socialLink = SocialLink(
        label: event.label,
        socialMedia: event.socialMedia,
        link: event.link,
      );
      emit(EditList(event.oldSocialLink, socialLink));
      emit(OnBoard3Initial());
    });
    on<DeleteSocialLink>((event, emit){
      emit(DeleteFromList(event.socialLink));
      emit(OnBoard3Initial());
    });
  }
}
