// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState()';
}


}

/// @nodoc
class $FeedStateCopyWith<$Res>  {
$FeedStateCopyWith(FeedState _, $Res Function(FeedState) __);
}


/// Adds pattern-matching-related methods to [FeedState].
extension FeedStatePatterns on FeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedLoading value)?  loading,TResult Function( FeedError value)?  failure,TResult Function( FeedOk value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedLoading() when loading != null:
return loading(_that);case FeedError() when failure != null:
return failure(_that);case FeedOk() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedLoading value)  loading,required TResult Function( FeedError value)  failure,required TResult Function( FeedOk value)  success,}){
final _that = this;
switch (_that) {
case FeedLoading():
return loading(_that);case FeedError():
return failure(_that);case FeedOk():
return success(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedLoading value)?  loading,TResult? Function( FeedError value)?  failure,TResult? Function( FeedOk value)?  success,}){
final _that = this;
switch (_that) {
case FeedLoading() when loading != null:
return loading(_that);case FeedError() when failure != null:
return failure(_that);case FeedOk() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( AppEx error)?  failure,TResult Function( List<Brewery> breweries,  int currentPage,  PaginationStatus paginationStatus,  AppEx? paginationError,  GeoCoordinates? userPosition)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedLoading() when loading != null:
return loading();case FeedError() when failure != null:
return failure(_that.error);case FeedOk() when success != null:
return success(_that.breweries,_that.currentPage,_that.paginationStatus,_that.paginationError,_that.userPosition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( AppEx error)  failure,required TResult Function( List<Brewery> breweries,  int currentPage,  PaginationStatus paginationStatus,  AppEx? paginationError,  GeoCoordinates? userPosition)  success,}) {final _that = this;
switch (_that) {
case FeedLoading():
return loading();case FeedError():
return failure(_that.error);case FeedOk():
return success(_that.breweries,_that.currentPage,_that.paginationStatus,_that.paginationError,_that.userPosition);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( AppEx error)?  failure,TResult? Function( List<Brewery> breweries,  int currentPage,  PaginationStatus paginationStatus,  AppEx? paginationError,  GeoCoordinates? userPosition)?  success,}) {final _that = this;
switch (_that) {
case FeedLoading() when loading != null:
return loading();case FeedError() when failure != null:
return failure(_that.error);case FeedOk() when success != null:
return success(_that.breweries,_that.currentPage,_that.paginationStatus,_that.paginationError,_that.userPosition);case _:
  return null;

}
}

}

/// @nodoc


class FeedLoading implements FeedState {
  const FeedLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.loading()';
}


}




/// @nodoc


class FeedError implements FeedState {
  const FeedError({required this.error});
  

 final  AppEx error;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedErrorCopyWith<FeedError> get copyWith => _$FeedErrorCopyWithImpl<FeedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'FeedState.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $FeedErrorCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedErrorCopyWith(FeedError value, $Res Function(FeedError) _then) = _$FeedErrorCopyWithImpl;
@useResult
$Res call({
 AppEx error
});




}
/// @nodoc
class _$FeedErrorCopyWithImpl<$Res>
    implements $FeedErrorCopyWith<$Res> {
  _$FeedErrorCopyWithImpl(this._self, this._then);

  final FeedError _self;
  final $Res Function(FeedError) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(FeedError(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppEx,
  ));
}


}

/// @nodoc


class FeedOk implements FeedState {
  const FeedOk({required  List<Brewery> breweries, required this.currentPage, this.paginationStatus = PaginationStatus.idle, this.paginationError, this.userPosition}): _breweries = breweries;
  

 final  List<Brewery> _breweries;
 List<Brewery> get breweries {
  if (_breweries is EqualUnmodifiableListView) return _breweries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_breweries);
}

 final  int currentPage;
@JsonKey() final  PaginationStatus paginationStatus;
 final  AppEx? paginationError;
 final  GeoCoordinates? userPosition;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedOkCopyWith<FeedOk> get copyWith => _$FeedOkCopyWithImpl<FeedOk>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedOk&&const DeepCollectionEquality().equals(other._breweries, _breweries)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.paginationStatus, paginationStatus) || other.paginationStatus == paginationStatus)&&(identical(other.paginationError, paginationError) || other.paginationError == paginationError)&&(identical(other.userPosition, userPosition) || other.userPosition == userPosition));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_breweries),currentPage,paginationStatus,paginationError,userPosition);

@override
String toString() {
  return 'FeedState.success(breweries: $breweries, currentPage: $currentPage, paginationStatus: $paginationStatus, paginationError: $paginationError, userPosition: $userPosition)';
}


}

/// @nodoc
abstract mixin class $FeedOkCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedOkCopyWith(FeedOk value, $Res Function(FeedOk) _then) = _$FeedOkCopyWithImpl;
@useResult
$Res call({
 List<Brewery> breweries, int currentPage, PaginationStatus paginationStatus, AppEx? paginationError, GeoCoordinates? userPosition
});




}
/// @nodoc
class _$FeedOkCopyWithImpl<$Res>
    implements $FeedOkCopyWith<$Res> {
  _$FeedOkCopyWithImpl(this._self, this._then);

  final FeedOk _self;
  final $Res Function(FeedOk) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? breweries = null,Object? currentPage = null,Object? paginationStatus = null,Object? paginationError = freezed,Object? userPosition = freezed,}) {
  return _then(FeedOk(
breweries: null == breweries ? _self._breweries : breweries // ignore: cast_nullable_to_non_nullable
as List<Brewery>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,paginationStatus: null == paginationStatus ? _self.paginationStatus : paginationStatus // ignore: cast_nullable_to_non_nullable
as PaginationStatus,paginationError: freezed == paginationError ? _self.paginationError : paginationError // ignore: cast_nullable_to_non_nullable
as AppEx?,userPosition: freezed == userPosition ? _self.userPosition : userPosition // ignore: cast_nullable_to_non_nullable
as GeoCoordinates?,
  ));
}


}

// dart format on
