import Foundation


struct FLCountry {
    
    var name: String?
    var code: String?
    var flag: String?
    
}


class CountryManager {

    
    static var sharedInstance: CountryManager = {
      let instance = CountryManager()
        instance.setup()
      return instance
    }()
    
    
    public var countriesListForLanguage : [GenericPickerItem] = []
    public var defaultCountryCode = "ro"
    public var defaultCountry : FLCountry!
    public var countriesListForRules : [FLCountry] = []
    
    init() {
        
    }
    
    private func setup() {
        countriesListForRules = getCountriesListForRules()
        defaultCountry = countriesListForRules.first(where: { $0.code == defaultCountryCode })!
        countriesListForLanguage = getCountriesListForLanguage()
    }
    
    
    private func getCountriesListForLanguage() ->  [GenericPickerItem] {
        return [
            GenericPickerItem(id: "ro", title: "Română"),
            GenericPickerItem(id: "en", title: "English"),
        ]
    }
    

    
    private func getCountriesListForRules() ->  [FLCountry] {
        var list =  [
            FLCountry(name: UBLocalized.country_afghanistan, code: "af", flag: ""),
            FLCountry(name: UBLocalized.country_aland_islands, code: "ax", flag: ""),
            FLCountry(name: UBLocalized.country_albania, code: "al", flag: ""),
            FLCountry(name: UBLocalized.country_algeria, code: "dz", flag: ""),
            FLCountry(name: UBLocalized.country_american_samoa, code: "as", flag: ""),
            FLCountry(name: UBLocalized.country_andorra, code: "ad", flag: ""),
            FLCountry(name: UBLocalized.country_angola, code: "ao", flag: ""),
            FLCountry(name: UBLocalized.country_anguilla, code: "ai", flag: ""),
            FLCountry(name: UBLocalized.country_antarctica, code: "aq", flag: ""),
            FLCountry(name: UBLocalized.country_antigua_and_barbuda, code: "ag", flag: ""),
            FLCountry(name: UBLocalized.country_argentina, code: "ar", flag: ""),
            FLCountry(name: UBLocalized.country_armenia, code: "am", flag: ""),
            FLCountry(name: UBLocalized.country_aruba, code: "aw", flag: ""),
            FLCountry(name: UBLocalized.country_australia, code: "au", flag: ""),
            FLCountry(name: UBLocalized.country_austria, code: "at", flag: ""),
            FLCountry(name: UBLocalized.country_azerbaijan, code: "az", flag: ""),
            FLCountry(name: UBLocalized.country_bahamas, code: "bs", flag: ""),
            FLCountry(name: UBLocalized.country_bahrain, code: "bh", flag: ""),
            FLCountry(name: UBLocalized.country_bangladesh, code: "bd", flag: ""),
            FLCountry(name: UBLocalized.country_barbados, code: "bb", flag: ""),
            FLCountry(name: UBLocalized.country_belarus, code: "by", flag: ""),
            FLCountry(name: UBLocalized.country_belgium, code: "be", flag: ""),
            FLCountry(name: UBLocalized.country_belize, code: "bz", flag: ""),
            FLCountry(name: UBLocalized.country_benin, code: "bj", flag: ""),
            FLCountry(name: UBLocalized.country_bermuda, code: "bm", flag: ""),
            FLCountry(name: UBLocalized.country_bhutan, code: "bt", flag: ""),
            FLCountry(name: UBLocalized.country_bolivia, code: "bo", flag: ""),
            FLCountry(name: UBLocalized.country_bosnia_and_herzegovina, code: "ba", flag: ""),
            FLCountry(name: UBLocalized.country_botswana, code: "bw", flag: ""),
            FLCountry(name: UBLocalized.country_brazil, code: "br", flag: ""),
            FLCountry(name: UBLocalized.country_british_indian_ocean_territory, code: "io", flag: ""),
            FLCountry(name: UBLocalized.country_british_virgin_islands, code: "vg", flag: ""),
            FLCountry(name: UBLocalized.country_brunei_darussalam, code: "bn", flag: ""),
            FLCountry(name: UBLocalized.country_bulgaria, code: "bg", flag: ""),
            FLCountry(name: UBLocalized.country_burkina_faso, code: "bf", flag: ""),
            FLCountry(name: UBLocalized.country_burundi, code: "bi", flag: ""),
            FLCountry(name: UBLocalized.country_cambodia, code: "kh", flag: ""),
            FLCountry(name: UBLocalized.country_cameroon, code: "cm", flag: ""),
            FLCountry(name: UBLocalized.country_canada, code: "ca", flag: ""),
            FLCountry(name: UBLocalized.country_cape_verde, code: "cv", flag: ""),
            FLCountry(name: UBLocalized.country_cayman_islands, code: "ky", flag: ""),
            FLCountry(name: UBLocalized.country_central_african_republic, code: "cf", flag: ""),
            FLCountry(name: UBLocalized.country_chad, code: "td", flag: ""),
            FLCountry(name: UBLocalized.country_chile, code: "cl", flag: ""),
            FLCountry(name: UBLocalized.country_china, code: "cn", flag: ""),
            FLCountry(name: UBLocalized.country_christmas_island, code: "cx", flag: ""),
            FLCountry(name: UBLocalized.country_cocos, code: "cc", flag: ""),
            FLCountry(name: UBLocalized.country_colombia, code: "co", flag: ""),
            FLCountry(name: UBLocalized.country_comoros, code: "km", flag: ""),
            FLCountry(name: UBLocalized.country_congo, code: "cg", flag: ""),
            FLCountry(name: UBLocalized.country_congo_democratic_republic, code: "cd", flag: ""),
            FLCountry(name: UBLocalized.country_cook_islands, code: "ck", flag: ""),
            FLCountry(name: UBLocalized.country_costa_rica, code: "cr", flag: ""),
            FLCountry(name: UBLocalized.country_cote_divoire, code: "ci", flag: ""),
            FLCountry(name: UBLocalized.country_croatia, code: "hr", flag: ""),
            FLCountry(name: UBLocalized.country_cuba, code: "cu", flag: ""),
            FLCountry(name: UBLocalized.country_curaçao, code: "cw", flag: ""),
            FLCountry(name: UBLocalized.country_cyprus, code: "cy", flag: ""),
            FLCountry(name: UBLocalized.country_czech_republic, code: "cz", flag: ""),
            FLCountry(name: UBLocalized.country_denmark, code: "dk", flag: ""),
            FLCountry(name: UBLocalized.country_djibouti, code: "dj", flag: ""),
            FLCountry(name: UBLocalized.country_dominica, code: "dm", flag: ""),
            FLCountry(name: UBLocalized.country_dominican_republic, code: "do", flag: ""),
            FLCountry(name: UBLocalized.country_ecuador, code: "ec", flag: ""),
            FLCountry(name: UBLocalized.country_egypt, code: "eg", flag: ""),
            FLCountry(name: UBLocalized.country_el_salvador, code: "sv", flag: ""),
            FLCountry(name: UBLocalized.country_equatorial_guinea, code: "gq", flag: ""),
            FLCountry(name: UBLocalized.country_eritrea, code: "er", flag: ""),
            FLCountry(name: UBLocalized.country_estonia, code: "ee", flag: ""),
            FLCountry(name: UBLocalized.country_ethiopia, code: "et", flag: ""),
            FLCountry(name: UBLocalized.country_falkland_islands, code: "fk", flag: ""),
            FLCountry(name: UBLocalized.country_faroe_islands, code: "fo", flag: ""),
            FLCountry(name: UBLocalized.country_fiji, code: "fj", flag: ""),
            FLCountry(name: UBLocalized.country_finland, code: "fi", flag: ""),
            FLCountry(name: UBLocalized.country_france, code: "fr", flag: ""),
            FLCountry(name: UBLocalized.country_french_guyana, code: "gf", flag: ""),
            FLCountry(name: UBLocalized.country_french_polynesia, code: "pf", flag: ""),
            FLCountry(name: UBLocalized.country_gabon, code: "ga", flag: ""),
            FLCountry(name: UBLocalized.country_gambia, code: "gm", flag: ""),
            FLCountry(name: UBLocalized.country_georgia, code: "ge", flag: ""),
            FLCountry(name: UBLocalized.country_germany, code: "de", flag: ""),
            FLCountry(name: UBLocalized.country_ghana, code: "gh", flag: ""),
            FLCountry(name: UBLocalized.country_gibraltar, code: "gi", flag: ""),
            FLCountry(name: UBLocalized.country_greece, code: "gr", flag: ""),
            FLCountry(name: UBLocalized.country_greenland, code: "gl", flag: ""),
            FLCountry(name: UBLocalized.country_grenada, code: "gd", flag: ""),
            FLCountry(name: UBLocalized.country_guadeloupe, code: "gp", flag: ""),
            FLCountry(name: UBLocalized.country_guam, code: "gu", flag: ""),
            FLCountry(name: UBLocalized.country_guatemala, code: "gt", flag: ""),
            FLCountry(name: UBLocalized.country_guinea, code: "gn", flag: ""),
            FLCountry(name: UBLocalized.country_guinea_bissau, code: "gw", flag: ""),
            FLCountry(name: UBLocalized.country_guyana, code: "gy", flag: ""),
            FLCountry(name: UBLocalized.country_haiti, code: "ht", flag: ""),
            FLCountry(name: UBLocalized.country_honduras, code: "hn", flag: ""),
            FLCountry(name: UBLocalized.country_hong_kong, code: "hk", flag: ""),
            FLCountry(name: UBLocalized.country_hungary, code: "hu", flag: ""),
            FLCountry(name: UBLocalized.country_iceland, code: "is", flag: ""),
            FLCountry(name: UBLocalized.country_india, code: "in", flag: ""),
            FLCountry(name: UBLocalized.country_indonesia, code: "id", flag: ""),
            FLCountry(name: UBLocalized.country_iran, code: "ir", flag: ""),
            FLCountry(name: UBLocalized.country_iraq, code: "iq", flag: ""),
            FLCountry(name: UBLocalized.country_ireland, code: "ie", flag: ""),
            FLCountry(name: UBLocalized.country_isle_of_man, code: "im", flag: ""),
            FLCountry(name: UBLocalized.country_israel, code: "il", flag: ""),
            FLCountry(name: UBLocalized.country_italy, code: "it", flag: ""),
            FLCountry(name: UBLocalized.country_jamaica, code: "jm", flag: ""),
            FLCountry(name: UBLocalized.country_japan, code: "jp", flag: ""),
            FLCountry(name: UBLocalized.country_jersey_, code: "je", flag: ""),
            FLCountry(name: UBLocalized.country_jordan, code: "jo", flag: ""),
            FLCountry(name: UBLocalized.country_kazakhstan, code: "kz", flag: ""),
            FLCountry(name: UBLocalized.country_kenya, code: "ke", flag: ""),
            FLCountry(name: UBLocalized.country_kiribati, code: "ki", flag: ""),
            FLCountry(name: UBLocalized.country_kosovo, code: "xk", flag: ""),
            FLCountry(name: UBLocalized.country_kuwait, code: "kw", flag: ""),
            FLCountry(name: UBLocalized.country_kyrgyzstan, code: "kg", flag: ""),
            FLCountry(name: UBLocalized.country_lao, code: "la", flag: ""),
            FLCountry(name: UBLocalized.country_latvia, code: "lv", flag: ""),
            FLCountry(name: UBLocalized.country_lebanon, code: "lb", flag: ""),
            FLCountry(name: UBLocalized.country_lesotho, code: "ls", flag: ""),
            FLCountry(name: UBLocalized.country_liberia, code: "lr", flag: ""),
            FLCountry(name: UBLocalized.country_libya, code: "ly", flag: ""),
            FLCountry(name: UBLocalized.country_liechtenstein, code: "li", flag: ""),
            FLCountry(name: UBLocalized.country_lithuania, code: "lt", flag: ""),
            FLCountry(name: UBLocalized.country_luxembourg, code: "lu", flag: ""),
            FLCountry(name: UBLocalized.country_macau, code: "mo", flag: ""),
            FLCountry(name: UBLocalized.country_macedonia, code: "mk", flag: ""),
            FLCountry(name: UBLocalized.country_madagascar, code: "mg", flag: ""),
            FLCountry(name: UBLocalized.country_malawi, code: "mw", flag: ""),
            FLCountry(name: UBLocalized.country_malaysia, code: "my", flag: ""),
            FLCountry(name: UBLocalized.country_maldives, code: "mv", flag: ""),
            FLCountry(name: UBLocalized.country_mali, code: "ml", flag: ""),
            FLCountry(name: UBLocalized.country_malta, code: "mt", flag: ""),
            FLCountry(name: UBLocalized.country_marshall_islands, code: "mh", flag: ""),
            FLCountry(name: UBLocalized.country_martinique, code: "mq", flag: ""),
            FLCountry(name: UBLocalized.country_mauritania, code: "mr", flag: ""),
            FLCountry(name: UBLocalized.country_mauritius, code: "mu", flag: ""),
            FLCountry(name: UBLocalized.country_mayotte, code: "yt", flag: ""),
            FLCountry(name: UBLocalized.country_mexico, code: "mx", flag: ""),
            FLCountry(name: UBLocalized.country_micronesia, code: "fm", flag: ""),
            FLCountry(name: UBLocalized.country_moldova, code: "md", flag: ""),
            FLCountry(name: UBLocalized.country_monaco, code: "mc", flag: ""),
            FLCountry(name: UBLocalized.country_mongolia, code: "mn", flag: ""),
            FLCountry(name: UBLocalized.country_montenegro, code: "me", flag: ""),
            FLCountry(name: UBLocalized.country_montserrat, code: "ms", flag: ""),
            FLCountry(name: UBLocalized.country_morocco, code: "ma", flag: ""),
            FLCountry(name: UBLocalized.country_mozambique, code: "mz", flag: ""),
            FLCountry(name: UBLocalized.country_myanmar, code: "mm", flag: ""),
            FLCountry(name: UBLocalized.country_namibia, code: "na", flag: ""),
            FLCountry(name: UBLocalized.country_nauru, code: "nr", flag: ""),
            FLCountry(name: UBLocalized.country_nepal, code: "np", flag: ""),
            FLCountry(name: UBLocalized.country_netherlands, code: "nl", flag: ""),
            FLCountry(name: UBLocalized.country_new_caledonia, code: "nc", flag: ""),
            FLCountry(name: UBLocalized.country_new_zealand, code: "nz", flag: ""),
            FLCountry(name: UBLocalized.country_nicaragua, code: "ni", flag: ""),
            FLCountry(name: UBLocalized.country_niger, code: "ne", flag: ""),
            FLCountry(name: UBLocalized.country_nigeria, code: "ng", flag: ""),
            FLCountry(name: UBLocalized.country_niue, code: "nu", flag: ""),
            FLCountry(name: UBLocalized.country_norfolk_islands, code: "nf", flag: ""),
            FLCountry(name: UBLocalized.country_north_korea, code: "kp", flag: ""),
            FLCountry(name: UBLocalized.country_northern_mariana_islands, code: "mp", flag: ""),
            FLCountry(name: UBLocalized.country_norway, code: "no", flag: ""),
            FLCountry(name: UBLocalized.country_oman, code: "om", flag: ""),
            FLCountry(name: UBLocalized.country_pakistan, code: "pk", flag: ""),
            FLCountry(name: UBLocalized.country_palau, code: "pw", flag: ""),
            FLCountry(name: UBLocalized.country_palestine, code: "ps", flag: ""),
            FLCountry(name: UBLocalized.country_panama, code: "pa", flag: ""),
            FLCountry(name: UBLocalized.country_papua_new_guinea, code: "pg", flag: ""),
            FLCountry(name: UBLocalized.country_paraguay, code: "py", flag: ""),
            FLCountry(name: UBLocalized.country_peru, code: "pe", flag: ""),
            FLCountry(name: UBLocalized.country_philippines, code: "ph", flag: ""),
            FLCountry(name: UBLocalized.country_pitcairn_islands, code: "pn", flag: ""),
            FLCountry(name: UBLocalized.country_poland, code: "pl", flag: ""),
            FLCountry(name: UBLocalized.country_portugal, code: "pt", flag: ""),
            FLCountry(name: UBLocalized.country_puerto_rico, code: "pr", flag: ""),
            FLCountry(name: UBLocalized.country_qatar, code: "qa", flag: ""),
            FLCountry(name: UBLocalized.country_reunion, code: "re", flag: ""),
            FLCountry(name: UBLocalized.country_romania, code: "ro", flag: ""),
            FLCountry(name: UBLocalized.country_russian_federation, code: "ru", flag: ""),
            FLCountry(name: UBLocalized.country_rwanda, code: "rw", flag: ""),
            FLCountry(name: UBLocalized.country_saint_barthelemy, code: "bl", flag: ""),
            FLCountry(name: UBLocalized.country_saint_helena, code: "sh", flag: ""),
            FLCountry(name: UBLocalized.country_saint_kitts_and_nevis, code: "kn", flag: ""),
            FLCountry(name: UBLocalized.country_saint_lucia, code: "lc", flag: ""),
            FLCountry(name: UBLocalized.country_saint_martin, code: "mf", flag: ""),
            FLCountry(name: UBLocalized.country_saint_pierre_and_miquelon, code: "pm", flag: ""),
            FLCountry(name: UBLocalized.country_saint_vincent, code: "vc", flag: ""),
            FLCountry(name: UBLocalized.country_samoa, code: "ws", flag: ""),
            FLCountry(name: UBLocalized.country_san_marino, code: "sm", flag: ""),
            FLCountry(name: UBLocalized.country_sao_tome_and_principe, code: "st", flag: ""),
            FLCountry(name: UBLocalized.country_saudi_arabia, code: "sa", flag: ""),
            FLCountry(name: UBLocalized.country_senegal, code: "sn", flag: ""),
            FLCountry(name: UBLocalized.country_serbia, code: "rs", flag: ""),
            FLCountry(name: UBLocalized.country_seychelles, code: "sc", flag: ""),
            FLCountry(name: UBLocalized.country_sierra_leone, code: "sl", flag: ""),
            FLCountry(name: UBLocalized.country_singapore, code: "sg", flag: ""),
            FLCountry(name: UBLocalized.country_sint_maarten, code: "sx", flag: ""),
            FLCountry(name: UBLocalized.country_slovakia, code: "sk", flag: ""),
            FLCountry(name: UBLocalized.country_slovenia, code: "si", flag: ""),
            FLCountry(name: UBLocalized.country_solomon_islands, code: "sb", flag: ""),
            FLCountry(name: UBLocalized.country_somalia, code: "so", flag: ""),
            FLCountry(name: UBLocalized.country_south_africa, code: "za", flag: ""),
            FLCountry(name: UBLocalized.country_south_korea, code: "kr", flag: ""),
            FLCountry(name: UBLocalized.country_south_sudan, code: "ss", flag: ""),
            FLCountry(name: UBLocalized.country_spain, code: "es", flag: ""),
            FLCountry(name: UBLocalized.country_sri_lanka, code: "lk", flag: ""),
            FLCountry(name: UBLocalized.country_sudan, code: "sd", flag: ""),
            FLCountry(name: UBLocalized.country_suriname, code: "sr", flag: ""),
            FLCountry(name: UBLocalized.country_swaziland, code: "sz", flag: ""),
            FLCountry(name: UBLocalized.country_sweden, code: "se", flag: ""),
            FLCountry(name: UBLocalized.country_switzerland, code: "ch", flag: ""),
            FLCountry(name: UBLocalized.country_syrian_arab_republic, code: "sy", flag: ""),
            FLCountry(name: UBLocalized.country_taiwan, code: "tw", flag: ""),
            FLCountry(name: UBLocalized.country_tajikistan, code: "tj", flag: ""),
            FLCountry(name: UBLocalized.country_tanzania, code: "tz", flag: ""),
            FLCountry(name: UBLocalized.country_thailand, code: "th", flag: ""),
            FLCountry(name: UBLocalized.country_timor, code: "tl", flag: ""),
            FLCountry(name: UBLocalized.country_togo, code: "tg", flag: ""),
            FLCountry(name: UBLocalized.country_tokelau, code: "tk", flag: ""),
            FLCountry(name: UBLocalized.country_tonga, code: "to", flag: ""),
            FLCountry(name: UBLocalized.country_trinidad_tobago, code: "tt", flag: ""),
            FLCountry(name: UBLocalized.country_tunisia, code: "tn", flag: ""),
            FLCountry(name: UBLocalized.country_turkey, code: "tr", flag: ""),
            FLCountry(name: UBLocalized.country_turkmenistan, code: "tm", flag: ""),
            FLCountry(name: UBLocalized.country_turks_and_caicos_islands, code: "tc", flag: ""),
            FLCountry(name: UBLocalized.country_tuvalu, code: "tv", flag: ""),
            FLCountry(name: UBLocalized.country_us_virgin_islands, code: "vi", flag: ""),
            FLCountry(name: UBLocalized.country_uganda, code: "ug", flag: ""),
            FLCountry(name: UBLocalized.country_ukraine, code: "ua", flag: ""),
            FLCountry(name: UBLocalized.country_united_arab_emirates, code: "ae", flag: ""),
            FLCountry(name: UBLocalized.country_united_kingdom, code: "gb", flag: ""),
            FLCountry(name: UBLocalized.country_united_states, code: "us", flag: ""),
            FLCountry(name: UBLocalized.country_uruguay, code: "uy", flag: ""),
            FLCountry(name: UBLocalized.country_uzbekistan, code: "uz", flag: ""),
            FLCountry(name: UBLocalized.country_vanuatu, code: "vu", flag: ""),
            FLCountry(name: UBLocalized.country_vatican, code: "va", flag: ""),
            FLCountry(name: UBLocalized.country_venezuela, code: "ve", flag: ""),
            FLCountry(name: UBLocalized.country_vietnam, code: "vn", flag: ""),
            FLCountry(name: UBLocalized.country_wallis_and_futuna, code: "wf", flag: ""),
            FLCountry(name: UBLocalized.country_western_sahara, code: "eh", flag: ""),
            FLCountry(name: UBLocalized.country_yemen, code: "ye", flag: ""),
            FLCountry(name: UBLocalized.country_zambia, code: "zm", flag: ""),
            FLCountry(name: UBLocalized.country_zimbabwe, code: "zw", flag: ""),
        ]
        
        return list.map { currentCountry in
            let newCountry = FLCountry(name: currentCountry.name, code: currentCountry.code, flag: getFlagFor(countryCode: currentCountry.code))
            return newCountry
        }
    }
    
    
    private func getFlagFor(countryCode: String?) -> String? {
        guard let countryCode = countryCode else { return nil }
        return getFlags()[countryCode.uppercased()]
    }
    
