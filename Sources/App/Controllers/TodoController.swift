import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    /// Returns a list of all `Todo`s.
    func allObjects(_ req: Request) throws -> Future<[Todo]> {
        return Todo.query(on: req).all()
    }
    
    func getById(_ req: Request, id: Int) throws -> Future<Todo> {
        return Todo.find(id, on: req).map(to: Todo.self) { (post) in
            guard let post = post else {throw Abort(HTTPStatus.notFound)}
            return post
        }
    }
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Todo> {
        return try req.content.decode(Todo.self).flatMap { todo in
            return todo.save(on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
}
