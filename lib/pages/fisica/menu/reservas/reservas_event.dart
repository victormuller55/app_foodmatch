abstract class ReservaEvent {}

class ReservaLoadEvent extends ReservaEvent {}
class ReservaPutEvent extends ReservaEvent {
  int id;
  ReservaPutEvent({required this.id});
}