    private func getFlags() -> [String: String] {
    
       return [
          "AD": "🇦🇩", "AE": "🇦🇪", "AF": "🇦🇫", "AG": "🇦🇬", "AI": "🇦🇮", "AL": "🇦🇱", "AM": "🇦🇲", "AO": "🇦🇴", "AQ": "🇦🇶", "AR": "🇦🇷", "AS": "🇦🇸", "AT": "🇦🇹", "AU": "🇦🇺", "AW": "🇦🇼", "AX": "🇦🇽", "AZ": "🇦🇿", "BA": "🇧🇦", "BB": "🇧🇧", "BD": "🇧🇩", "BE": "🇧🇪", "BF": "🇧🇫", "BG": "🇧🇬", "BH": "🇧🇭", "BI": "🇧🇮", "BJ": "🇧🇯", "BL": "🇧🇱", "BM": "🇧🇲", "BN": "🇧🇳", "BO": "🇧🇴", "BQ": "🇧🇶", "BR": "🇧🇷", "BS": "🇧🇸", "BT": "🇧🇹", "BV": "🇧🇻", "BW": "🇧🇼", "BY": "🇧🇾", "BZ": "🇧🇿", "CA": "🇨🇦", "CC": "🇨🇨", "CD": "🇨🇩", "CF": "🇨🇫", "CG": "🇨🇬", "CH": "🇨🇭", "CI": "🇨🇮", "CK": "🇨🇰", "CL": "🇨🇱", "CM": "🇨🇲", "CN": "🇨🇳", "CO": "🇨🇴", "CR": "🇨🇷", "CU": "🇨🇺", "CV": "🇨🇻", "CW": "🇨🇼", "CX": "🇨🇽", "CY": "🇨🇾", "CZ": "🇨🇿", "DE": "🇩🇪", "DJ": "🇩🇯", "DK": "🇩🇰", "DM": "🇩🇲", "DO": "🇩🇴", "DZ": "🇩🇿", "EC": "🇪🇨", "EE": "🇪🇪", "EG": "🇪🇬", "EH": "🇪🇭", "ER": "🇪🇷", "ES": "🇪🇸", "ET": "🇪🇹", "FI": "🇫🇮", "FJ": "🇫🇯", "FK": "🇫🇰", "FM": "🇫🇲", "FO": "🇫🇴", "FR": "🇫🇷", "GA": "🇬🇦", "GB": "🇬🇧", "GD": "🇬🇩", "GE": "🇬🇪", "GF": "🇬🇫", "GG": "🇬🇬", "GH": "🇬🇭", "GI": "🇬🇮", "GL": "🇬🇱", "GM": "🇬🇲", "GN": "🇬🇳", "GP": "🇬🇵", "GQ": "🇬🇶", "GR": "🇬🇷", "GS": "🇬🇸", "GT": "🇬🇹", "GU": "🇬🇺", "GW": "🇬🇼", "GY": "🇬🇾", "HK": "🇭🇰", "HM": "🇭🇲", "HN": "🇭🇳", "HR": "🇭🇷", "HT": "🇭🇹", "HU": "🇭🇺", "ID": "🇮🇩", "IE": "🇮🇪", "IL": "🇮🇱", "IM": "🇮🇲", "IN": "🇮🇳", "IO": "🇮🇴", "IQ": "🇮🇶", "IR": "🇮🇷", "IS": "🇮🇸", "IT": "🇮🇹", "JE": "🇯🇪", "JM": "🇯🇲", "JO": "🇯🇴", "JP": "🇯🇵", "KE": "🇰🇪", "KG": "🇰🇬", "KH": "🇰🇭", "KI": "🇰🇮", "KM": "🇰🇲", "KN": "🇰🇳", "KP": "🇰🇵", "KR": "🇰🇷", "KW": "🇰🇼", "KY": "🇰🇾", "KZ": "🇰🇿", "LA": "🇱🇦", "LB": "🇱🇧", "LC": "🇱🇨", "LI": "🇱🇮", "LK": "🇱🇰", "LR": "🇱🇷", "LS": "🇱🇸", "LT": "🇱🇹", "LU": "🇱🇺", "LV": "🇱🇻", "LY": "🇱🇾", "MA": "🇲🇦", "MC": "🇲🇨", "MD": "🇲🇩", "ME": "🇲🇪", "MF": "🇲🇫", "MG": "🇲🇬", "MH": "🇲🇭", "MK": "🇲🇰", "ML": "🇲🇱", "MM": "🇲🇲", "MN": "🇲🇳", "MO": "🇲🇴", "MP": "🇲🇵", "MQ": "🇲🇶", "MR": "🇲🇷", "MS": "🇲🇸", "MT": "🇲🇹", "MU": "🇲🇺", "MV": "🇲🇻", "MW": "🇲🇼", "MX": "🇲🇽", "MY": "🇲🇾", "MZ": "🇲🇿", "NA": "🇳🇦", "NC": "🇳🇨", "NE": "🇳🇪", "NF": "🇳🇫", "NG": "🇳🇬", "NI": "🇳🇮", "NL": "🇳🇱", "NO": "🇳🇴", "NP": "🇳🇵", "NR": "🇳🇷", "NU": "🇳🇺", "NZ": "🇳🇿", "OM": "🇴🇲", "PA": "🇵🇦", "PE": "🇵🇪", "PF": "🇵🇫", "PG": "🇵🇬", "PH": "🇵🇭", "PK": "🇵🇰", "PL": "🇵🇱", "PM": "🇵🇲", "PN": "🇵🇳", "PR": "🇵🇷", "PS": "🇵🇸", "PT": "🇵🇹", "PW": "🇵🇼", "PY": "🇵🇾", "QA": "🇶🇦", "RE": "🇷🇪", "RO": "🇷🇴", "RS": "🇷🇸", "RU": "🇷🇺", "RW": "🇷🇼", "SA": "🇸🇦", "SB": "🇸🇧", "SC": "🇸🇨", "SD": "🇸🇩", "SE": "🇸🇪", "SG": "🇸🇬", "SH": "🇸🇭", "SI": "🇸🇮", "SJ": "🇸🇯", "SK": "🇸🇰", "SL": "🇸🇱", "SM": "🇸🇲", "SN": "🇸🇳", "SO": "🇸🇴", "SR": "🇸🇷", "SS": "🇸🇸", "ST": "🇸🇹", "SV": "🇸🇻", "SX": "🇸🇽", "SY": "🇸🇾", "SZ": "🇸🇿", "TC": "🇹🇨", "TD": "🇹🇩", "TF": "🇹🇫", "TG": "🇹🇬", "TH": "🇹🇭", "TJ": "🇹🇯", "TK": "🇹🇰", "TL": "🇹🇱", "TM": "🇹🇲", "TN": "🇹🇳", "TO": "🇹🇴", "TR": "🇹🇷", "TT": "🇹🇹", "TV": "🇹🇻", "TW": "🇹🇼", "TZ": "🇹🇿", "UA": "🇺🇦", "UG": "🇺🇬", "UM": "🇺🇲", "US": "🇺🇸", "UY": "🇺🇾", "UZ": "🇺🇿", "VA": "🇻🇦", "VC": "🇻🇨", "VE": "🇻🇪", "VG": "🇻🇬", "VI": "🇻🇮", "VN": "🇻🇳", "VU": "🇻🇺", "WF": "🇼🇫", "WS": "🇼🇸", "YE": "🇾🇪", "YT": "🇾🇹", "ZA": "🇿🇦", "ZM": "🇿🇲", "ZW": "🇿🇼"
        ]
        
    }
    
    
    
    
    
}
