// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState()';
}


}

/// @nodoc
class $SearchStateCopyWith<$Res>  {
$SearchStateCopyWith(SearchState _, $Res Function(SearchState) __);
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchIdle value)?  idle,TResult Function( SearchLoading value)?  loading,TResult Function( SearchFailure value)?  failure,TResult Function( SearchSuccess value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchFailure() when failure != null:
return failure(_that);case SearchSuccess() when success != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchIdle value)  idle,required TResult Function( SearchLoading value)  loading,required TResult Function( SearchFailure value)  failure,required TResult Function( SearchSuccess value)  success,}){
final _that = this;
switch (_that) {
case SearchIdle():
return idle(_that);case SearchLoading():
return loading(_that);case SearchFailure():
return failure(_that);case SearchSuccess():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchIdle value)?  idle,TResult? Function( SearchLoading value)?  loading,TResult? Function( SearchFailure value)?  failure,TResult? Function( SearchSuccess value)?  success,}){
final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchFailure() when failure != null:
return failure(_that);case SearchSuccess() when success != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function( AppEx error)?  failure,TResult Function( List<Brewery> breweries)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle();case SearchLoading() when loading != null:
return loading();case SearchFailure() when failure != null:
return failure(_that.error);case SearchSuccess() when success != null:
return success(_that.breweries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function( AppEx error)  failure,required TResult Function( List<Brewery> breweries)  success,}) {final _that = this;
switch (_that) {
case SearchIdle():
return idle();case SearchLoading():
return loading();case SearchFailure():
return failure(_that.error);case SearchSuccess():
return success(_that.breweries);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function( AppEx error)?  failure,TResult? Function( List<Brewery> breweries)?  success,}) {final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle();case SearchLoading() when loading != null:
return loading();case SearchFailure() when failure != null:
return failure(_that.error);case SearchSuccess() when success != null:
return success(_that.breweries);case _:
  return null;

}
}

}

/// @nodoc


class SearchIdle implements SearchState {
  const SearchIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.idle()';
}


}




/// @nodoc


class SearchLoading implements SearchState {
  const SearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.loading()';
}


}




/// @nodoc


class SearchFailure implements SearchState {
  const SearchFailure({required this.error});
  

 final  AppEx error;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFailureCopyWith<SearchFailure> get copyWith => _$SearchFailureCopyWithImpl<SearchFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'SearchState.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $SearchFailureCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchFailureCopyWith(SearchFailure value, $Res Function(SearchFailure) _then) = _$SearchFailureCopyWithImpl;
@useResult
$Res call({
 AppEx error
});




}
/// @nodoc
class _$SearchFailureCopyWithImpl<$Res>
    implements $SearchFailureCopyWith<$Res> {
  _$SearchFailureCopyWithImpl(this._self, this._then);

  final SearchFailure _self;
  final $Res Function(SearchFailure) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(SearchFailure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppEx,
  ));
}


}

/// @nodoc


class SearchSuccess implements SearchState {
  const SearchSuccess({required  List<Brewery> breweries}): _breweries = breweries;
  

 final  List<Brewery> _breweries;
 List<Brewery> get breweries {
  if (_breweries is EqualUnmodifiableListView) return _breweries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_breweries);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSuccessCopyWith<SearchSuccess> get copyWith => _$SearchSuccessCopyWithImpl<SearchSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSuccess&&const DeepCollectionEquality().equals(other._breweries, _breweries));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_breweries));

@override
String toString() {
  return 'SearchState.success(breweries: $breweries)';
}


}

/// @nodoc
abstract mixin class $SearchSuccessCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchSuccessCopyWith(SearchSuccess value, $Res Function(SearchSuccess) _then) = _$SearchSuccessCopyWithImpl;
@useResult
$Res call({
 List<Brewery> breweries
});




}
/// @nodoc
class _$SearchSuccessCopyWithImpl<$Res>
    implements $SearchSuccessCopyWith<$Res> {
  _$SearchSuccessCopyWithImpl(this._self, this._then);

  final SearchSuccess _self;
  final $Res Function(SearchSuccess) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? breweries = null,}) {
  return _then(SearchSuccess(
breweries: null == breweries ? _self._breweries : breweries // ignore: cast_nullable_to_non_nullable
as List<Brewery>,
  ));
}


}

// dart format on
