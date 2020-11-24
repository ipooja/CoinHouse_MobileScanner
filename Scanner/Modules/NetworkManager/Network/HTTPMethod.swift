//  Copyright © 2019 Pooja  . All rights reserved.

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    var methodName: String { return rawValue.uppercased() }
}

public enum ParamEncoding: String {
    case temp
}
