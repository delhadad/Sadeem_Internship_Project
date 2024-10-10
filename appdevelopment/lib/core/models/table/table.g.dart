// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Table> _$tableSerializer = new _$TableSerializer();

class _$TableSerializer implements StructuredSerializer<Table> {
  @override
  final Iterable<Type> types = const [Table, _$Table];
  @override
  final String wireName = 'Table';

  @override
  Iterable<Object?> serialize(Serializers serializers, Table object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.is_available;
    if (value != null) {
      result
        ..add('is_available')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.is_need_service;
    if (value != null) {
      result
        ..add('is_need_service')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.vendor;
    if (value != null) {
      result
        ..add('vendor')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Vendor)));
    }
    value = object.customer;
    if (value != null) {
      result
        ..add('customer')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(User)));
    }
    return result;
  }

  @override
  Table deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TableBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'is_available':
          result.is_available = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'is_need_service':
          result.is_need_service = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'vendor':
          result.vendor.replace(serializers.deserialize(value,
              specifiedType: const FullType(Vendor))! as Vendor);
          break;
        case 'customer':
          result.customer.replace(serializers.deserialize(value,
              specifiedType: const FullType(User))! as User);
          break;
      }
    }

    return result.build();
  }
}

class _$Table extends Table {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final bool? is_available;
  @override
  final bool? is_need_service;
  @override
  final Vendor? vendor;
  @override
  final User? customer;

  factory _$Table([void Function(TableBuilder)? updates]) =>
      (new TableBuilder()..update(updates))._build();

  _$Table._(
      {this.id,
      this.name,
      this.is_available,
      this.is_need_service,
      this.vendor,
      this.customer})
      : super._();

  @override
  Table rebuild(void Function(TableBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TableBuilder toBuilder() => new TableBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Table &&
        id == other.id &&
        name == other.name &&
        is_available == other.is_available &&
        is_need_service == other.is_need_service &&
        vendor == other.vendor &&
        customer == other.customer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, is_available.hashCode);
    _$hash = $jc(_$hash, is_need_service.hashCode);
    _$hash = $jc(_$hash, vendor.hashCode);
    _$hash = $jc(_$hash, customer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Table')
          ..add('id', id)
          ..add('name', name)
          ..add('is_available', is_available)
          ..add('is_need_service', is_need_service)
          ..add('vendor', vendor)
          ..add('customer', customer))
        .toString();
  }
}

class TableBuilder implements Builder<Table, TableBuilder> {
  _$Table? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _is_available;
  bool? get is_available => _$this._is_available;
  set is_available(bool? is_available) => _$this._is_available = is_available;

  bool? _is_need_service;
  bool? get is_need_service => _$this._is_need_service;
  set is_need_service(bool? is_need_service) =>
      _$this._is_need_service = is_need_service;

  VendorBuilder? _vendor;
  VendorBuilder get vendor => _$this._vendor ??= new VendorBuilder();
  set vendor(VendorBuilder? vendor) => _$this._vendor = vendor;

  UserBuilder? _customer;
  UserBuilder get customer => _$this._customer ??= new UserBuilder();
  set customer(UserBuilder? customer) => _$this._customer = customer;

  TableBuilder();

  TableBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _is_available = $v.is_available;
      _is_need_service = $v.is_need_service;
      _vendor = $v.vendor?.toBuilder();
      _customer = $v.customer?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Table other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Table;
  }

  @override
  void update(void Function(TableBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Table build() => _build();

  _$Table _build() {
    _$Table _$result;
    try {
      _$result = _$v ??
          new _$Table._(
              id: id,
              name: name,
              is_available: is_available,
              is_need_service: is_need_service,
              vendor: _vendor?.build(),
              customer: _customer?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vendor';
        _vendor?.build();
        _$failedField = 'customer';
        _customer?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Table', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
