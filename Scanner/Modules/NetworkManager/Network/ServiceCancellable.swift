//  Copyright © 2019 Pooja  . All rights reserved.
//

protocol ServiceCancellable {
    func cancel()
}

struct DummyCancellable: ServiceCancellable {
    func cancel() {}
}
