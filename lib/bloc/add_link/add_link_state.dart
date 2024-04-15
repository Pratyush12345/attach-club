part of 'add_link_bloc.dart';

abstract class AddLinkState extends Equatable {
  const AddLinkState();
}

class AddLinkInitial extends AddLinkState {
  @override
  List<Object> get props => [];
}

class AddToList extends AddLinkState{
  final SocialLink socialLink;

  const AddToList(this.socialLink);

  @override
  List<Object?> get props => [socialLink];

}

class EditList extends AddLinkState{
  final SocialLink oldSocialLink;
  final SocialLink socialLink;

  const EditList(this.oldSocialLink, this.socialLink);

  @override
  List<Object?> get props => [oldSocialLink, socialLink];


}

class DeleteFromList extends AddLinkState{
  final SocialLink socialLink;

  const DeleteFromList(this.socialLink);

  @override
  List<Object?> get props => [socialLink];
}

class NavigateToNextScreen extends AddLinkState {
  @override
  List<Object?> get props => [];

}

class FetchedSocialLinks extends AddLinkState {
  final List<SocialLink> list;

  const FetchedSocialLinks(this.list);

  @override
  List<Object?> get props => [list];
}

class ShowSnackBar extends AddLinkState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}