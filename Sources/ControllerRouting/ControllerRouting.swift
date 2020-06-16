import Vapor
import Runtime

public extension Application {
    func useController<Controller>(_ controller: Controller) throws {
        for child in Mirror(reflecting: controller).children {
            guard let route = child.value as? RouteConvertible else {
                continue
            }
            route.route(self)
        }
    }
}
