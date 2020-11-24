//
//  ApiDetail.swift
//  BingeAnywhere
//
//  Created by Pooja on 05/11/19.
//  Copyright © 2019 ttn. All rights reserved.
//

import Foundation

typealias APIParams = [AnyHashable: Any]
typealias APIHeaders = [AnyHashable: Any]

struct APIDetail {
    
    var path = ""
    var parameter: APIParams = APIParams()
    var method: HTTPMethod = .GET
    var baseUrl = APIEnvironment.qa.rawValue
    var isBaseUrlNeedToAppend: Bool = true
    var showLoader: Bool = true
    var showAlert: Bool = true
    var showMessageOnSuccess = false
    var isHeaderTokenRequired: Bool = true
    var supportOffline = false
    var postQueryParam: APIParams?
    
    init(endpoint: ServiceRequestEndPoint) {
        switch endpoint {
        case .homeScreenData(let param, _):
            path = APIPath.homeScreenData.rawValue
            parameter = param
            method = .GET
            isHeaderTokenRequired = true
            showAlert = false
        }
    }
}
