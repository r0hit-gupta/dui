// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetNodeCollection on Isar {
  IsarCollection<Node> get nodes => getCollection();
}

const NodeSchema = CollectionSchema(
  name: 'Node',
  schema:
      '{"name":"Node","idName":"id","properties":[{"name":"depth","type":"Long"},{"name":"ext","type":"String"},{"name":"formattedSize","type":"String"},{"name":"fullName","type":"String"},{"name":"fullPath","type":"String"},{"name":"isDirectory","type":"Bool"},{"name":"name","type":"String"},{"name":"parentPath","type":"String"},{"name":"size","type":"Long"}],"indexes":[{"name":"fullPath","unique":true,"properties":[{"name":"fullPath","type":"Hash","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'depth': 0,
    'ext': 1,
    'formattedSize': 2,
    'fullName': 3,
    'fullPath': 4,
    'isDirectory': 5,
    'name': 6,
    'parentPath': 7,
    'size': 8
  },
  listProperties: {},
  indexIds: {'fullPath': 0},
  indexValueTypes: {
    'fullPath': [
      IndexValueType.stringHashCIS,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _nodeGetId,
  setId: _nodeSetId,
  getLinks: _nodeGetLinks,
  attachLinks: _nodeAttachLinks,
  serializeNative: _nodeSerializeNative,
  deserializeNative: _nodeDeserializeNative,
  deserializePropNative: _nodeDeserializePropNative,
  serializeWeb: _nodeSerializeWeb,
  deserializeWeb: _nodeDeserializeWeb,
  deserializePropWeb: _nodeDeserializePropWeb,
  version: 3,
);

int? _nodeGetId(Node object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _nodeSetId(Node object, int id) {
  object.id = id;
}

List<IsarLinkBase> _nodeGetLinks(Node object) {
  return [];
}

void _nodeSerializeNative(IsarCollection<Node> collection, IsarRawObject rawObj,
    Node object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.depth;
  final _depth = value0;
  final value1 = object.ext;
  IsarUint8List? _ext;
  if (value1 != null) {
    _ext = IsarBinaryWriter.utf8Encoder.convert(value1);
  }
  dynamicSize += (_ext?.length ?? 0) as int;
  final value2 = object.formattedSize;
  final _formattedSize = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_formattedSize.length) as int;
  final value3 = object.fullName;
  final _fullName = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_fullName.length) as int;
  final value4 = object.fullPath;
  final _fullPath = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_fullPath.length) as int;
  final value5 = object.isDirectory;
  final _isDirectory = value5;
  final value6 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_name.length) as int;
  final value7 = object.parentPath;
  final _parentPath = IsarBinaryWriter.utf8Encoder.convert(value7);
  dynamicSize += (_parentPath.length) as int;
  final value8 = object.size;
  final _size = value8;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _depth);
  writer.writeBytes(offsets[1], _ext);
  writer.writeBytes(offsets[2], _formattedSize);
  writer.writeBytes(offsets[3], _fullName);
  writer.writeBytes(offsets[4], _fullPath);
  writer.writeBool(offsets[5], _isDirectory);
  writer.writeBytes(offsets[6], _name);
  writer.writeBytes(offsets[7], _parentPath);
  writer.writeLong(offsets[8], _size);
}

Node _nodeDeserializeNative(IsarCollection<Node> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Node(
    fullPath: reader.readString(offsets[4]),
    size: reader.readLong(offsets[8]),
  );
  object.id = id;
  return object;
}

P _nodeDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _nodeSerializeWeb(IsarCollection<Node> collection, Node object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'depth', object.depth);
  IsarNative.jsObjectSet(jsObj, 'ext', object.ext);
  IsarNative.jsObjectSet(jsObj, 'formattedSize', object.formattedSize);
  IsarNative.jsObjectSet(jsObj, 'fullName', object.fullName);
  IsarNative.jsObjectSet(jsObj, 'fullPath', object.fullPath);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'isDirectory', object.isDirectory);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'parentPath', object.parentPath);
  IsarNative.jsObjectSet(jsObj, 'size', object.size);
  return jsObj;
}

