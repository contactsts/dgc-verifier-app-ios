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


struct InfoBox: UBCodable, Equatable {
    let title, msg: String
    let url: URL?
    let urlTitle: String?
    let infoId: String?
    let isDismissible: Bool?
}



class InfoBoxVisibilityManager {
    static let shared = InfoBoxVisibilityManager()
    private init() {}

    @KeychainPersisted(key: "dismissedInfoBoxIds", defaultValue: [])
    var dismissedInfoBoxIds: [String]
}


//public enum ImmunisationType: String, Codable {
//    case test = "t"
//    case recovery = "r"
//    case vaccination = "v"
//}
//
//
//public struct Person: Codable {
//    public let givenName: String?
//    public let standardizedGivenName: String?
//    public let familyName: String?
//    public let standardizedFamilyName: String
//
//    private enum CodingKeys: String, CodingKey {
//        case givenName = "gn"
//        case standardizedGivenName = "gnt"
//        case familyName = "fn"
//        case standardizedFamilyName = "fnt"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        givenName = try? container.decode(String.self, forKey: .givenName).trimmed
//        standardizedGivenName = try? container.decode(String.self, forKey: .standardizedGivenName).trimmed
//        familyName = try? container.decode(String.self, forKey: .familyName).trimmed
//        standardizedFamilyName = try container.decode(String.self, forKey: .standardizedFamilyName).trimmed
//    }
//}
//
//public struct Vaccination: Codable {
//    public let disease: String
//    public let vaccine: String
//    public let medicinialProduct: String
//    public let marketingAuthorizationHolder: String
//    public let doseNumber: UInt64
//    public let totalDoses: UInt64
//    public let vaccinationDate: String
//    public let country: String
//    public let certificateIssuer: String
//    public let certificateIdentifier: String
//
//    private enum CodingKeys: String, CodingKey {
//        case disease = "tg"
//        case vaccine = "vp"
//        case medicinialProduct = "mp"
//        case marketingAuthorizationHolder = "ma"
//        case doseNumber = "dn"
//        case totalDoses = "sd"
//        case vaccinationDate = "dt"
//        case country = "co"
//        case certificateIssuer = "is"
//        case certificateIdentifier = "ci"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        disease = try container.decode(String.self, forKey: .disease).trimmed
//        vaccine = try container.decode(String.self, forKey: .vaccine).trimmed
//        medicinialProduct = try container.decode(String.self, forKey: .medicinialProduct).trimmed
//        marketingAuthorizationHolder = try container.decode(String.self, forKey: .marketingAuthorizationHolder).trimmed
//
//        if let dn = try? container.decode(Double.self, forKey: .doseNumber) {
//            doseNumber = UInt64(dn)
//        } else {
//            doseNumber = try container.decode(UInt64.self, forKey: .doseNumber)
//        }
//
//        if let dn = try? container.decode(Double.self, forKey: .totalDoses) {
//            totalDoses = UInt64(dn)
//        } else {
//            totalDoses = try container.decode(UInt64.self, forKey: .totalDoses)
//        }
//
//        vaccinationDate = try container.decode(String.self, forKey: .vaccinationDate).trimmed
//        country = try container.decode(String.self, forKey: .country).trimmed
//        certificateIssuer = try container.decode(String.self, forKey: .certificateIssuer).trimmed
//        certificateIdentifier = try container.decode(String.self, forKey: .certificateIdentifier).trimmed
//    }
//
//    public var isTargetDiseaseCorrect: Bool {
//        return disease == Disease.SarsCov2.rawValue
//    }
//
//    /// we need a date of vaccination which needs to be in the format of yyyy-MM-dd
//    var dateFormatter: DateFormatter {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = DATE_FORMAT
//        return dateFormatter
//    }
//
//    public var dateOfVaccination: Date? {
//        return dateFormatter.date(from: vaccinationDate)
//    }
//
//    public func getValidFromDate(singleVaccineValidityOffset: Int,
//                                 twoVaccineValidityOffset: Int,
//                                 totalDoses: Int) -> Date? {
//        guard let dateOfVaccination = self.dateOfVaccination
//        else {
//            return nil
//        }
//
//        if totalDoses == 1 {
//            return Calendar.current.date(byAdding: DateComponents(day: singleVaccineValidityOffset), to: dateOfVaccination)
//        } else if totalDoses == 2 {
//            return Calendar.current.date(byAdding: DateComponents(day: twoVaccineValidityOffset), to: dateOfVaccination)
//        } else {
//            // in any other case the vaccine is valid from the date of vaccination
//            return dateOfVaccination
//        }
//    }
//
//    public func getValidUntilDate(maximumValidityInDays: Int) -> Date? {
//        guard let dateOfVaccination = self.dateOfVaccination,
//              let date = Calendar.current.date(byAdding: DateComponents(day: maximumValidityInDays), to: dateOfVaccination) else {
//            return nil
//        }
//        return date
//    }
//
//    public var name: String? {
//        return ProductNameManager.shared.vaccineProductName(key: medicinialProduct)
//    }
//
//    public var authHolder: String? {
//        return ProductNameManager.shared.vaccineManufacturer(key: marketingAuthorizationHolder)
//    }
//
//    public var prophylaxis: String? {
//        return ProductNameManager.shared.vaccineProphylaxisName(key: vaccine)
//    }
//}
//
//public struct Test: Codable {
//    public let disease: String
//    public let type: String
//    public let naaTestName: String?
//    public let ratTestNameAndManufacturer: String?
//    public let timestampSample: String
//    public let timestampResult: String?
//    public let result: String
//    public let testCenter: String?
//    public let country: String
//    public let certificateIssuer: String
//    public let certificateIdentifier: String
//
//    private enum CodingKeys: String, CodingKey {
//        case disease = "tg"
//        case type = "tt"
//        case naaTestName = "nm"
//        case ratTestNameAndManufacturer = "ma"
//        case timestampSample = "sc"
//        case timestampResult = "dr"
//        case result = "tr"
//        case testCenter = "tc"
//        case country = "co"
//        case certificateIssuer = "is"
//        case certificateIdentifier = "ci"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        disease = try container.decode(String.self, forKey: .disease).trimmed
//        type = try container.decode(String.self, forKey: .type).trimmed
//        naaTestName = try? container.decode(String.self, forKey: .naaTestName).trimmed
//        ratTestNameAndManufacturer = try? container.decode(String.self, forKey: .ratTestNameAndManufacturer).trimmed
//        timestampSample = try container.decode(String.self, forKey: .timestampSample).trimmed
//        timestampResult = try? container.decode(String.self, forKey: .timestampResult).trimmed
//        result = try container.decode(String.self, forKey: .result).trimmed
//        testCenter = try? container.decode(String.self, forKey: .testCenter).trimmed
//        country = try container.decode(String.self, forKey: .country).trimmed
//        certificateIssuer = try container.decode(String.self, forKey: .certificateIssuer).trimmed
//        certificateIdentifier = try container.decode(String.self, forKey: .certificateIdentifier).trimmed
//    }
//
//    public var validFromDate: Date? {
//        return Date.fromISO8601(timestampSample)
//    }
//
//    public var resultDate: Date? {
//        if let res = timestampResult {
//            return Date.fromISO8601(res)
//        }
//
//        return nil
//    }
//
//    /// PCR tests are valid for 72h after sample collection. RAT tests are valid for 24h and have an optional validfrom. We just never set it
//    public var validUntilDate: Date? {
//        guard let startDate = validFromDate else { return nil }
//
//        switch type {
//        case TestType.Pcr.rawValue:
//            return Calendar.current.date(byAdding: DateComponents(hour: PCR_TEST_VALIDITY_IN_HOURS), to: startDate)
//        case TestType.Rat.rawValue:
//            return Calendar.current.date(byAdding: DateComponents(hour: RAT_TEST_VALIDITY_IN_HOURS), to: startDate)
//        default:
//            return nil
//        }
//    }
//
//    public func getValidUntilDate(pcrTestValidityInHours: Int, ratTestValidityInHours: Int) -> Date? {
//        guard let startDate = validFromDate else { return nil }
//        switch type {
//        case TestType.Pcr.rawValue:
//            return Calendar.current.date(byAdding: DateComponents(hour: pcrTestValidityInHours), to: startDate)
//        case TestType.Rat.rawValue:
//            return Calendar.current.date(byAdding: DateComponents(hour: ratTestValidityInHours), to: startDate)
//        default:
//            return nil
//        }
//    }
//
//    public var isTargetDiseaseCorrect: Bool {
//        return disease == Disease.SarsCov2.rawValue
//    }
//
//    public var isNegative: Bool {
//        return result == TestResult.Negative.rawValue
//    }
//
//    public var testType: String? {
//        return ProductNameManager.shared.testTypeName(key: type)
//    }
//
//    public var manufacturerAndTestName: String? {
//        switch type {
//        case TestType.Pcr.rawValue:
//            return naaTestName ?? "PCR"
//        case TestType.Rat.rawValue:
//            return ProductNameManager.shared.testManufacturerName(key: ratTestNameAndManufacturer) ?? ratTestNameAndManufacturer
//        default:
//            return nil
//        }
//    }
//}
//
//public struct PastInfection: Codable {
//    public let disease: String
//    public let dateFirstPositiveTest: String
//    public let countryOfTest: String
//    public let certificateIssuer: String
//    public let validFrom: String
//    public let validUntil: String
//    public let certificateIdentifier: String
//
//    private enum CodingKeys: String, CodingKey {
//        case disease = "tg"
//        case dateFirstPositiveTest = "fr"
//        case countryOfTest = "co"
//        case certificateIssuer = "is"
//        case validFrom = "df"
//        case validUntil = "du"
//        case certificateIdentifier = "ci"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        disease = try container.decode(String.self, forKey: .disease).trimmed
//        dateFirstPositiveTest = try container.decode(String.self, forKey: .dateFirstPositiveTest).trimmed
//        countryOfTest = try container.decode(String.self, forKey: .countryOfTest).trimmed
//        certificateIssuer = try container.decode(String.self, forKey: .certificateIssuer).trimmed
//        validFrom = try container.decode(String.self, forKey: .validFrom).trimmed
//        validUntil = try container.decode(String.self, forKey: .validUntil).trimmed
//        certificateIdentifier = try container.decode(String.self, forKey: .certificateIdentifier).trimmed
//    }
//
//    var dateFormatter: DateFormatter {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = DATE_FORMAT
//        return dateFormatter
//    }
//
//    public var firstPositiveTestResultDate: Date? {
//        return dateFormatter.date(from: dateFirstPositiveTest)
//    }
//
//    public var validFromDate: Date? {
//        guard let firstPositiveTestResultDate = self.firstPositiveTestResultDate,
//              let date = Calendar.current.date(byAdding: DateComponents(day: INFECTION_VALIDITY_OFFSET_IN_DAYS), to: firstPositiveTestResultDate) else {
//            return nil
//        }
//        return date
//    }
//
//    public func getValidUntilDate(maximumValidityInDays: Int) -> Date? {
//        guard let firstPositiveTestResultDate = self.firstPositiveTestResultDate,
//              let date = Calendar.current.date(byAdding: DateComponents(day: maximumValidityInDays), to: firstPositiveTestResultDate) else {
//            return nil
//        }
//        return date
//    }
//
//    public var isTargetDiseaseCorrect: Bool {
//        return disease == Disease.SarsCov2.rawValue
//    }
//}
//
//
//
//
//class Products: Codable {
//    let valueSetId: String?
//    let valueSetDate: String?
//    let valueSetValues: [String: ProductEntry]
//
//    init() {
//        valueSetId = nil
//        valueSetDate = nil
//        valueSetValues = [:]
//    }
//
//    // MARK: - Product name helper
//
//    func productName(key: String?) -> String? {
//        guard let k = key,
//              let p = valueSetValues[k],
//              let name = p.display
//        else {
//            let empty = key?.isEmpty ?? true
//            return empty ? nil : key
//        }
//
//        return name
//    }
//}
//
//
//
//class ProductNameManager {
//    // MARK: - Lookup Tables
//
//    private var vaccineManufacturers: Products { MetadataManager.currentMetadata.vaccine.mahManf }
//    private var vaccineProducts: Products { MetadataManager.currentMetadata.vaccine.medicinalProduct }
//    private var vaccineProphylaxis: Products { MetadataManager.currentMetadata.vaccine.prophylaxis }
//    private var testManufacturers: Products { MetadataManager.currentMetadata.test.manf }
//    private var testTypes: Products { MetadataManager.currentMetadata.test.type }
//
//    // MARK: - Shared instance
//
//    static let shared = ProductNameManager()
//
//    // MARK: - API
//
//    func vaccineManufacturer(key: String?) -> String? {
//        return vaccineManufacturers.productName(key: key)
//    }
//
//    func vaccineProductName(key: String?) -> String? {
//        return vaccineProducts.productName(key: key)
//    }
//
//    func vaccineProphylaxisName(key: String?) -> String? {
//        return vaccineProphylaxis.productName(key: key)
//    }
//
//    func testManufacturerName(key: String?) -> String? {
//        return testManufacturers.productName(key: key)
//    }
//
//    func testTypeName(key: String?) -> String? {
//        return testTypes.productName(key: key)
//    }
//}




extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespaces)
    }
}

