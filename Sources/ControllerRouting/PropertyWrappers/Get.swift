//
//  Server.swift
//  
//
//  Created by Carson Katri on 6/15/20.
//

import Vapor

@propertyWrapper
public struct Get<Response: ResponseEncodable>: RouteWrapper {
    public let method: HTTPMethod = .GET
    public typealias EventHandler = (Request) throws -> Response
    
    public let closure: EventHandler
    public let path: [PathComponent]

    public init(wrappedValue value: @escaping EventHandler, _ path: PathComponent...) {
        self.closure = value
        self.path = path
    }
    
    public var wrappedValue: EventHandler {
        get { closure }
    }
    
    public func route(_ app: Application) {
        app.get(path, use: closure)
    }
}
