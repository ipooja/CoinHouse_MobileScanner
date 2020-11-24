//  Copyright © 2019 Pooja  . All rights reserved.

struct APIServicResult<Parsed: ServiceResponseRepresentable> {
    let parsed: Parsed
    let serviceResponse: ServiceProviderResponse
}

typealias APIServiceCompletion<Parsed: ServiceResponseRepresentable> = (_ apiResult: APIResult<APIServicResult<Parsed>, ServiceProviderError>) -> Void

protocol APIServicable {
    func request<T: ServiceResponseRepresentable>(_ apiDefinition: TargetDefinition, completion: @escaping APIServiceCompletion<T>) -> ServiceCancellable?
}
