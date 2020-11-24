//  Copyright © 2019 Pooja  . All rights reserved.

protocol RequiresAccessAuthorization {
    // Empty protocol conformance
}

protocol AccessAuthorizationNotRequired {
    // Empty protocol conformance
}

extension TargetDefinition where Self: RequiresAccessAuthorization {
    var authorizationType: TypeOfAuthorization { return .bearer }
}

extension TargetDefinition where Self: AccessAuthorizationNotRequired {
    var authorizationType: TypeOfAuthorization { return .none }
}
