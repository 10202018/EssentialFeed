//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Jah Morris-Jones on 1/8/24.
//

import Foundation

public enum HTTPClientResult {
  case success(Data, HTTPURLResponse)
  case failure(Error)
}

public protocol HTTPClient {
  func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteFeedLoader {
  private let url: URL
  private let client: HTTPClient
  
  public enum Error: Swift.Error {
    case connectivity
    case invalidData
  }
  
  public enum Result: Equatable {
    case success([FeedItem])
    case failure(Error)
  }
  
  public init(client: HTTPClient, url: URL) {
    self.client = client
    self.url = url
  }
  
  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case let .success(data, response):
        do {
          let items = try FeedItemsMapper.map(data: data, response: response)
          completion(.success(items))
        } catch {
          completion(.failure(.invalidData))
        }
      case .failure:
        completion(.failure(.connectivity))
      }
    }
  }
}

private class FeedItemsMapper {
  private struct Root: Decodable {
    let items: [Item]
  }

  private struct Item: Decodable {
    var id: UUID
    var description: String?
    var location: String?
    var image: URL
    
    var item: FeedItem {
      return FeedItem(id: id, description: description, location: location, imageURL: image)
    }
  }
  
  static func map(data: Data, response: HTTPURLResponse) throws -> [FeedItem] {
    guard response.statusCode == 200 else {
      throw RemoteFeedLoader.Error.invalidData
    }
    let root = try JSONDecoder().decode(Root.self, from: data)
    return root.items.map { $0.item }
  }
}

