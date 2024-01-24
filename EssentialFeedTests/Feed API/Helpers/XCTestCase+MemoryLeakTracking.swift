//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Jah Morris-Jones on 1/24/24.
//

import Foundation
import XCTest

extension XCTestCase {
  func trackForMemoryLeaks(_ instance: AnyObject,  file: StaticString = #filePath, line: UInt = #line) {
    addTeardownBlock { [weak instance] in
      XCTAssertNil(instance, "Instance of system under test (sut) should have been deallocated. Potential memory leak.", file: file, line: line)
    }
  }
}
