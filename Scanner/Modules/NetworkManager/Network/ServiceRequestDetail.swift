//
//  ServiceRequestDetail.swift
//  BingeAnywhere
//
//  Created by Pooja on 16/12/19.
//  Copyright © 2019 ttn. All rights reserved.
//

import Foundation

struct ServiceRequestDetail: TargetDefinition, AccessAuthorizationNotRequired {

    var endpoint: ServiceRequestEndPoint
    var detail: APIDetail

    init(endpoint: ServiceRequestEndPoint) {
        self.endpoint = endpoint
        self.detail = APIDetail.init(endpoint: endpoint)
    }

    var authType: TypeOfAuthorization {
        return .none
    }

    var httpMethod: HTTPMethod {
        return detail.method
    }

    var baseUrl: String {
        return detail.baseUrl
    }

    var path: String {
        return detail.path
    }

    var headers: [AnyHashable: Any]? {
        return nil
    }

    var parameters: [AnyHashable: Any]? {
        return detail.parameter
    }

    var postQueryParameters: [AnyHashable: Any]? {
        return detail.postQueryParam
    }

}
