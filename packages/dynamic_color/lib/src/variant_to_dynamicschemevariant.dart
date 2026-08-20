import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

extension VariantToDynamicSchemeVariant on Variant {
  /// Create a [DynamicSchemeVariant] from the given variant.
  DynamicSchemeVariant toDynamicSchemeVariant() {
    final DynamicSchemeVariant variant;
    switch (this) {
      case Variant.monochrome:
        variant = DynamicSchemeVariant.monochrome;
        break;
      case Variant.neutral:
        variant = DynamicSchemeVariant.neutral;
        break;
      case Variant.tonalSpot:
        variant = DynamicSchemeVariant.tonalSpot;
        break;
      case Variant.vibrant:
        variant = DynamicSchemeVariant.vibrant;
        break;
      case Variant.expressive:
        variant = DynamicSchemeVariant.expressive;
        break;
      case Variant.content:
        variant = DynamicSchemeVariant.content;
        break;
      case Variant.fidelity:
        variant = DynamicSchemeVariant.fidelity;
        break;
      case Variant.rainbow:
        variant = DynamicSchemeVariant.rainbow;
        break;
      case Variant.fruitSalad:
        variant = DynamicSchemeVariant.fruitSalad;
        break;
    }

    return variant;
  }
}

extension DynamicSchemeVariantToVariant on DynamicSchemeVariant {
  /// Create a [Variant] from the given dynamic scheme variant.
  Variant toVariant() {
    final Variant variant;
    switch (this) {
      case DynamicSchemeVariant.monochrome:
        variant = Variant.monochrome;
        break;
      case DynamicSchemeVariant.neutral:
        variant = Variant.neutral;
        break;
      case DynamicSchemeVariant.tonalSpot:
        variant = Variant.tonalSpot;
        break;
      case DynamicSchemeVariant.vibrant:
        variant = Variant.vibrant;
        break;
      case DynamicSchemeVariant.expressive:
        variant = Variant.expressive;
        break;
      case DynamicSchemeVariant.content:
        variant = Variant.content;
        break;
      case DynamicSchemeVariant.fidelity:
        variant = Variant.fidelity;
        break;
      case DynamicSchemeVariant.rainbow:
        variant = Variant.rainbow;
        break;
      case DynamicSchemeVariant.fruitSalad:
        variant = Variant.fruitSalad;
        break;
    }

    return variant;
  }
}
