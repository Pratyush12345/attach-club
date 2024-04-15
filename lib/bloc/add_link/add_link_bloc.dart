import 'package:attach_club/bloc/add_link/add_link_repository.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/models/social_media.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_link_event.dart';

part 'add_link_state.dart';

class AddLinkBloc extends Bloc<AddLinkEvent, AddLinkState> {
  final AddLinkRepository _repository;

  AddLinkBloc(this._repository) : super(AddLinkInitial()) {
    on<SocialLinkAdded>(_onSocialLinkAdded);
    on<EditSocialLink>(_onEditSocialLink);
    on<DeleteSocialLink>(_onDeleteSocialLink);
    on<UploadSocialLink>(_onUploadSocialLink);
    on<FetchSocialLinks>(_onFetchSocialLinks);
  }

  _onFetchSocialLinks(
    FetchSocialLinks event,
    Emitter<AddLinkState> emit,
  ) async {
    try {
      final list = await _repository.getSocialLinks();
      emit(FetchedSocialLinks(list));
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  _onUploadSocialLink(
    UploadSocialLink event,
    Emitter<AddLinkState> emit,
  ) {
    _repository.uploadSocialLinks(event.list);
  }

  _onDeleteSocialLink(
    DeleteSocialLink event,
    Emitter<AddLinkState> emit,
  ) async{
    await _repository.deleteSocialLink(event.socialLink);
    emit(DeleteFromList(event.socialLink));
    emit(AddLinkInitial());
  }

  _onEditSocialLink(
    EditSocialLink event,
    Emitter<AddLinkState> emit,
  ) {
    try {
      final socialLink = SocialLink(
        title: event.title,
        socialMedia: event.socialMedia,
        link: event.link,
      );
      _repository.addToList(socialLink);
      emit(EditList(event.oldSocialLink, socialLink));
      emit(AddLinkInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  _onSocialLinkAdded(
    SocialLinkAdded event,
    Emitter<AddLinkState> emit,
  ) async {
    try {
      bool check = false;
      for (var i in event.list) {
        if (i.socialMedia.name == event.socialMedia.name) {
          check = true;
          break;
        }
      }
      if (check) {
        return emit(ShowSnackBar("${event.socialMedia.name} already exists"));
      }
      final socialLink = SocialLink(
        title: event.title,
        socialMedia: event.socialMedia,
        link: event.link,
      );
      _repository.addToList(socialLink);
      emit(AddToList(socialLink));
      emit(AddLinkInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }
}
