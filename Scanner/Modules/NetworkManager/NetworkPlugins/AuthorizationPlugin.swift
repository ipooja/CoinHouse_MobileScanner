//  Copyright © 2019 Pooja  . All rights reserved.

import Foundation

class AuthorizationPlugin: NetworkPluginType {
    private let authorizationTokenProvider: AuthorizationTokenProvideable

    init(tokenProvider: AuthorizationTokenProvideable) {
        self.authorizationTokenProvider = tokenProvider
    }

    func mutate(_ request: URLRequest, target: TargetDefinition) -> URLRequest {
        guard let val = target as? RequiresAccessAuthorization,
            let token = self.authorizationTokenProvider.accessToken(),
            let typeOfAuth = target.authType.value else {
                return request
        }
		print("This is ", val)
        let value = "\(typeOfAuth) \(token)"
        var mutatedRequest = request
        mutatedRequest.addValue(value, forHTTPHeaderField: "Authorization")
        return mutatedRequest
    }
}
