
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/models/social_media.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_link_event.dart';
part 'add_link_state.dart';

class AddLinkBloc extends Bloc<AddLinkEvent, AddLinkState> {
  AddLinkBloc() : super(OnBoard3Initial()) {
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
