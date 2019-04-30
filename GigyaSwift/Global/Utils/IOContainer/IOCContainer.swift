//
//  GigyaContainer.swift
//  GigyaSwift
//
//  Created by Shmuel, Sagi on 31/03/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

import Foundation

typealias ResolverHandling<T> = (ResolverProtocol) -> T

class IOCContainer {
    private var services: [String: ServiceMaker<Any>] = [:]

    func register<Service>(service: Service.Type, isSingleton: Bool = false, factory: @escaping ResolverHandling<Service>) {
        let serviceName = String(describing: Service.self)

        services[serviceName] = ServiceMaker<Any>(method: factory, isSingleton: isSingleton, resolver: self)
    }
}

extension IOCContainer: ResolverProtocol {
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        let instanceName = String(describing: Service.self)
        let instance = services[instanceName]?.get()

        return instance as? Service
    }
}
