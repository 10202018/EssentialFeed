//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Jah Morris-Jones on 1/5/24.
//

import Foundation

public struct FeedItem: Equatable {
  let id: UUID
  let description: String?
  let location: String?
  let image: URL
}
