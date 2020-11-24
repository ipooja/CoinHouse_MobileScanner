//
//  AddressViewModel.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import Foundation

protocol AddressVMProtocol {
    func getScreenData(completion: @escaping(Bool, String?) -> Void)
}


class AddressVM: AddressVMProtocol {
    
    var dataModel: AddressModel!
    var repo: AddressDataCallRepo
    var requestToken: ServiceCancellable?
    var apiParams = APIParams()
    
    init(repo: AddressDataCallRepo) {
        self.repo = repo
    }
    
    func getScreenData(completion: @escaping(Bool, String?) -> Void) {
        requestToken = repo.getHomeTypeScreenData(completion: { (serverData, error) in
            self.requestToken = nil
            if error == nil {
                self.dataModel = serverData?.parsed
                completion(true, "Success")
            } else {
                print("this is error \(error)")
                completion(false, "Failed")
            }
        })
        
    }
    
    
}
