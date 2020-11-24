//  Copyright © 2019 Pooja  . All rights reserved.

import Foundation

protocol NetworkPluginType {
    /// Called to process before sending the request
    func mutate(_ request: URLRequest, target: TargetDefinition) -> URLRequest

    /// Called before the request is sent over.
    func willSend(_ request: URLRequest, target: TargetDefinition)

    /// Called after receiving response.
    func didReceive(_ result: ServiceProviderResult, target: TargetDefinition)

    /// Called to modify a result before sending it to caller.
    func willFinish(_ result: ServiceProviderResult, target: TargetDefinition) -> ServiceProviderResult
}
extension NetworkPluginType {
    func mutate(_ request: URLRequest, target: TargetDefinition) -> URLRequest { return request }

    func willSend(_ request: URLRequest, target: TargetDefinition) {}

    func didReceive(_ result: ServiceProviderResult, target: TargetDefinition) {}

    func willFinish(_ result: ServiceProviderResult, target: TargetDefinition) -> ServiceProviderResult { return result }
}
