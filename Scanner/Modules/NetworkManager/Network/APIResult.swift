//  Copyright © 2019 Pooja  . All rights reserved.

enum APIResult<SuccessType, ErrorType> {
    case success(SuccessType)
    case error(ErrorType)
}

extension APIResult {
    public var value: SuccessType? {
        guard case .success(let value) = self else { return nil }
        return value
    }

    public var error: ErrorType? {
           guard case .error(let error) = self else { return nil }
           return error
       }
}
