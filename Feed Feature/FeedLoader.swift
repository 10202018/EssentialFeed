//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jah Morris-Jones on 1/5/24.
//

import Foundation

enum LoadFeedResult {
  case success([FeedLoader])
  case error(Error)
}

protocol FeedLoader {
  func loadItem(completion: @escaping (LoadFeedResult) -> Void)
}
