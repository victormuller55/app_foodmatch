abstract class ReservasJuridicoEvent {}

class ReservasJuridicoLoadEvent extends ReservasJuridicoEvent {}

class ReservaJuridicoPutEvent extends ReservasJuridicoEvent {
  int id;
  ReservaJuridicoPutEvent({required this.id});
}