//
//  APIService.swift
//  APIStruct
//
//  Created by Pooja   on 18/08/19.
//  Copyright © 2019 Pooja  . All rights reserved.
//

import UIKit

class APIService: APIServicable {

    @discardableResult
    func request<T: Decodable>(_ apiDefinition: TargetDefinition, completion: @escaping (APIResult<APIServicResult<T>, ServiceProviderError>) -> Void) -> ServiceCancellable? {
        let plugins = [AuthorizationPlugin(tokenProvider: AuthorizationTokenProvider())]
        let networkExecutor = NetworkExecutor()
        let serviceProvider = ServiceProvider(networkExecutor, plugins: plugins)
        let requestToken = serviceProvider.request(apiDefinition) { result in
            switch result {
            case .success(let response):
                let serviceProviderResponse = response
                do {
                    let parsed = try JSONDecoder().decode(T.self, from: response.data!)
                    let apiServiceResult = APIServicResult(parsed: parsed, serviceResponse: serviceProviderResponse)
                    DispatchQueue.main.async {
                        completion(APIResult.success(apiServiceResult))
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(APIResult.error(ServiceProviderError(statusCode: -1, error: error)))
                    }
                }
            case .error(let error):
                DispatchQueue.main.async {
                    completion(APIResult.error(error))
                }
            }
        }
        return requestToken
    }

}
