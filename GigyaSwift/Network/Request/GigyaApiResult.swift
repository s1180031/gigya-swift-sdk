//
//  GigyaApiResult.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 19/03/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation

public enum GigyaApiResult<Response> {
    case success(data: Response)
    case failure(NetworkError)
}

public enum GigyaLoginResult<Response> {
    case success(data: Response)
    case failure(LoginApiError<Response>)
}

public struct LoginApiError<T> {
    let error: NetworkError
    let interruption: GigyaInterruptions<T>?
}

public enum GigyaInterruptions<T> {
    case pendingVerification(regToken: String)
    case conflitingAccounts(resolver: LinkAccountsResolver<T>)
}
