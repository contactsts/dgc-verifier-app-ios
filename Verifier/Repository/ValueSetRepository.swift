//
/*
 * Copyright (c) 2021 Ubique Innovation AG <https://www.ubique.ch>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * SPDX-License-Identifier: MPL-2.0
 */

import Foundation
import Alamofire
import Networking

class ValueSetRepository : BaseRepository {
    
    
    
    public func getIndex( completion: @escaping (_ result: [AFValueSetIndex]?) -> Void ) {
        let request = AF.request("\(BASE_URL)/valuesets")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let valueSetIndexList = try JSONDecoder().decode([AFValueSetIndex].self, from: responseData)
                completion(valueSetIndexList)
            } catch {
                completion(nil)
            }
        }
    }
    
    
    public func getValueSetByHash(hash: String, completion: @escaping (_ result: AFValueSet?) -> Void ) {
        let request = AF.request("\(BASE_URL)/valuesets/\(hash)")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let valueSet = try JSONDecoder().decode(AFValueSet.self, from: responseData)
                completion(valueSet)
            } catch {
                completion(nil)
            }
        }
    }
    
    
}
