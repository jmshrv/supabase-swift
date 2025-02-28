//
//  InMemoryLocalStorage.swift
//  Supabase
//
//  Created by James Harvey on 28/02/2025.
//


import Foundation
import ConcurrencyExtras

/// A thread-safe in-memory implementation of AuthLocalStorage that doesn't persist data
public final class InMemoryLocalStorage: AuthLocalStorage, @unchecked Sendable {
  private let _storage = LockIsolated([String: Data]())
  
  public init() {}
  
  public func store(key: String, value: Data) throws {
    _storage.withValue {
      $0[key] = value
    }
  }
  
  public func retrieve(key: String) throws -> Data? {
    _storage.value[key]
  }
  
  public func remove(key: String) throws {
    _storage.withValue {
      $0[key] = nil
    }
  }
}