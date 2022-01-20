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
import SwiftDGC

//    typealias HolderModel = VerifierCertificateHolder
    typealias HolderModel = HCert
//    typealias SDKNamespace = CovidCertificateSDK.Verifier


enum VerificationError: Equatable, Comparable {
    case signature
    case typeInvalid
    case revocation
    case expired(Date)
    case notYetValid(Date)
    case otherNationalRules
    case unknown
}

enum RetryError: Equatable {
    case network
    case noInternetConnection
    case unknown
}

enum VerificationState: Equatable {
    case loading
    // verification was skipped
    
    case success(String?)
    // sorted errors, error codes, validity as formatted date as String
    
    case failure(errors: [String])
    
//    case invalid(errors: [VerificationError], errorCodes: [String], validity: String?, wasRevocationSkipped: Bool)
//    // retry error, error codes
//    case retry(RetryError, [String])

    public func isInvalid() -> Bool {
        switch self {
        case .failure:
            return true
        default:
            return false
        }
    }

    public func isSuccess() -> Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }



    


}


// TODO: IS this class even necesarry
class Verifier: NSObject {
    private let holder: HolderModel?
    private var stateUpdate: ((VerificationState) -> Void)?

    // MARK: - Init

    init(holder: HolderModel) {
        self.holder = holder
        super.init()
    }

    init(qrString: String) {
        
        self.holder = HCert(from: qrString)
        
//        let result = SDKNamespace.decode(encodedData: qrString)
//
//        switch result {
//        case let .success(holder):
//            self.holder = holder
//        case .failure:
//            holder = nil
//        }

        super.init()
    }

    // MARK: - Start

    public func start(forceUpdate: Bool = false, stateUpdate: @escaping ((VerificationState) -> Void)) {
        self.stateUpdate = stateUpdate

        guard let holder = holder else {
            // should never happen
//            self.stateUpdate?(.invalid(errors: [.unknown], errorCodes: ["V|HN"], validity: nil, wasRevocationSkipped: false))
            return
        }

        DispatchQueue.main.async {
            self.stateUpdate?(.loading)
        }

//        SDKNamespace.check(holder: holder, forceUpdate: forceUpdate) { [weak self] results in
//            guard let self = self else { return }
//            let checkSignatureState = self.handleSignatureResult(results.signature)
//            let checkRevocationState = self.handleRevocationResult(results.revocationStatus)
//            let checkNationalRulesState = self.handleNationalRulesResult(results.nationalRules)
//
//            let states = [checkSignatureState, checkRevocationState, checkNationalRulesState]
//
//            var errors = states.compactMap { $0.verificationErrors() }.flatMap { $0 }
//            errors.sort()
//
//            var errorCodes = states.compactMap { $0.errorCodes() }.flatMap { $0 }
//            errorCodes.sort()
//
//            let retries = states.filter { $0.isRetry() }
//
//            if errors.count > 0 {
//                let validityString = checkNationalRulesState.validUntilDateString()
//                self.stateUpdate?(.invalid(errors: errors, errorCodes: errorCodes, validity: validityString, wasRevocationSkipped: results.revocationStatus == nil))
//            } else if let r = retries.first {
//                self.stateUpdate?(r)
//            } else if states.allSatisfy({ $0.isSuccess() }) {
//                self.stateUpdate?(checkNationalRulesState)
//            }
//        }
    }

    public func restart(forceUpdate: Bool = false) {
        guard let su = stateUpdate else { return }
        start(forceUpdate: forceUpdate, stateUpdate: su)
    }

