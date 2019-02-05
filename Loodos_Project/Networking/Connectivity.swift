//
//  Connectivity.swift
//  Loodos_Project
//
//  Created by Ünal Öztürk on 4.02.2019.
//  Copyright © 2019 Ünal Öztürk. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
