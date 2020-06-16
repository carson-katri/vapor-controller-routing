# Vapor ControllerRouting

Using Vapor 4 controllers:

```swift
// TodoController.swift
struct TodoController {
    func index(req: Request) throws -> EventLoopFuture<[Todo]> {
        Todo.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<Todo> {
        let todo = try req.content.decode(Todo.self)
        todo.save(on: req.db).map { todo }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}

// routes.swift
let todoController = TodoController()
app.get("todos", use: todoController.index)
app.post("todos", use: todoController.create)
app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
```

Using ControllerRouting:

```swift
// TodoController.swift
struct TodoController {
    @Get("todos")
    var index = { req throws -> EventLoopFuture<[Todo]> in
        Todo.query(on: req.db).all()
    }
    
    @Post("todos")
    var create = { (req: Request, todo: Todo) throws -> EventLoopFuture<Todo> in // <- Implicit body decoding
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

// routes.swift
try app.useController(TodoController())
```
