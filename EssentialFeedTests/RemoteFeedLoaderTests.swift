//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jah Morris-Jones on 1/6/24.
//

import XCTest

class RemoteFeedLoader {
  func load() {
    HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
  }
}

class HTTPClient {
  static let shared = HTTPClient()
  private init() {}
  var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let client = HTTPClient.shared
    _ = RemoteFeedLoader()
    
    XCTAssertNil(client.requestedURL)
  }
  
  func test_load_requestDataFromURL() {
    // Arrange: "Given a client and a sut..."
    let client = HTTPClient.shared
    let sut = RemoteFeedLoader()

    // Act: "When we invoke `sut.load()`..."
    sut.load()
    
    // Assert: "Assert that a URL request was initiated in the client"
    XCTAssertNotNil(client.requestedURL)
    
  }
}
