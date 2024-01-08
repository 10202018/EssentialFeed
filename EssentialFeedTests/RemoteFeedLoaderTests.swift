//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jah Morris-Jones on 1/6/24.
//

import XCTest

class RemoteFeedLoader {
  func load() {
    // A common technique we see in testing to be able to mock Singletons is to
    // is to make the shared instance a variable
    // HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
  }
}

class HTTPClient {
  static var shared = HTTPClient()
  
  func get(from url: URL) {}
}

class HTTPClientSpy: HTTPClient {
  
  override func get(from url: URL) {
    requestedURL = url
  }
  var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let client = HTTPClientSpy()
    HTTPClient.shared = client
    _ = RemoteFeedLoader()
    
    XCTAssertNil(client.requestedURL)
  }
  
  func test_load_requestDataFromURL() {
    // Arrange: "Given a client and a sut..."
    let client = HTTPClientSpy()
    HTTPClient.shared = client
    let sut = RemoteFeedLoader()

    // Act: "When we invoke `sut.load()`..."
    sut.load()
    
    // Assert: "Assert that a URL request was initiated in the client"
    XCTAssertNotNil(client.requestedURL)
    
  }
}
