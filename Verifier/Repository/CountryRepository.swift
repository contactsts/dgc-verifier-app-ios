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

class CountryRepository : BaseRepository {
    
    
    
    public func getCountriesList( completion: @escaping (_ result: [String]?) -> Void ) {
        let request = AF.request("\(BASE_URL )/countrylist")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let countryCodesList = try JSONDecoder().decode([String].self, from: responseData)
                completion(countryCodesList)
            } catch {
                completion(nil)
            }
        }
        
        
        
    }
    
    
    
}
