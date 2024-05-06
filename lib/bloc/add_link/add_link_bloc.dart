import 'package:attach_club/bloc/add_link/add_link_repository.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/models/social_media.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_link_event.dart';

part 'add_link_state.dart';

class AddLinkBloc extends Bloc<AddLinkEvent, AddLinkState> {
  final AddLinkRepository _repository;
  List<SocialLink> list = [];
  DateTime? lastUpdated;

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
      emit(AddLinkLoading());
      list = await _repository.getSocialLinks();
      lastUpdated = DateTime.now();
      emit(const FetchedSocialLinks());
      emit(AddLinkInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  _onUploadSocialLink(
    UploadSocialLink event,
    Emitter<AddLinkState> emit,
  ) async {
    await _repository.uploadSocialLinks(event.list);
    lastUpdated = DateTime.now();
    emit(const FetchedSocialLinks());
    emit(AddLinkInitial());
  }

  _onDeleteSocialLink(
    DeleteSocialLink event,
    Emitter<AddLinkState> emit,
  ) async{
    try {
      emit(AddLinkLoading());
      await _repository.deleteSocialLink(event.socialLink);
      list.remove(event.socialLink);
      lastUpdated = DateTime.now();
      emit(const FetchedSocialLinks());
      emit(AddLinkInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  _onEditSocialLink(
    EditSocialLink event,
    Emitter<AddLinkState> emit,
  ) async {
    try {
      emit(AddLinkLoading());
      final socialLink = SocialLink(
        title: event.title,
        socialMedia: event.socialMedia,
        link: event.link,
        isEnabled: !event.disabled,
      );
      await _repository.addToList(socialLink);
      list.remove(event.oldSocialLink);
      list.add(socialLink);
      lastUpdated = DateTime.now();
      emit(const FetchedSocialLinks());
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
      emit(AddLinkLoading());
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
        isEnabled: !event.disabled,
      );
      _repository.addToList(socialLink);
      list.add(socialLink);
      lastUpdated = DateTime.now();
      emit(const FetchedSocialLinks());
      emit(AddLinkInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }
}
