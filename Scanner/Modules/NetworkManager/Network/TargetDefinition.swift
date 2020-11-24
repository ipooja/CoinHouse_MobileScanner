//  Copyright © 2019 Pooja  . All rights reserved.

protocol TargetDefinition: AccessAuthorizable {
    var httpMethod: HTTPMethod {get}
    var baseUrl: String {get}
    var path: String {get}
    var headers: [AnyHashable: Any]? {get}
    var parameters: [AnyHashable: Any]? {get}
    var postQueryParameters: [AnyHashable: Any]? {get}
}