    // MARK: - Signature

//    private func handleSignatureResult(_ result: Result<ValidationResult, ValidationError>) -> VerificationState {
//        switch result {
//        case let .success(result):
//            if result.isValid {
//                return .success(nil)
//            } else {
//                // !: checked
//                let errorCodes = result.error != nil ? [result.error!.errorCode] : []
//                return .invalid(errors: [.signature], errorCodes: errorCodes, validity: nil, wasRevocationSkipped: false)
//            }
//
//        case let .failure(err):
//            switch err {
//            case .NETWORK_NO_INTERNET_CONNECTION:
//                // retry possible
//                return .retry(.noInternetConnection, [err.errorCode])
//            case .NETWORK_PARSE_ERROR, .NETWORK_ERROR:
//                return .retry(.network, [err.errorCode])
//            case .SIGNATURE_TYPE_INVALID:
//                return .invalid(errors: [.typeInvalid], errorCodes: [err.errorCode], validity: nil, wasRevocationSkipped: false)
//            case .CWT_EXPIRED:
//                return .invalid(errors: [.signatureExpired], errorCodes: [err.errorCode], validity: nil, wasRevocationSkipped: false)
//            default:
//                // error
//                return .invalid(errors: [.signature], errorCodes: [err.errorCode], validity: nil, wasRevocationSkipped: false)
//            }
//        }
//    }
//
//    private func handleRevocationResult(_ result: Result<ValidationResult, ValidationError>?) -> VerificationState {
//        guard let result = result else { return .skipped }
//        switch result {
//        case let .success(result):
//            if result.isValid {
//                return .success(nil)
//            } else {
//                // !: checked
//                let errorCodes = result.error != nil ? [result.error!.errorCode] : []
//                return .invalid(errors: [.revocation], errorCodes: errorCodes, validity: nil, wasRevocationSkipped: false)
//            }
//
//        case let .failure(err):
//            switch err {
//            case .NETWORK_NO_INTERNET_CONNECTION:
//                // retry possible
//                return .retry(.noInternetConnection, [err.errorCode])
//            case .NETWORK_PARSE_ERROR, .NETWORK_ERROR:
//                return .retry(.network, [err.errorCode])
//            default:
//                return .invalid(errors: [.revocation], errorCodes: [err.errorCode], validity: nil, wasRevocationSkipped: false)
//            }
//        }
//    }
//
//    private func handleNationalRulesResult(_ result: Result<VerificationResult, NationalRulesError>) -> VerificationState {
//        guard let holder = holder else {
//            assertionFailure()
//            return .invalid(errors: [.unknown], errorCodes: ["V|HN"], validity: nil, wasRevocationSkipped: false)
//        }
//        switch result {
//        case let .success(result):
//            var validUntil: String?
//
//            // get expired date string
//            if let date = result.validUntil {
//                #if WALLET
//                    switch (holder.certificate as? DCCCert)?.immunisationType {
//                    case .test:
//                        validUntil = DateFormatter.ub_dayTimeString(from: date)
//                    case .recovery:
//                        validUntil = DateFormatter.ub_dayString(from: date)
//                    case .vaccination:
//                        validUntil = DateFormatter.ub_dayString(from: date)
//                    case .none:
//                        break
//                    }
//                #endif
//            }
//
//            // check for validity
//            if result.isValid {
//                return .success(validUntil)
//            } else if let dateError = result.dateError {
//                switch dateError {
//                case .NOT_YET_VALID:
//                    return .invalid(errors: [.notYetValid(result.validFrom ?? Date())], errorCodes: [], validity: validUntil, wasRevocationSkipped: false)
//                case .EXPIRED:
//                    return .invalid(errors: [.expired(result.validUntil ?? Date())], errorCodes: [], validity: validUntil, wasRevocationSkipped: false)
//                case .NO_VALID_DATE:
//                    return .invalid(errors: [.typeInvalid], errorCodes: [], validity: validUntil, wasRevocationSkipped: false)
//                }
//            } else {
//                return .invalid(errors: [.otherNationalRules], errorCodes: [], validity: validUntil, wasRevocationSkipped: false)
//            }
//        case let .failure(err):
//            switch err {
//            case .NETWORK_NO_INTERNET_CONNECTION:
//                // retry possible
//                return .retry(.noInternetConnection, [err.errorCode])
//            case .NETWORK_PARSE_ERROR, .NETWORK_ERROR:
//                // retry possible
//                return .retry(.network, [err.errorCode])
//            default:
//                // do not show the explicit error code on the verifier app, s.t.
//                // no information is shown about the checked user (e.g. certificate type)
//                #if WALLET
//                    return .invalid(errors: [.otherNationalRules], errorCodes: [err.errorCode], validity: nil, wasRevocationSkipped: false)
//                #elseif VERIFIER
//                    return .invalid(errors: [.otherNationalRules], errorCodes: [], validity: nil, wasRevocationSkipped: false)
//                #endif
//            }
//        }
//    }
}



