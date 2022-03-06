// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'brand_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BrandStateTearOff {
  const _$BrandStateTearOff();

  _Initialize initialize() {
    return const _Initialize();
  }

  _NeedSelection needSelection(List<Brand> workingBrands) {
    return _NeedSelection(
      workingBrands,
    );
  }

  _Selected selected(Brand currentBrand) {
    return _Selected(
      currentBrand,
    );
  }
}

/// @nodoc
const $BrandState = _$BrandStateTearOff();

/// @nodoc
mixin _$BrandState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(List<Brand> workingBrands) needSelection,
    required TResult Function(Brand currentBrand) selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_NeedSelection value) needSelection,
    required TResult Function(_Selected value) selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandStateCopyWith<$Res> {
  factory $BrandStateCopyWith(
          BrandState value, $Res Function(BrandState) then) =
      _$BrandStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BrandStateCopyWithImpl<$Res> implements $BrandStateCopyWith<$Res> {
  _$BrandStateCopyWithImpl(this._value, this._then);

  final BrandState _value;
  // ignore: unused_field
  final $Res Function(BrandState) _then;
}

/// @nodoc
abstract class _$InitializeCopyWith<$Res> {
  factory _$InitializeCopyWith(
          _Initialize value, $Res Function(_Initialize) then) =
      __$InitializeCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitializeCopyWithImpl<$Res> extends _$BrandStateCopyWithImpl<$Res>
    implements _$InitializeCopyWith<$Res> {
  __$InitializeCopyWithImpl(
      _Initialize _value, $Res Function(_Initialize) _then)
      : super(_value, (v) => _then(v as _Initialize));

  @override
  _Initialize get _value => super._value as _Initialize;
}

/// @nodoc

class _$_Initialize with DiagnosticableTreeMixin implements _Initialize {
  const _$_Initialize();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrandState.initialize()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'BrandState.initialize'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initialize);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(List<Brand> workingBrands) needSelection,
    required TResult Function(Brand currentBrand) selected,
  }) {
    return initialize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
  }) {
    return initialize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_NeedSelection value) needSelection,
    required TResult Function(_Selected value) selected,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class _Initialize implements BrandState {
  const factory _Initialize() = _$_Initialize;
}

/// @nodoc
abstract class _$NeedSelectionCopyWith<$Res> {
  factory _$NeedSelectionCopyWith(
          _NeedSelection value, $Res Function(_NeedSelection) then) =
      __$NeedSelectionCopyWithImpl<$Res>;
  $Res call({List<Brand> workingBrands});
}

/// @nodoc
class __$NeedSelectionCopyWithImpl<$Res> extends _$BrandStateCopyWithImpl<$Res>
    implements _$NeedSelectionCopyWith<$Res> {
  __$NeedSelectionCopyWithImpl(
      _NeedSelection _value, $Res Function(_NeedSelection) _then)
      : super(_value, (v) => _then(v as _NeedSelection));

  @override
  _NeedSelection get _value => super._value as _NeedSelection;

  @override
  $Res call({
    Object? workingBrands = freezed,
  }) {
    return _then(_NeedSelection(
      workingBrands == freezed
          ? _value.workingBrands
          : workingBrands // ignore: cast_nullable_to_non_nullable
              as List<Brand>,
    ));
  }
}

/// @nodoc

class _$_NeedSelection with DiagnosticableTreeMixin implements _NeedSelection {
  const _$_NeedSelection(this.workingBrands);

  @override
  final List<Brand> workingBrands;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrandState.needSelection(workingBrands: $workingBrands)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrandState.needSelection'))
      ..add(DiagnosticsProperty('workingBrands', workingBrands));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NeedSelection &&
            const DeepCollectionEquality()
                .equals(other.workingBrands, workingBrands));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(workingBrands));

  @JsonKey(ignore: true)
  @override
  _$NeedSelectionCopyWith<_NeedSelection> get copyWith =>
      __$NeedSelectionCopyWithImpl<_NeedSelection>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(List<Brand> workingBrands) needSelection,
    required TResult Function(Brand currentBrand) selected,
  }) {
    return needSelection(workingBrands);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
  }) {
    return needSelection?.call(workingBrands);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
    required TResult orElse(),
  }) {
    if (needSelection != null) {
      return needSelection(workingBrands);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_NeedSelection value) needSelection,
    required TResult Function(_Selected value) selected,
  }) {
    return needSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
  }) {
    return needSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (needSelection != null) {
      return needSelection(this);
    }
    return orElse();
  }
}

abstract class _NeedSelection implements BrandState {
  const factory _NeedSelection(List<Brand> workingBrands) = _$_NeedSelection;

  List<Brand> get workingBrands;
  @JsonKey(ignore: true)
  _$NeedSelectionCopyWith<_NeedSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SelectedCopyWith<$Res> {
  factory _$SelectedCopyWith(_Selected value, $Res Function(_Selected) then) =
      __$SelectedCopyWithImpl<$Res>;
  $Res call({Brand currentBrand});
}

/// @nodoc
class __$SelectedCopyWithImpl<$Res> extends _$BrandStateCopyWithImpl<$Res>
    implements _$SelectedCopyWith<$Res> {
  __$SelectedCopyWithImpl(_Selected _value, $Res Function(_Selected) _then)
      : super(_value, (v) => _then(v as _Selected));

  @override
  _Selected get _value => super._value as _Selected;

  @override
  $Res call({
    Object? currentBrand = freezed,
  }) {
    return _then(_Selected(
      currentBrand == freezed
          ? _value.currentBrand
          : currentBrand // ignore: cast_nullable_to_non_nullable
              as Brand,
    ));
  }
}

/// @nodoc

class _$_Selected with DiagnosticableTreeMixin implements _Selected {
  const _$_Selected(this.currentBrand);

  @override
  final Brand currentBrand;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrandState.selected(currentBrand: $currentBrand)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrandState.selected'))
      ..add(DiagnosticsProperty('currentBrand', currentBrand));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Selected &&
            const DeepCollectionEquality()
                .equals(other.currentBrand, currentBrand));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(currentBrand));

  @JsonKey(ignore: true)
  @override
  _$SelectedCopyWith<_Selected> get copyWith =>
      __$SelectedCopyWithImpl<_Selected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialize,
    required TResult Function(List<Brand> workingBrands) needSelection,
    required TResult Function(Brand currentBrand) selected,
  }) {
    return selected(currentBrand);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
  }) {
    return selected?.call(currentBrand);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialize,
    TResult Function(List<Brand> workingBrands)? needSelection,
    TResult Function(Brand currentBrand)? selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(currentBrand);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialize value) initialize,
    required TResult Function(_NeedSelection value) needSelection,
    required TResult Function(_Selected value) selected,
  }) {
    return selected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
  }) {
    return selected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialize value)? initialize,
    TResult Function(_NeedSelection value)? needSelection,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(this);
    }
    return orElse();
  }
}

abstract class _Selected implements BrandState {
  const factory _Selected(Brand currentBrand) = _$_Selected;

  Brand get currentBrand;
  @JsonKey(ignore: true)
  _$SelectedCopyWith<_Selected> get copyWith =>
      throw _privateConstructorUsedError;
}
