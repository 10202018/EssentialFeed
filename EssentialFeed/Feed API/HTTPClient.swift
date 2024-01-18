//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Jah Morris-Jones on 1/18/24.
//

import Foundation


public enum HTTPClientResult {
  case success(Data, HTTPURLResponse)
  case failure(Error)
}

public protocol HTTPClient {
  func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
