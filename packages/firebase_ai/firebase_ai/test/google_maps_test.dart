// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_ai/src/tool.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GoogleMaps', () {
    test('constructor creates GoogleMaps correctly', () {
      final googleMaps = GoogleMaps();
      expect(googleMaps, isA<GoogleMaps>());
    });

    test('toJson returns empty object', () {
      final googleMaps = GoogleMaps();
      expect(googleMaps.toJson(), {});
    });
  });

  group('Tool.googleMaps', () {
    test('creates Tool with Google Maps', () {
      final tool = Tool.googleMaps();
      expect(tool, isA<Tool>());
    });

    test('toJson includes googleMaps field', () {
      final tool = Tool.googleMaps();
      expect(tool.toJson(), {'googleMaps': {}});
    });

    test('can create with custom GoogleMaps instance', () {
      final googleMaps = GoogleMaps();
      final tool = Tool.googleMaps(googleMaps: googleMaps);
      expect(tool.toJson(), {'googleMaps': {}});
    });
  });

  group('LatLng', () {
    test('constructor creates LatLng correctly', () {
      final latLng = LatLng(latitude: 37.7749, longitude: -122.4194);
      expect(latLng.latitude, 37.7749);
      expect(latLng.longitude, -122.4194);
    });

    test('toJson serializes correctly', () {
      final latLng = LatLng(latitude: 37.7749, longitude: -122.4194);
      expect(latLng.toJson(), {
        'latitude': 37.7749,
        'longitude': -122.4194,
      });
    });
  });

  group('RetrievalConfig', () {
    test('constructor creates RetrievalConfig correctly', () {
      final latLng = LatLng(latitude: 37.7749, longitude: -122.4194);
      final config = RetrievalConfig(latLng: latLng);
      expect(config.latLng, same(latLng));
    });

    test('toJson serializes correctly', () {
      final latLng = LatLng(latitude: 37.7749, longitude: -122.4194);
      final config = RetrievalConfig(latLng: latLng);
      expect(config.toJson(), {
        'latLng': {
          'latitude': 37.7749,
          'longitude': -122.4194,
        },
      });
    });
  });

  group('ToolConfig with retrievalConfig', () {
    test('toJson includes retrievalConfig when provided', () {
      final latLng = LatLng(latitude: 37.7749, longitude: -122.4194);
      final retrievalConfig = RetrievalConfig(latLng: latLng);
      final toolConfig = ToolConfig(retrievalConfig: retrievalConfig);
      
      expect(toolConfig.toJson(), {
        'retrievalConfig': {
          'latLng': {
            'latitude': 37.7749,
            'longitude': -122.4194,
          },
        },
      });
    });

    test('toJson excludes retrievalConfig when null', () {
      final toolConfig = ToolConfig();
      expect(toolConfig.toJson(), {});
    });

    test('toJson includes both functionCallingConfig and retrievalConfig', () {
      final latLng = LatLng(latitude: 37.7749, longitude: -122.4194);
      final retrievalConfig = RetrievalConfig(latLng: latLng);
      final functionConfig = FunctionCallingConfig.auto();
      final toolConfig = ToolConfig(
        functionCallingConfig: functionConfig,
        retrievalConfig: retrievalConfig,
      );
      
      final json = toolConfig.toJson();
      expect(json, containsPair('functionCallingConfig', anything));
      expect(json, containsPair('retrievalConfig', anything));
    });
  });

  group('MapsGroundingChunk', () {
    test('constructor creates MapsGroundingChunk correctly', () {
      final mapsChunk = MapsGroundingChunk(
        uri: 'https://maps.google.com/?cid=123',
        title: 'Test Place',
        text: 'Test description',
        placeId: 'places/ChIJTest',
      );
      
      expect(mapsChunk.uri, 'https://maps.google.com/?cid=123');
      expect(mapsChunk.title, 'Test Place');
      expect(mapsChunk.text, 'Test description');
      expect(mapsChunk.placeId, 'places/ChIJTest');
    });

    test('constructor with null values', () {
      final mapsChunk = MapsGroundingChunk();
      expect(mapsChunk.uri, isNull);
      expect(mapsChunk.title, isNull);
      expect(mapsChunk.text, isNull);
      expect(mapsChunk.placeId, isNull);
    });
  });

  group('GroundingChunk with maps support', () {
    test('constructor creates GroundingChunk with maps field', () {
      final mapsChunk = MapsGroundingChunk(
        uri: 'https://maps.google.com/?cid=123',
        title: 'Test Place',
      );
      final groundingChunk = GroundingChunk(maps: mapsChunk);
      
      expect(groundingChunk.maps, same(mapsChunk));
      expect(groundingChunk.web, isNull);
    });

    test('constructor creates GroundingChunk with both maps and web null', () {
      final groundingChunk = GroundingChunk();
      
      expect(groundingChunk.maps, isNull);
      expect(groundingChunk.web, isNull);
    });
  });

  group('GroundingMetadata with googleMapsWidgetContextToken', () {
    test('constructor creates GroundingMetadata with googleMapsWidgetContextToken', () {
      final metadata = GroundingMetadata(
        groundingChunks: [],
        groundingSupport: [],
        webSearchQueries: [],
        googleMapsWidgetContextToken: 'widget-token-123',
      );
      
      expect(metadata.googleMapsWidgetContextToken, 'widget-token-123');
    });

    test('constructor without googleMapsWidgetContextToken', () {
      final metadata = GroundingMetadata(
        groundingChunks: [],
        groundingSupport: [],
        webSearchQueries: [],
      );
      
      expect(metadata.googleMapsWidgetContextToken, isNull);
    });
  });
}
