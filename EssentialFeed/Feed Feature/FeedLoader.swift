//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jah Morris-Jones on 1/5/24.
//

import Foundation

public enum LoadFeedResult{
  case success([FeedItem])
  case failure(Error)
}

protocol FeedLoader {
  associatedtype Error: Swift.Error
  
  func load(completion: @escaping (LoadFeedResult) -> Void)
}
