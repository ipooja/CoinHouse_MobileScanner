//  Copyright © 2019 Pooja  . All rights reserved.

import UIKit

class ServiceProvider: ServiceProviderType {
    var plugins: [NetworkPluginType]
    private let serviceExcutable: ServiceRequestExecutable

    init(_ serviceExcutable: ServiceRequestExecutable, plugins: [NetworkPluginType]) {
        self.serviceExcutable = serviceExcutable
        self.plugins = plugins
    }

    @discardableResult
    func request(_ target: TargetDefinition, completion: @escaping ServiceProviderTypeCompletion) -> ServiceCancellable? {

        guard let urlRequest = URLRequest.makeURLRequest(target) else { return nil }
        let mutatedRequest = plugins.reduce(urlRequest) { $1.mutate(urlRequest, target: target) }

        self.plugins.forEach { $0.willSend(mutatedRequest, target: target) } //inform all plugins before sending the request
        let postPlugins = plugins
        let onRequestCompletion: ServiceRequestDataTaskCompletion = { (data, urlResponse, error) in
            var ourResult: ServiceProviderResult
            // Success
            if let data = data, let urlResponse = urlResponse {
                let providerResponse = ServiceProviderResponse(request: mutatedRequest, statusCode: urlResponse.statusCode, response: urlResponse, data: data)
                ourResult = .success(providerResponse)
            } else if let error = error, let urlResponse = urlResponse { // Errored
                ourResult = .error(ServiceProviderError(statusCode: urlResponse.statusCode, error: error))
            } else if let error = error { // Kind of error without an error urlresponse
                ourResult = .error(ServiceProviderError(statusCode: -1, error: error))
            } else { //Something unknown
                ourResult = .error(ServiceProviderError(statusCode: -1, error: NSError(domain: appDomain, code: -1, userInfo: nil)))
            }
            postPlugins.forEach { $0.didReceive(ourResult, target: target) }
            let mutatedResult = postPlugins.reduce(ourResult) { $1.willFinish($0, target: target) }
            completion(mutatedResult)
        }
        let serviceCancellable = serviceExcutable.excuteRequest(urlRequest, completion: onRequestCompletion)
        return serviceCancellable
    }
}

private extension URLRequest {
    static func makeURLRequest(_ target: TargetDefinition) -> URLRequest? {
        guard var url = URL(string: target.baseUrl) else { return nil }
        url.appendPathComponent(target.path)
        var ourRequest = URLRequest(url: url)
        switch target.httpMethod {
        case .GET:
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return nil
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "%3F", with: "?")
            ourRequest.url = components.url
            guard let param = target.parameters else {
                return ourRequest
            }
            if target.parameters?.count ?? 0 > 0 {
                components.queryItems = param.compactMap { (key, value) in
                    if let key = key as? String, let value = value as? String {
                        return URLQueryItem(name: key, value: value)
                    }
                    return nil
                }
            }
            guard let updatedUrl = components.url else { return nil }
            ourRequest = URLRequest(url: updatedUrl)
            ourRequest.timeoutInterval = 60.0
            ourRequest.httpMethod = target.httpMethod.methodName
            ourRequest.allHTTPHeaderFields = target.headers as? [String: String] ?? [ : ]
            return ourRequest
        case .POST, .PUT, .DELETE:
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return nil
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "%3F", with: "?")
            ourRequest.url = components.url
            if let param = target.postQueryParameters {
                components.queryItems = param.compactMap { (key, value) in
                    if let key = key as? String, let value = value as? String {
                        return URLQueryItem(name: key, value: value)
                    }
                    return nil
                }
            }
            guard let updatedUrl = components.url else { return nil }
            ourRequest = URLRequest(url: updatedUrl)
            if let ourParams = target.parameters {
                ourRequest.httpBody = try! JSONSerialization.data(withJSONObject: ourParams, options: .prettyPrinted)
            }
        }
        //        ourRequest.cachePolicy = BAReachAbility.isConnectedToNetwork() ? NSURLRequest.CachePolicy.returnCacheDataElseLoad : NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        ourRequest.timeoutInterval = 60.0
        ourRequest.httpMethod = target.httpMethod.methodName
        ourRequest.allHTTPHeaderFields = target.headers as? [String: String] ?? [ : ]
        return ourRequest
    }
}
