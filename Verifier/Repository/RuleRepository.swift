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
//import Alamofire
import Alamofire
import Networking

class RuleRepository : BaseRepository {
    
    
    
    public func getExternalRulesSummary( completion: @escaping (_ result: [AFRuleSummary]?) -> Void ) {
        let request = AF.request("\(BASE_URL )/rules")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let rulesSumary = try JSONDecoder().decode([AFRuleSummary].self, from: responseData)
                completion(rulesSumary)
            } catch {
                completion(nil)
            }
        }
    }
    
    
    public func getExternalRuleDetailed(countryCode: String, hash: String, completion: @escaping (_ result: AFRuleDetailed?) -> Void ) {
        let request = AF.request("\(BASE_URL )/rules/\(countryCode)/\(hash)")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let detailedRule = try JSONDecoder().decode(AFRuleDetailed.self, from: responseData)
                completion(detailedRule)
            } catch {
                completion(nil)
            }
        }
    }
    
    
    // -----------------
    
    
    public func getNationalRulesSummary( completion: @escaping (_ result: [AFRuleSummary]?) -> Void ) {
        let request = AF.request("\(BASE_URL )/rules/national")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let rulesSumary = try JSONDecoder().decode([AFRuleSummary].self, from: responseData)
                completion(rulesSumary)
            } catch {
                completion(nil)
            }
        }
    }
    
    public func getNationalRuleDetailed(hash: String, completion: @escaping (_ result: AFRuleDetailed?) -> Void ) {
        let request = AF.request("\(BASE_URL )/rules/national/\(hash)")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let detailedRule = try JSONDecoder().decode(AFRuleDetailed.self, from: responseData)
                completion(detailedRule)
            } catch {
                completion(nil)
            }
        }
    }
    
}
