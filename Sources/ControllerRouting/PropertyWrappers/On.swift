//
//  On.swift
//
//
//  Created by Carson Katri on 6/15/20.
//

import Vapor

@propertyWrapper
public struct On<Response: ResponseEncodable>: RouteWrapper {
    public let method: HTTPMethod
    public typealias EventHandler = (Request) throws -> Response
    
    public let closure: EventHandler
    public let path: [PathComponent]

    public init(wrappedValue value: @escaping EventHandler, _ method: HTTPMethod, _ path: PathComponent...) {
        self.closure = value
        self.method = method
        self.path = path
    }
    
    public var wrappedValue: EventHandler {
        get { closure }
    }
    
    public func route(_ app: Application) {
        app.on(method, path, use: closure)
    }
}
