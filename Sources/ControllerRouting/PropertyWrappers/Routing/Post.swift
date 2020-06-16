//
//  Post.swift
//
//
//  Created by Carson Katri on 6/15/20.
//

import Vapor

@propertyWrapper
public struct Post<Response: ResponseEncodable>: RouteWrapper {
    public let method: HTTPMethod = .POST
    public typealias EventHandler = (Request) throws -> Response
    
    public let closure: EventHandler
    public let path: [PathComponent]

    public init(wrappedValue value: @escaping EventHandler, _ path: PathComponent...) {
        self.closure = value
        self.path = path
    }
    
    public init<Body>(wrappedValue value: @escaping (Request, Body) throws -> Response, _ path: PathComponent...) where Body: Decodable {
        self.closure = { req in
            return try value(req, try req.content.decode(Body.self))
        }
        self.path = path
    }
    
    public var wrappedValue: EventHandler {
        get { closure }
    }
}
