import Vapor
import Runtime

public extension RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        var routeWrappers = [RouteConvertible]()
        var info: ControllerInfo.Info = .init(group: nil)
        for child in Mirror(reflecting: self).children {
            if let controllerInfo = child.value as? ControllerInfo {
                info = controllerInfo.info
            } else if let route = child.value as? RouteConvertible {
                routeWrappers.append(route)
            }
        }
        
        let builder = info.group != nil ? routes.grouped(info.group!) : routes
        for route in routeWrappers {
            route.route(builder)
        }
    }
}
