//
//  GigyaApiStatusCode.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 20/03/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation

enum ApiStatusCode: Int {
    case succsess = 200
//    case fail = 403
    case unknown
}

extension ApiStatusCode: Codable {
    public init(from decoder: Decoder) throws {
        self = try ApiStatusCode(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
