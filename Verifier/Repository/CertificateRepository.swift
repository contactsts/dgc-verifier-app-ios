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

class CertificateRepository : BaseRepository {
    
    
    
    public func getCertificatesList( completion: @escaping (_ result: [AFCertificate]?) -> Void ) {
        let request = AF.request("\(BASE_URL )/dsc/certificates")
        request.response { (response) in
            do {
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                let certificatesList = try JSONDecoder().decode([AFCertificate].self, from: responseData)
                completion(certificatesList)
            } catch {
                completion(nil)
            }
        }
        
        
        
    }
    
    
    
}
