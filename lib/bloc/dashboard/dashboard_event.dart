part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class GetData extends DashboardEvent {
  @override
  List<Object?> get props => [];
}

class SendWhatsappMessage extends DashboardEvent {
  final String phoneNo;
  const SendWhatsappMessage(this.phoneNo);
  @override
  List<Object?> get props => [phoneNo];
}