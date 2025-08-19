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
  group('UrlContext', () {
    test('constructor creates UrlContext correctly', () {
      final urlContext = UrlContext();
      expect(urlContext, isA<UrlContext>());
    });

    test('toJson returns empty object', () {
      final urlContext = UrlContext();
      expect(urlContext.toJson(), {});
    });
  });

  group('Tool.urlContext', () {
    test('creates Tool with URL context', () {
      final tool = Tool.urlContext();
      expect(tool, isA<Tool>());
    });

    test('toJson includes urlContext field', () {
      final tool = Tool.urlContext();
      expect(tool.toJson(), {'urlContext': {}});
    });

    test('can create with custom UrlContext instance', () {
      final urlContext = UrlContext();
      final tool = Tool.urlContext(urlContext: urlContext);
      expect(tool.toJson(), {'urlContext': {}});
    });
  });

  group('UrlContextMetadata', () {
    test('constructor creates UrlContextMetadata correctly', () {
      final metadata = UrlContextMetadata(urlMetadata: []);
      expect(metadata.urlMetadata, isEmpty);
    });

    test('constructor with URL metadata list', () {
      final urlMeta = UrlMetadata(
        retrievedUrl: 'https://example.com',
        urlRetrievalStatus: UrlRetrievalStatus.success,
      );
      final metadata = UrlContextMetadata(urlMetadata: [urlMeta]);
      expect(metadata.urlMetadata, hasLength(1));
      expect(metadata.urlMetadata.first.retrievedUrl, 'https://example.com');
    });
  });

  group('UrlMetadata', () {
    test('constructor creates UrlMetadata correctly', () {
      final urlMeta = UrlMetadata(
        retrievedUrl: 'https://example.com',
        urlRetrievalStatus: UrlRetrievalStatus.success,
      );
      expect(urlMeta.retrievedUrl, 'https://example.com');
      expect(urlMeta.urlRetrievalStatus, UrlRetrievalStatus.success);
    });
  });

  group('UrlRetrievalStatus', () {
    test('enum values have correct string representation', () {
      expect(UrlRetrievalStatus.success.toString(), 'success');
      expect(UrlRetrievalStatus.failure.toString(), 'failure');
      expect(UrlRetrievalStatus.unsafe.toString(), 'unsafe');
      expect(UrlRetrievalStatus.unknown.toString(), 'unknown');
    });

    test('enum values serialize to correct JSON strings', () {
      expect(UrlRetrievalStatus.success.toJson(), 'URL_RETRIEVAL_STATUS_SUCCESS');
      expect(UrlRetrievalStatus.failure.toJson(), 'URL_RETRIEVAL_STATUS_FAILURE');
      expect(UrlRetrievalStatus.unsafe.toJson(), 'URL_RETRIEVAL_STATUS_UNSAFE');
      expect(UrlRetrievalStatus.unknown.toJson(), 'URL_RETRIEVAL_STATUS_UNSPECIFIED');
    });
  });
}
