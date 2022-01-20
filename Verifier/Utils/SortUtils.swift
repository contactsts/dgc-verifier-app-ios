import Foundation


enum SortDiretion : String, GenericPickerEnum {
    case ascending = "SortAscending"
    case descending = "SortDescending"
}


// -----


protocol GenericPickerEnum : CaseIterable {
    
    func getTranslatedName() -> String
    func getGenericPickerItem() -> GenericPickerItem
    
    static func fromGenericPickerItem(genericPickerItem: GenericPickerItem) -> Self?
    static func getAsGeneriPickerItemsList() -> [GenericPickerItem]
}


extension GenericPickerEnum where Self : RawRepresentable, RawValue == String {
    
    func getTranslatedName() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    func getGenericPickerItem() -> GenericPickerItem {
        return GenericPickerItem(id: self.rawValue, title: NSLocalizedString(self.rawValue, comment: ""))
    }

    static func fromGenericPickerItem(genericPickerItem: GenericPickerItem) -> Self? {
        return Self.init(rawValue: genericPickerItem.id ?? "X")
    }

    static func getAsGeneriPickerItemsList() -> [GenericPickerItem] {
        return allCases.map { $0.getGenericPickerItem() }
    }
    
}





protocol ListFilterVMInput {
    associatedtype SortField: RawRepresentable where SortField.RawValue: StringProtocol
    
    var sortCriteria: SortField { get set }
    var sortDirection: SortDiretion { get set }
    
    var filtersCount: Int { get set }
    var sortText: String { get set }
}



