import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    router.get("f"){ req in
        return "Fuck"
    }
    
    router.get("todos","id", Int.parameter) { req -> EventLoopFuture<Todo> in
        let id = try req.parameters.next(Int.self)
        let todoController = TodoController()
        return try todoController.getById(req, id: id)
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.allObjects)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)


}
