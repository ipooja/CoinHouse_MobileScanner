//  Copyright © 2019 Pooja  . All rights reserved.
//

import Foundation

struct ServiceProviderResponse {
    let request: URLRequest
    let statusCode: Int
    let response: HTTPURLResponse
    let data: Data?
}

struct ServiceProviderError {
    let statusCode: Int
    let error: Error
}

typealias ServiceProviderResult = APIResult<ServiceProviderResponse, ServiceProviderError>
typealias ServiceProviderTypeCompletion = (_ completion: ServiceProviderResult) -> Void

protocol ServiceProviderType {
    var plugins: [NetworkPluginType] {get}
    func request(_ target: TargetDefinition, completion: @escaping ServiceProviderTypeCompletion) -> ServiceCancellable?
}
