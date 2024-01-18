//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Jah Morris-Jones on 1/18/24.
//

import Foundation

internal final class FeedItemsMapper {
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
  
  private static var OK_200: Int { return 200 }
  
  internal static func map(data: Data, response: HTTPURLResponse) throws -> [FeedItem] {
    guard response.statusCode == OK_200 else {
      throw RemoteFeedLoader.Error.invalidData
    }
    let root = try JSONDecoder().decode(Root.self, from: data)
    return root.items.map { $0.item }
  }
}
