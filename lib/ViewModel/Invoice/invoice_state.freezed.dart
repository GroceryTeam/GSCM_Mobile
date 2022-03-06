// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$InvoiceStateTearOff {
  const _$InvoiceStateTearOff();

  _Loading loading() {
    return const _Loading();
  }

  _Data data(
      {required List<Bill> bills,
      required List<Receipt> receipts,
      required DateTime startDate,
      required DateTime endDate}) {
    return _Data(
      bills: bills,
      receipts: receipts,
      startDate: startDate,
      endDate: endDate,
    );
  }

  _NoData noData(DateTime startDate, DateTime enddate) {
    return _NoData(
      startDate,
      enddate,
    );
  }
}

/// @nodoc
const $InvoiceState = _$InvoiceStateTearOff();

/// @nodoc
mixin _$InvoiceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)
        data,
    required TResult Function(DateTime startDate, DateTime enddate) noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Data value) data,
    required TResult Function(_NoData value) noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceStateCopyWith<$Res> {
  factory $InvoiceStateCopyWith(
          InvoiceState value, $Res Function(InvoiceState) then) =
      _$InvoiceStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$InvoiceStateCopyWithImpl<$Res> implements $InvoiceStateCopyWith<$Res> {
  _$InvoiceStateCopyWithImpl(this._value, this._then);

  final InvoiceState _value;
  // ignore: unused_field
  final $Res Function(InvoiceState) _then;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
}

/// @nodoc

class _$_Loading with DiagnosticableTreeMixin implements _Loading {
  const _$_Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InvoiceState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'InvoiceState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)
        data,
    required TResult Function(DateTime startDate, DateTime enddate) noData,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Data value) data,
    required TResult Function(_NoData value) noData,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements InvoiceState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$DataCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) then) =
      __$DataCopyWithImpl<$Res>;
  $Res call(
      {List<Bill> bills,
      List<Receipt> receipts,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class __$DataCopyWithImpl<$Res> extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(_Data _value, $Res Function(_Data) _then)
      : super(_value, (v) => _then(v as _Data));

  @override
  _Data get _value => super._value as _Data;

  @override
  $Res call({
    Object? bills = freezed,
    Object? receipts = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_Data(
      bills: bills == freezed
          ? _value.bills
          : bills // ignore: cast_nullable_to_non_nullable
              as List<Bill>,
      receipts: receipts == freezed
          ? _value.receipts
          : receipts // ignore: cast_nullable_to_non_nullable
              as List<Receipt>,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_Data with DiagnosticableTreeMixin implements _Data {
  const _$_Data(
      {required this.bills,
      required this.receipts,
      required this.startDate,
      required this.endDate});

  @override
  final List<Bill> bills;
  @override
  final List<Receipt> receipts;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InvoiceState.data(bills: $bills, receipts: $receipts, startDate: $startDate, endDate: $endDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InvoiceState.data'))
      ..add(DiagnosticsProperty('bills', bills))
      ..add(DiagnosticsProperty('receipts', receipts))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('endDate', endDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Data &&
            const DeepCollectionEquality().equals(other.bills, bills) &&
            const DeepCollectionEquality().equals(other.receipts, receipts) &&
            const DeepCollectionEquality().equals(other.startDate, startDate) &&
            const DeepCollectionEquality().equals(other.endDate, endDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(bills),
      const DeepCollectionEquality().hash(receipts),
      const DeepCollectionEquality().hash(startDate),
      const DeepCollectionEquality().hash(endDate));

  @JsonKey(ignore: true)
  @override
  _$DataCopyWith<_Data> get copyWith =>
      __$DataCopyWithImpl<_Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)
        data,
    required TResult Function(DateTime startDate, DateTime enddate) noData,
  }) {
    return data(bills, receipts, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
  }) {
    return data?.call(bills, receipts, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(bills, receipts, startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Data value) data,
    required TResult Function(_NoData value) noData,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data implements InvoiceState {
  const factory _Data(
      {required List<Bill> bills,
      required List<Receipt> receipts,
      required DateTime startDate,
      required DateTime endDate}) = _$_Data;

  List<Bill> get bills;
  List<Receipt> get receipts;
  DateTime get startDate;
  DateTime get endDate;
  @JsonKey(ignore: true)
  _$DataCopyWith<_Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$NoDataCopyWith<$Res> {
  factory _$NoDataCopyWith(_NoData value, $Res Function(_NoData) then) =
      __$NoDataCopyWithImpl<$Res>;
  $Res call({DateTime startDate, DateTime enddate});
}

/// @nodoc
class __$NoDataCopyWithImpl<$Res> extends _$InvoiceStateCopyWithImpl<$Res>
    implements _$NoDataCopyWith<$Res> {
  __$NoDataCopyWithImpl(_NoData _value, $Res Function(_NoData) _then)
      : super(_value, (v) => _then(v as _NoData));

  @override
  _NoData get _value => super._value as _NoData;

  @override
  $Res call({
    Object? startDate = freezed,
    Object? enddate = freezed,
  }) {
    return _then(_NoData(
      startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      enddate == freezed
          ? _value.enddate
          : enddate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_NoData with DiagnosticableTreeMixin implements _NoData {
  const _$_NoData(this.startDate, this.enddate);

  @override
  final DateTime startDate;
  @override
  final DateTime enddate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InvoiceState.noData(startDate: $startDate, enddate: $enddate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InvoiceState.noData'))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('enddate', enddate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoData &&
            const DeepCollectionEquality().equals(other.startDate, startDate) &&
            const DeepCollectionEquality().equals(other.enddate, enddate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(startDate),
      const DeepCollectionEquality().hash(enddate));

  @JsonKey(ignore: true)
  @override
  _$NoDataCopyWith<_NoData> get copyWith =>
      __$NoDataCopyWithImpl<_NoData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)
        data,
    required TResult Function(DateTime startDate, DateTime enddate) noData,
  }) {
    return noData(startDate, enddate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
  }) {
    return noData?.call(startDate, enddate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Bill> bills, List<Receipt> receipts,
            DateTime startDate, DateTime endDate)?
        data,
    TResult Function(DateTime startDate, DateTime enddate)? noData,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData(startDate, enddate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Data value) data,
    required TResult Function(_NoData value) noData,
  }) {
    return noData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
  }) {
    return noData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    TResult Function(_NoData value)? noData,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData(this);
    }
    return orElse();
  }
}

abstract class _NoData implements InvoiceState {
  const factory _NoData(DateTime startDate, DateTime enddate) = _$_NoData;

  DateTime get startDate;
  DateTime get enddate;
  @JsonKey(ignore: true)
  _$NoDataCopyWith<_NoData> get copyWith => throw _privateConstructorUsedError;
}
