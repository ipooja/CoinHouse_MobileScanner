//
//  AddressDataCall.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import Foundation

protocol AddressDataCallRepo {
    var apiEndPoint: String {get set}
    func getHomeTypeScreenData(completion: @escaping (APIServicResult<AddressModel>?, ServiceProviderError?) -> Void) -> ServiceCancellable?
}

struct AddressApiCallRepo: AddressDataCallRepo {
    var apiEndPoint: String = ""
    func getHomeTypeScreenData(completion: @escaping (APIServicResult<AddressModel>?, ServiceProviderError?) -> Void) -> ServiceCancellable? {
        var apiParams = APIParams()
        apiParams["action"] = "txlist"
        apiParams["address"] = "0xf7eB7637DeD2696B152c7D5EDEe502902B0F1c91"
        apiParams["startblock"] = "0"
        apiParams["endblock"] = "99999999"
        apiParams["page"] = "1"
        apiParams["offset"] = "10"
        apiParams["sort"] = "asc"
        apiParams["apikey"] = "83ZMR3VFQUB31HVPIYAUVA1ZUW76HH6EBP"
        apiParams["module"] = "account"
        
        let target = ServiceRequestDetail.init(endpoint: .homeScreenData(param: apiParams, endUrlString: apiEndPoint))
        return APIService().request(target) { (response: APIResult<APIServicResult<AddressModel>, ServiceProviderError>) in
            completion(response.value, response.error)
        }
    }
}
