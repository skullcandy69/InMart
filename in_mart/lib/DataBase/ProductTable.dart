import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';

part 'ProductTable.g.dart';

class ProductDb extends Table {
  // IntColumn get id => integer().autoIncrement()();
  IntColumn get productid => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get link => text().nullable()();
  TextColumn get company => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get productType => text().nullable()();
  IntColumn get price => integer().nullable()();
  @override
  Set<Column> get primaryKey => {productid};
  // BoolColumn get completed => boolean().withDefault(Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [ProductDb])
class ProductsDb extends _$ProductsDb {
  ProductsDb() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<List<ProductDbData>> watchAllTasks() => select(productDb).get();
  Stream<List<ProductDbData>> getAllFav() => select(productDb).watch();
  Future insertProduct(ProductDbData products) =>
      into(productDb).insert(products);
  Future deleteProduct(ProductDbData products) =>
      delete(productDb).delete(products);

  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //   onUpgrade: (Migrator m, int from, int to) async {
  //     if (from == 1) {
  //       await m.addColumn(tokens, tokens.shift);
  //     }
  //   }
  // );

  // Future<List<Token>> getAllTasks(DateTime time, int id) {
  //   final query = select(tokens)
  //     ..where((t) => t.tokentime.day.equals(time.day))
  //     ..where((t) => t.doctorid.equals(id))
  //     ..where((t) => t.booked.equals(false));
  //   return query.get();
  // }

  // Stream<List<Token>> watchAllTasks(String q) {
  //   dynamic query;
  //   if (q.isNotEmpty) {
  //     query = select(tokens)
  //       ..where((t) => t.name.contains(q) | t.address.contains(q))
  //       ..where((t) => (t.booked.equals(true) |
  //           t.cancelled.equals(true) &
  //               t.tokentime.isBiggerOrEqualValue(DateTime.now())));
  //   } else {
  //     query = select(tokens)
  //       ..where((t) => t.booked.equals(true) | t.cancelled.equals(true));
  //   }
  //   return query.watch();
  // }

  // Future<int> allBooked() async {
  //   final query = select(tokens)..where((t) => t.booked.equals(true));
  //   print(await query.watch().length);
  //   return query.watch().length;
  // }

  // Future<int> frontDesk() {
  //   final query = select(tokens)
  //     ..where((t) => t.booked.equals(true))
  //     ..where((p) => p.bookedtype.equals('walk in'));
  //   return query.watch().length;
  // }

  // Stream<List<Token>> watchondate(DateTime time, int id) {
  //   final query = select(tokens)
  //     ..where((t) => t.tokentime.day.equals(time.day))
  //     ..where((t) => t.doctorid.equals(id))
  //     ..where((t) => t.booked.equals(false))
  //     ..where((t) => t.cancelled.equals(false));
  //   return query.watch();
  // }

  // Future insertTask(Token token) => into(tokens).insert(token);
  // Future updateTask(Token token) => update(tokens).replace(token);
  // Future updateData(Token token, String name) {
  //   print(name);
  //   var query = update(tokens)..where((t) => t.id.equals(token.id));
  //   return query.write(TokensCompanion(
  //       guid: Value(token.guid),
  //       gender: Value(token.gender),
  //       booked: Value(token.booked),
  //       cancelled: Value(token.cancelled),
  //       name: Value(token.name),
  //       address: Value(token.address),
  //       age: Value(token.age),
  //       fees: Value(token.fees),
  //       appointmenttype: Value(token.appointmenttype),
  //       visittype: Value(token.visittype),
  //       bookedtype: Value(token.bookedtype),
  //       mobileno: Value(token.mobileno)));
  //   }

  // Future updateOnline(Token token) {
  //   var query = update(tokens)
  //     ..where((t) =>
  //         t.tokentime.equals(token.tokentime) &
  //         t.doctorid.equals(token.doctorid));
  //   return query.write(TokensCompanion(
  //       guid: Value(token.guid),
  //       updatedAt: Value(DateTime.now()),
  //       booked: Value(token.booked),
  //       cancelled: Value(token.cancelled),
  //       name: Value(token.name),
  //       address: Value(token.address),
  //       age: Value(token.age),
  //       fees: Value(token.fees),
  //       appointmenttype: Value(token.appointmenttype),
  //       visittype: Value(token.visittype),
  //       bookedtype: Value(token.bookedtype),
  //       mobileno: Value(token.mobileno)));
  // }

  // Future<int> getcount() async {
  //   final query = (await select(tokens).get()).where((t) => t.booked == true);
  //   return query.length;
  // }

  // Future<int> getcountoncall() async {
  //   final query = (await select(tokens).get())
  //       .where((t) => t.bookedtype == "on call")
  //       .where((t) => t.booked == true);
  //   return query.length;
  // }

  // Future<int> getcountonfront() async {
  //   final query = (await select(tokens).get())
  //       .where((t) => t.bookedtype == "walk in")
  //       .where((t) => t.booked == true);
  //   return query.length;
  // }

  // Future<int> getcountOnline() async {
  //   final query = (await select(tokens).get())
  //       .where((t) => t.isOnline == true)
  //       .where((t) => t.booked == true);
  //   return query.length;
  // }

  // Future<int> getcountPresent() async {
  //   final query = (await select(tokens).get()).where((t) => t.booked == true);
  //   return query.length;
  // }

  // Future deleteallbydate(DateTime time) =>
  //     (delete(tokens)..where((t) => t.tokentime.isSmallerThanValue(time))).go();
  // Future deleteallTask() => delete(tokens).go();
}
