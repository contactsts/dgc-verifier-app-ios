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

//public extension ImmunisationType {
//    var displayName: String {
//        switch self {
//        case .recovery:
//            return UBLocalized.certificate_reason_recovered
//        case .test:
//            return UBLocalized.certificate_reason_tested
//        case .vaccination:
//            return UBLocalized.certificate_reason_vaccinated
//        }
//    }
//}
//
//
//
//
//extension Vaccination {
//    var getNumberOverTotalDose: String {
//        return "\(doseNumber)/\(totalDoses)"
//    }
//
//    var displayDateOfVaccination: String {
//        if let d = dateOfVaccination {
//            return DateFormatter.ub_dayString(from: d)
//        }
//
//        // fallback
//        return vaccinationDate
//    }
//
//    var displayCountry: String {
//        return Locale.current.localizedString(forRegionCode: country) ?? country
//    }
//
//    var displayCountryEnglish: String? {
//        return Locale(identifier: "en").localizedString(forRegionCode: country)
//    }
//}
//
//extension PastInfection {
//    var displayCountry: String {
//        return Locale.current.localizedString(forRegionCode: countryOfTest) ?? countryOfTest
//    }
//
//    var displayCountryEnglish: String? {
//        return Locale(identifier: "en").localizedString(forRegionCode: countryOfTest)
//    }
//
//    var displayFirstPositiveTest: String? {
//        if let d = firstPositiveTestResultDate {
//            return DateFormatter.ub_dayString(from: d)
//        }
//
//        return nil
//    }
//}
//
//extension Test {
//    var displayCountry: String {
//        return Locale.current.localizedString(forRegionCode: country) ?? country
//    }
//
//    var displayCountryEnglish: String? {
//        return Locale(identifier: "en").localizedString(forRegionCode: country)
//    }
//
//    var displaySampleDateTime: String? {
//        if let d = validFromDate {
//            return DateFormatter.ub_dayTimeString(from: d)
//        }
//
//        return timestampSample
//    }
//
//    var displayResultDateTime: String? {
//        if let d = resultDate {
//            return DateFormatter.ub_dayTimeString(from: d)
//        }
//
//        return timestampResult
//    }
//}
