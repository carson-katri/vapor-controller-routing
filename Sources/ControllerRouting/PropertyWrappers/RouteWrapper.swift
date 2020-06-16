//
//  RouteWrapper.swift
//  
//
//  Created by Carson Katri on 6/15/20.
//

import Vapor

public protocol RouteWrapper: RouteConvertible {
    associatedtype Response: ResponseEncodable
    typealias EventHandler = (Request) throws -> Response
    var method: HTTPMethod { get }
    var closure: EventHandler { get }
    var path: [PathComponent] { get }

    var wrappedValue: EventHandler { get }
}

public protocol RouteConvertible {
    func route(_ app: Application)
}
