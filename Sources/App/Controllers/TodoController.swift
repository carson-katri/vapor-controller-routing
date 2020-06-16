//
//  TodoController.swift
//  
//
//  Created by Carson Katri on 6/15/20.
//

import Vapor
import ControllerRouting

struct TodoController {
    @Get("todos")
    var index = { req throws -> EventLoopFuture<[Todo]> in
        Todo.query(on: req.db).all()
    }
    
    @Post("todos")
    var create = { (req: Request, todo: Todo) throws -> EventLoopFuture<Todo> in
        todo.save(on: req.db).map { todo }
    }

    @On(.DELETE, "delete", ":todoID")
    var delete = { (req: Request) throws -> EventLoopFuture<HTTPStatus> in
        Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
