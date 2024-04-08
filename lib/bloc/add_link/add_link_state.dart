part of 'add_link_bloc.dart';

abstract class AddLinkState extends Equatable {
  const AddLinkState();
}

class OnBoard3Initial extends AddLinkState {
  @override
  List<Object> get props => [];
}

class AddToList extends AddLinkState{
  final SocialLink socialLink;

  AddToList(this.socialLink);

  @override
  List<Object?> get props => [socialLink];

}

class EditList extends AddLinkState{
  final SocialLink oldSocialLink;
  final SocialLink socialLink;

  EditList(this.oldSocialLink, this.socialLink);

  @override
  List<Object?> get props => [oldSocialLink, socialLink];


}

class DeleteFromList extends AddLinkState{
  final SocialLink socialLink;

  const DeleteFromList(this.socialLink);

  @override
  List<Object?> get props => [socialLink];
}