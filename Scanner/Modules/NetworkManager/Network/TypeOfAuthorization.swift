//  Copyright © 2019 Pooja  . All rights reserved.

public enum TypeOfAuthorization {
    case none
    case basic
    case bearer
    case custom(String)

    var value: String? {
        switch self {
        case .none: return nil
        case .basic: return "Basic"
        case .bearer: return "Bearer"
        case .custom(let customValue): return customValue
        }
    }
}
