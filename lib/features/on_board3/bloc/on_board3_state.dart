part of 'on_board3_bloc.dart';

abstract class OnBoard3State extends Equatable {
  const OnBoard3State();
}

class OnBoard3Initial extends OnBoard3State {
  @override
  List<Object> get props => [];
}

class AddToList extends OnBoard3State{
  final SocialLink socialLink;

  AddToList(this.socialLink);

  @override
  List<Object?> get props => [socialLink];

}

class EditList extends OnBoard3State{
  final SocialLink oldSocialLink;
  final SocialLink socialLink;

  EditList(this.oldSocialLink, this.socialLink);

  @override
  List<Object?> get props => [oldSocialLink, socialLink];


}

class DeleteFromList extends OnBoard3State{
  final SocialLink socialLink;

  const DeleteFromList(this.socialLink);

  @override
  List<Object?> get props => [socialLink];
}