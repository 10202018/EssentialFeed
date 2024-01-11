//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Jah Morris-Jones on 1/6/24.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let (_, client) = makeSUT()
    
    XCTAssertTrue(client.requestedURLs.isEmpty)
  }
  
  func test_load_requestsDataFromURL() {
    // Arrange: "Given a client and a sut..."
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)

    // Act: "When we invoke `sut.load()`..."
    sut.load() { _ in }
    
    // Assert: "Assert that a URL request was initiated in the client"
    XCTAssertEqual(client.requestedURLs, [url])
  }
  
  func test_loadTwice_requestsDataFromURLTwice() {
    // Arrange: "Given a client and a sut..."
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)

    // Act: "When we invoke `sut.load()`..."
    sut.load() { _ in }
    sut.load() { _ in }
    
    // Assert: "Assert that a URL request was initiated in the client"
    XCTAssertEqual(client.requestedURLs, [url, url])
  }
  
  func test_load_deliversErrorOnClientError() {
    let (sut, client) = makeSUT()
    
    var capturedError = [RemoteFeedLoader.Error?]()
    sut.load() { capturedError.append($0) }
    
    let clientError = NSError(domain: "Test", code: 0)
    client.complete(with: clientError)
    
    XCTAssertEqual(capturedError, [.connectivity])
  }
  
// MARK: - Helpers

  private class HTTPClientSpy: HTTPClient {
    private var messages = [(url: URL, completion: (Error) -> Void)]()
    
    var requestedURLs: [URL] {
      return messages.map { $0.url }
    }
    
    func get(from url: URL, completion: @escaping (Error) -> Void) {
      messages.append((url, completion))
    }
    
    func complete(with error: Error, at index: Int = 0) {
      messages[index].completion(error)
    }
  }
  
  private func makeSUT(url: URL = URL(string: "https://a-url.com")!)
  -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let remoteFeedLoader = RemoteFeedLoader(client: client, url: url)
    return (remoteFeedLoader, client)
  }
}
