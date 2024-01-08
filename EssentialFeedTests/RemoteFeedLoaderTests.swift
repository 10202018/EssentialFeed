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
  var requestedURL: URL? { get }
  func get(from url: URL)
}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let (_, client) = makeSUT()
    
    XCTAssertNil(client.requestedURL)
  }
  
  func test_load_requestDataFromURL() {
    // Arrange: "Given a client and a sut..."
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)

    // Act: "When we invoke `sut.load()`..."
    sut.load()
    
    // Assert: "Assert that a URL request was initiated in the client"
    XCTAssertEqual(client.requestedURL, url)
  }
  
// MARK: - Helpers

  private class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
      requestedURL = url
    }
  }
  
  private func makeSUT(url: URL = URL(string: "https://a-url.com")!)
  -> (sut: RemoteFeedLoader, client: HTTPClient) {
    let client = HTTPClientSpy()
    let remoteFeedLoader = RemoteFeedLoader(client: client, url: url)
    return (remoteFeedLoader, client)
  }
}
