import 'package:vania/vania.dart';

class CreateWisatasTable extends Migration {

  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('wisatas', () {
      id();
      string('name', length: 100);
      text('description');
      string('location', length: 200);
      string('photo_url', length: 255, nullable: true);
      dateTime('created_at', nullable: true);
      dateTime('updated_at', nullable: true);
      dateTime('deleted_at', nullable: true);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('wisatas');
  }
}
