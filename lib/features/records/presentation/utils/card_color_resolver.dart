import 'package:diyabetansiyon/core/utils/stage_color_resolver.dart';
import 'package:diyabetansiyon/features/measurement/domain/entities/measurement.dart';
import 'package:flutter/material.dart';

class CardColorResolver {
  static Color resolve(Measurement measurement, int age, {String gender = 'male'}) {
    return StageColorResolver.fromMeasurement(measurement, age, gender: gender);
  }
}
