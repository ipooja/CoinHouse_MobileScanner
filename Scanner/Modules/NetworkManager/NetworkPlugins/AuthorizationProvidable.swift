//  Copyright © 2019 Pooja  . All rights reserved.

protocol AuthorizationTokenProvideable {
    func accessToken() -> String?
}

class AuthorizationTokenProvider: AuthorizationTokenProvideable {
    func accessToken() -> String? {
        return "3423864873"
    }
}