Node _nodeDeserializeWeb(IsarCollection<Node> collection, dynamic jsObj) {
  final object = Node(
    fullPath: IsarNative.jsObjectGet(jsObj, 'fullPath') ?? '',
    size: IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity,
  );
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _nodeDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'depth':
      return (IsarNative.jsObjectGet(jsObj, 'depth') ?? double.negativeInfinity)
          as P;
    case 'ext':
      return (IsarNative.jsObjectGet(jsObj, 'ext')) as P;
    case 'formattedSize':
      return (IsarNative.jsObjectGet(jsObj, 'formattedSize') ?? '') as P;
    case 'fullName':
      return (IsarNative.jsObjectGet(jsObj, 'fullName') ?? '') as P;
    case 'fullPath':
      return (IsarNative.jsObjectGet(jsObj, 'fullPath') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'isDirectory':
      return (IsarNative.jsObjectGet(jsObj, 'isDirectory') ?? false) as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'parentPath':
      return (IsarNative.jsObjectGet(jsObj, 'parentPath') ?? '') as P;
    case 'size':
      return (IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity)
          as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _nodeAttachLinks(IsarCollection col, int id, Node object) {}

extension NodeByIndex on IsarCollection<Node> {
  Future<Node?> getByFullPath(String fullPath) {
    return getByIndex('fullPath', [fullPath]);
  }

  Node? getByFullPathSync(String fullPath) {
    return getByIndexSync('fullPath', [fullPath]);
  }

  Future<bool> deleteByFullPath(String fullPath) {
    return deleteByIndex('fullPath', [fullPath]);
  }

  bool deleteByFullPathSync(String fullPath) {
    return deleteByIndexSync('fullPath', [fullPath]);
  }

  Future<List<Node?>> getAllByFullPath(List<String> fullPathValues) {
    final values = fullPathValues.map((e) => [e]).toList();
    return getAllByIndex('fullPath', values);
  }

  List<Node?> getAllByFullPathSync(List<String> fullPathValues) {
    final values = fullPathValues.map((e) => [e]).toList();
    return getAllByIndexSync('fullPath', values);
  }

  Future<int> deleteAllByFullPath(List<String> fullPathValues) {
    final values = fullPathValues.map((e) => [e]).toList();
    return deleteAllByIndex('fullPath', values);
  }

  int deleteAllByFullPathSync(List<String> fullPathValues) {
    final values = fullPathValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('fullPath', values);
  }
}

extension NodeQueryWhereSort on QueryBuilder<Node, Node, QWhere> {
  QueryBuilder<Node, Node, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<Node, Node, QAfterWhere> anyFullPath() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'fullPath'));
  }
}

extension NodeQueryWhere on QueryBuilder<Node, Node, QWhereClause> {
  QueryBuilder<Node, Node, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Node, Node, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Node, Node, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Node, Node, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Node, Node, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Node, Node, QAfterWhereClause> fullPathEqualTo(String fullPath) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'fullPath',
      value: [fullPath],
    ));
  }

  QueryBuilder<Node, Node, QAfterWhereClause> fullPathNotEqualTo(
      String fullPath) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'fullPath',
        upper: [fullPath],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'fullPath',
        lower: [fullPath],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'fullPath',
        lower: [fullPath],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'fullPath',
        upper: [fullPath],
        includeUpper: false,
      ));
    }
  }
}

