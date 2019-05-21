//
//  GSRequestWrapper.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 20/03/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation
import GigyaSDK

public typealias GigyaResponseHandler = (NSData?, Error?) -> Void

protocol IOCNetworkAdapterProtocol {
    func send(model: ApiRequestModel, completion: @escaping GigyaResponseHandler)
}

class NetworkAdapter: IOCNetworkAdapterProtocol {
    func send(model: ApiRequestModel, completion: @escaping GigyaResponseHandler) {
        let request = GSRequest(forMethod: model.method, parameters: model.params)

        let request1 = NetworkProvider(url: InternalConfig.General.sdkDomain)

        request1.dataRequest(gsession: nil, path: model.method, body: model.params, responseType: , completion: <#T##(NetworkResult<Decodable & Encodable>) -> Void#>)
        request.send { (res, error) in
            let data = res?.jsonString().data(using: .utf8) as NSData?
            completion(data, error)
        }
    }
}
