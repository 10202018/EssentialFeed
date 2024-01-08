//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jah Morris-Jones on 1/6/24.
//

import XCTest

class RemoteFeedLoader {
  let client: HTTPClient
  let url: URL
  
  init(client: HTTPClient, url: URL) {
    self.client = client
    self.url = url
  }
  func load() {
    client.get(from: url)
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
    let url = URL(string: "https://a-url.com")!
    let client = HTTPClientSpy()
    _ = RemoteFeedLoader(client: client, url: url)
    
    XCTAssertNil(client.requestedURL)
  }
  
  func test_load_requestDataFromURL() {
    // Arrange: "Given a client and a sut..."
    let url = URL(string: "https://a-given-url.com")!
    let client = HTTPClientSpy()
    let sut = RemoteFeedLoader(client: client, url: url)

    // Act: "When we invoke `sut.load()`..."
    sut.load()
    
    // Assert: "Assert that a URL request was initiated in the client"
    
    XCTAssertEqual(client.requestedURL, url)
    
  }
}