extension NodeQueryFilter on QueryBuilder<Node, Node, QFilterCondition> {
  QueryBuilder<Node, Node, QAfterFilterCondition> depthEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> depthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> depthLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'depth',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> depthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'depth',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'ext',
      value: null,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'ext',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'ext',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'ext',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'ext',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'ext',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'ext',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'ext',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> extMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'ext',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'formattedSize',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'formattedSize',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'formattedSize',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'formattedSize',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'formattedSize',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'formattedSize',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'formattedSize',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> formattedSizeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'formattedSize',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fullName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fullName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fullName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fullName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fullName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fullName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fullName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fullName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fullPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fullPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fullPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fullPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fullPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fullPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fullPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> fullPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fullPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> isDirectoryEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isDirectory',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'parentPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'parentPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'parentPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'parentPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'parentPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> parentPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'parentPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> sizeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> sizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> sizeLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<Node, Node, QAfterFilterCondition> sizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'size',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension NodeQueryLinks on QueryBuilder<Node, Node, QFilterCondition> {}

extension NodeQueryWhereSortBy on QueryBuilder<Node, Node, QSortBy> {
  QueryBuilder<Node, Node, QAfterSortBy> sortByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByExt() {
    return addSortByInternal('ext', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByExtDesc() {
    return addSortByInternal('ext', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByFormattedSize() {
    return addSortByInternal('formattedSize', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByFormattedSizeDesc() {
    return addSortByInternal('formattedSize', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByFullName() {
    return addSortByInternal('fullName', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByFullNameDesc() {
    return addSortByInternal('fullName', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByFullPath() {
    return addSortByInternal('fullPath', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByFullPathDesc() {
    return addSortByInternal('fullPath', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByIsDirectory() {
    return addSortByInternal('isDirectory', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByIsDirectoryDesc() {
    return addSortByInternal('isDirectory', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByParentPath() {
    return addSortByInternal('parentPath', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortByParentPathDesc() {
    return addSortByInternal('parentPath', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> sortBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }
}

extension NodeQueryWhereSortThenBy on QueryBuilder<Node, Node, QSortThenBy> {
  QueryBuilder<Node, Node, QAfterSortBy> thenByDepth() {
    return addSortByInternal('depth', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByDepthDesc() {
    return addSortByInternal('depth', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByExt() {
    return addSortByInternal('ext', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByExtDesc() {
    return addSortByInternal('ext', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByFormattedSize() {
    return addSortByInternal('formattedSize', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByFormattedSizeDesc() {
    return addSortByInternal('formattedSize', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByFullName() {
    return addSortByInternal('fullName', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByFullNameDesc() {
    return addSortByInternal('fullName', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByFullPath() {
    return addSortByInternal('fullPath', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByFullPathDesc() {
    return addSortByInternal('fullPath', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByIsDirectory() {
    return addSortByInternal('isDirectory', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByIsDirectoryDesc() {
    return addSortByInternal('isDirectory', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByParentPath() {
    return addSortByInternal('parentPath', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenByParentPathDesc() {
    return addSortByInternal('parentPath', Sort.desc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<Node, Node, QAfterSortBy> thenBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }
}

extension NodeQueryWhereDistinct on QueryBuilder<Node, Node, QDistinct> {
  QueryBuilder<Node, Node, QDistinct> distinctByDepth() {
    return addDistinctByInternal('depth');
  }

  QueryBuilder<Node, Node, QDistinct> distinctByExt(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('ext', caseSensitive: caseSensitive);
  }

  QueryBuilder<Node, Node, QDistinct> distinctByFormattedSize(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('formattedSize', caseSensitive: caseSensitive);
  }

  QueryBuilder<Node, Node, QDistinct> distinctByFullName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fullName', caseSensitive: caseSensitive);
  }

  QueryBuilder<Node, Node, QDistinct> distinctByFullPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fullPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Node, Node, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Node, Node, QDistinct> distinctByIsDirectory() {
    return addDistinctByInternal('isDirectory');
  }

  QueryBuilder<Node, Node, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Node, Node, QDistinct> distinctByParentPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('parentPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Node, Node, QDistinct> distinctBySize() {
    return addDistinctByInternal('size');
  }
}

extension NodeQueryProperty on QueryBuilder<Node, Node, QQueryProperty> {
  QueryBuilder<Node, int, QQueryOperations> depthProperty() {
    return addPropertyNameInternal('depth');
  }

  QueryBuilder<Node, String?, QQueryOperations> extProperty() {
    return addPropertyNameInternal('ext');
  }

  QueryBuilder<Node, String, QQueryOperations> formattedSizeProperty() {
    return addPropertyNameInternal('formattedSize');
  }

  QueryBuilder<Node, String, QQueryOperations> fullNameProperty() {
    return addPropertyNameInternal('fullName');
  }

  QueryBuilder<Node, String, QQueryOperations> fullPathProperty() {
    return addPropertyNameInternal('fullPath');
  }

  QueryBuilder<Node, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Node, bool, QQueryOperations> isDirectoryProperty() {
    return addPropertyNameInternal('isDirectory');
  }

  QueryBuilder<Node, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<Node, String, QQueryOperations> parentPathProperty() {
    return addPropertyNameInternal('parentPath');
  }

  QueryBuilder<Node, int, QQueryOperations> sizeProperty() {
    return addPropertyNameInternal('size');
  }
}
