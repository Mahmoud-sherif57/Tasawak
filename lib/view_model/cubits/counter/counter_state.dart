abstract class CounterState {}

final class InitialCounterState extends CounterState {}

final class IncrementCounterState extends CounterState {}

final class DecrementCounterState extends CounterState {}

final class ResetCounterState extends CounterState {}

final class AddingNewInput extends CounterState {}

final class RemovingCounter extends CounterState {}

final class RemovingInputs extends CounterState {}

// here we create our states which extends from (CounterState) to send it to (CounterCubit) ,
