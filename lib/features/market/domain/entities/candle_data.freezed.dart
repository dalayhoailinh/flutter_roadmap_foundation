// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candle_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CandleData {

 DateTime get time; double get open; double get high; double get low; double get close;
/// Create a copy of CandleData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandleDataCopyWith<CandleData> get copyWith => _$CandleDataCopyWithImpl<CandleData>(this as CandleData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandleData&&(identical(other.time, time) || other.time == time)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}


@override
int get hashCode => Object.hash(runtimeType,time,open,high,low,close);

@override
String toString() {
  return 'CandleData(time: $time, open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class $CandleDataCopyWith<$Res>  {
  factory $CandleDataCopyWith(CandleData value, $Res Function(CandleData) _then) = _$CandleDataCopyWithImpl;
@useResult
$Res call({
 DateTime time, double open, double high, double low, double close
});




}
/// @nodoc
class _$CandleDataCopyWithImpl<$Res>
    implements $CandleDataCopyWith<$Res> {
  _$CandleDataCopyWithImpl(this._self, this._then);

  final CandleData _self;
  final $Res Function(CandleData) _then;

/// Create a copy of CandleData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CandleData].
extension CandleDataPatterns on CandleData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandleData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandleData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandleData value)  $default,){
final _that = this;
switch (_that) {
case _CandleData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandleData value)?  $default,){
final _that = this;
switch (_that) {
case _CandleData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  double open,  double high,  double low,  double close)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandleData() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  double open,  double high,  double low,  double close)  $default,) {final _that = this;
switch (_that) {
case _CandleData():
return $default(_that.time,_that.open,_that.high,_that.low,_that.close);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  double open,  double high,  double low,  double close)?  $default,) {final _that = this;
switch (_that) {
case _CandleData() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close);case _:
  return null;

}
}

}

/// @nodoc


class _CandleData implements CandleData {
  const _CandleData({required this.time, required this.open, required this.high, required this.low, required this.close});
  

@override final  DateTime time;
@override final  double open;
@override final  double high;
@override final  double low;
@override final  double close;

/// Create a copy of CandleData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandleDataCopyWith<_CandleData> get copyWith => __$CandleDataCopyWithImpl<_CandleData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandleData&&(identical(other.time, time) || other.time == time)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}


@override
int get hashCode => Object.hash(runtimeType,time,open,high,low,close);

@override
String toString() {
  return 'CandleData(time: $time, open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class _$CandleDataCopyWith<$Res> implements $CandleDataCopyWith<$Res> {
  factory _$CandleDataCopyWith(_CandleData value, $Res Function(_CandleData) _then) = __$CandleDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, double open, double high, double low, double close
});




}
/// @nodoc
class __$CandleDataCopyWithImpl<$Res>
    implements _$CandleDataCopyWith<$Res> {
  __$CandleDataCopyWithImpl(this._self, this._then);

  final _CandleData _self;
  final $Res Function(_CandleData) _then;

/// Create a copy of CandleData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_CandleData(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
