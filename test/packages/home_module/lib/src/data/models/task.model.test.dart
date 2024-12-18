import 'package:flutter_test/flutter_test.dart';
import 'package:home_module/home_module.dart';

void main() {
  group('TaskModel', () {
    group('fromJson', () {
      test('Return correct TaskModel object with unique instance', () {
        //Arrange
        final json = {
          'name': 'prueba',
          'description': 'descripcion',
          'status': 'pending',
        };

        //Act
        final responseModel = TaskModel.fromJson(json);

        //Assert
        expect(
          responseModel,
          isA<TaskModel>()
              .having((w) => w.name, 'name', 'prueba')
              .having((w) => w.description, 'password', 'descripcion')
              .having((w) => w.status, 'status', TaskStatus.pending),
        );
      });
    });

    group('toJson', () {
      test('Return correct TaskModel json', () {
        expect(
          TaskModel(
            id: 'QWEASDQWEASD',
            name: 'prueba',
            description: 'descripcion',
            status: TaskStatus.pending,
          ).toJson(),
          {
            'id': 'QWEASDQWEASD',
            'name': 'prueba',
            'description': 'descripcion',
            'status': 'pending',
          },
        );
      });
    });
  });
}
