//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jah Morris-Jones on 1/6/24.
//

import XCTest

class RemoteFeedLoader {
  let client: HTTPClient
  
  init(client: HTTPClient) {
    self.client = client
  }
  func load() {
    // A common technique we see in testing to be able to mock Singletons is to
    // is to make the shared instance a variable
    // HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    client.get(from: URL(string: "https://a-url.com")!)
  }
}

protocol HTTPClient {
  func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
  var requestedURL: URL?
  
  func get(from url: URL) {
    requestedURL = url
  }
}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let client = HTTPClientSpy()
    _ = RemoteFeedLoader(client: client)
    
    XCTAssertNil(client.requestedURL)
  }
  
  func test_load_requestDataFromURL() {
    // Arrange: "Given a client and a sut..."
    let client = HTTPClientSpy()
    let sut = RemoteFeedLoader(client: client)

    // Act: "When we invoke `sut.load()`..."
    sut.load()
    
    // Assert: "Assert that a URL request was initiated in the client"
    XCTAssertNotNil(client.requestedURL)
    
  }
}
