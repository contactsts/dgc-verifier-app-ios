//
//  ColorUtils.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 01/08/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import UIKit

enum MaterialColorNames : String {
    case red, green, yellow, pink, indigo, cyan, brown, purple, blue, orange, gray, black, white
}

enum MaterialColorShades : String {
    case shade100 = "100", shade300 = "300", shade500 = "500", shade700 = "700", shade900 = "900"
}

public struct MaterialColor : Equatable {
    var name: MaterialColorNames
    var shade: MaterialColorShades
    var color: UIColor
    
    var dispalyName: String {
        return "\(name.rawValue)\n\(shade.rawValue)"
    }
    
}

class MaterialColorsManager {
    
    static var red100 = MaterialColor(name: .red, shade: .shade100, color: UIColor.init(hexString: "#FFCDD2"))
    static var red300 = MaterialColor(name: .red, shade: .shade300, color: UIColor.init(hexString: "#E57373"))
    static var red500 = MaterialColor(name: .red, shade: .shade500, color: UIColor.init(hexString: "#F44336"))
    static var red700 = MaterialColor(name: .red, shade: .shade700, color: UIColor.init(hexString: "#D32F2F"))
    static var red900 = MaterialColor(name: .red, shade: .shade900, color: UIColor.init(hexString: "#B71C1C"))
    
    static var green100 = MaterialColor(name: .green, shade: .shade100, color: UIColor.init(hexString: "#C8E6C9"))
    static var green300 = MaterialColor(name: .green, shade: .shade300, color: UIColor.init(hexString: "#81C784"))
    static var green500 = MaterialColor(name: .green, shade: .shade500, color: UIColor.init(hexString: "#4CAF50"))
    static var green700 = MaterialColor(name: .green, shade: .shade700, color: UIColor.init(hexString: "#388E3C"))
    static var green900 = MaterialColor(name: .green, shade: .shade900, color: UIColor.init(hexString: "#1B5E20"))
    
    static var yellow100 = MaterialColor(name: .yellow, shade: .shade100, color: UIColor.init(hexString: "#FFF9C4"))
    static var yellow300 = MaterialColor(name: .yellow, shade: .shade300, color: UIColor.init(hexString: "#FFF176"))
    static var yellow500 = MaterialColor(name: .yellow, shade: .shade500, color: UIColor.init(hexString: "#FFEB3B"))
    static var yellow700 = MaterialColor(name: .yellow, shade: .shade700, color: UIColor.init(hexString: "#FBC02D"))
    static var yellow900 = MaterialColor(name: .yellow, shade: .shade900, color: UIColor.init(hexString: "#F57F17"))
    
    static var pink100 = MaterialColor(name: .pink, shade: .shade100, color: UIColor.init(hexString: "#F8BBD0"))
    static var pink300 = MaterialColor(name: .pink, shade: .shade300, color: UIColor.init(hexString: "#F06292"))
    static var pink500 = MaterialColor(name: .pink, shade: .shade500, color: UIColor.init(hexString: "#E91E63"))
    static var pink700 = MaterialColor(name: .pink, shade: .shade700, color: UIColor.init(hexString: "#C2185B"))
    static var pink900 = MaterialColor(name: .pink, shade: .shade900, color: UIColor.init(hexString: "#880E4F"))
    
    
    static var indigo100 = MaterialColor(name: .indigo, shade: .shade100, color: UIColor.init(hexString: "#C5CAE9"))
    static var indigo300 = MaterialColor(name: .indigo, shade: .shade300, color: UIColor.init(hexString: "#7986CB"))
    static var indigo500 = MaterialColor(name: .indigo, shade: .shade500, color: UIColor.init(hexString: "#3F51B5"))
    static var indigo700 = MaterialColor(name: .indigo, shade: .shade700, color: UIColor.init(hexString: "#303F9F"))
    static var indigo900 = MaterialColor(name: .indigo, shade: .shade900, color: UIColor.init(hexString: "#1A237E"))
    
    
    static var cyan100 = MaterialColor(name: .cyan, shade: .shade100, color: UIColor.init(hexString: "#B2EBF2"))
    static var cyan300 = MaterialColor(name: .cyan, shade: .shade300, color: UIColor.init(hexString: "#4DD0E1"))
    static var cyan500 = MaterialColor(name: .cyan, shade: .shade500, color: UIColor.init(hexString: "#00BCD4"))
    static var cyan700 = MaterialColor(name: .cyan, shade: .shade700, color: UIColor.init(hexString: "#0097A7"))
    static var cyan900 = MaterialColor(name: .cyan, shade: .shade900, color: UIColor.init(hexString: "#006064"))
    
    static var brown100 = MaterialColor(name: .brown, shade: .shade100, color: UIColor.init(hexString: "#D7CCC8"))
    static var brown300 = MaterialColor(name: .brown, shade: .shade300, color: UIColor.init(hexString: "#A1887F"))
    static var brown500 = MaterialColor(name: .brown, shade: .shade500, color: UIColor.init(hexString: "#795548"))
    static var brown700 = MaterialColor(name: .brown, shade: .shade700, color: UIColor.init(hexString: "#5D4037"))
    static var brown900 = MaterialColor(name: .brown, shade: .shade900, color: UIColor.init(hexString: "#3E2723"))
    
    static var purple100 = MaterialColor(name: .purple, shade: .shade100, color: UIColor.init(hexString: "#E1BEE7"))
    static var purple300 = MaterialColor(name: .purple, shade: .shade300, color: UIColor.init(hexString: "#BA68C8"))
    static var purple500 = MaterialColor(name: .purple, shade: .shade500, color: UIColor.init(hexString: "#9C27B0"))
    static var purple700 = MaterialColor(name: .purple, shade: .shade700, color: UIColor.init(hexString: "#7B1FA2"))
    static var purple900 = MaterialColor(name: .purple, shade: .shade900, color: UIColor.init(hexString: "#4A148C"))
    
    static var blue100 = MaterialColor(name: .blue, shade: .shade100, color: UIColor.init(hexString: "#BBDEFB"))
    static var blue300 = MaterialColor(name: .blue, shade: .shade300, color: UIColor.init(hexString: "#64B5F6"))
    static var blue500 = MaterialColor(name: .blue, shade: .shade500, color: UIColor.init(hexString: "#2196F3"))
    static var blue700 = MaterialColor(name: .blue, shade: .shade700, color: UIColor.init(hexString: "#1976D2"))
    static var blue900 = MaterialColor(name: .blue, shade: .shade900, color: UIColor.init(hexString: "#0D47A1"))
    
    
    static var orange100 = MaterialColor(name: .orange, shade: .shade100, color: UIColor.init(hexString: "#FFE0B2"))
    static var orange300 = MaterialColor(name: .orange, shade: .shade300, color: UIColor.init(hexString: "#FFB74D"))
    static var orange500 = MaterialColor(name: .orange, shade: .shade500, color: UIColor.init(hexString: "#FF9800"))
    static var orange700 = MaterialColor(name: .orange, shade: .shade700, color: UIColor.init(hexString: "#F57C00"))
    static var orange900 = MaterialColor(name: .orange, shade: .shade900, color: UIColor.init(hexString: "#E65100"))
    
    static var gray100 = MaterialColor(name: .gray, shade: .shade100, color: UIColor.init(hexString: "#F5F5F5"))
    static var gray300 = MaterialColor(name: .gray, shade: .shade300, color: UIColor.init(hexString: "#E0E0E0"))
    static var gray500 = MaterialColor(name: .gray, shade: .shade500, color: UIColor.init(hexString: "#9E9E9E"))
    static var gray700 = MaterialColor(name: .gray, shade: .shade700, color: UIColor.init(hexString: "#616161"))
    static var gray900 = MaterialColor(name: .gray, shade: .shade900, color: UIColor.init(hexString: "#212121"))
    
    static var black500 = MaterialColor(name: .white, shade: .shade500, color: UIColor.init(hexString: "#000000"))
    static var white500 = MaterialColor(name: .black, shade: .shade500, color: UIColor.init(hexString: "#ffffff"))
    
    
    
    
    static var colorsList : [MaterialColor] = [
        red100, red300, red500, red700, red900,
        green100, green300, green500, green700, green900,
        yellow100, yellow300, yellow500, yellow700, yellow900,
        pink100, pink300, pink500, pink700, pink900,
        indigo100, indigo300, indigo500, indigo700, indigo900,
        cyan100, cyan300, cyan500, cyan700, cyan900,
        brown100, brown300, brown500, brown700, brown900,
        purple100, purple300, purple500, purple700, purple900,
        blue100, blue300, blue500, blue700, blue900,
        orange100, orange300, orange500, orange700, orange900,
        gray100, gray300, gray500, gray700, gray900,
        black500, white500
    ]
    
    
    static func getMaterialColor(fromColor: UIColor) -> MaterialColor? {
        return colorsList.first { (materialColor) -> Bool in
            return materialColor.color === fromColor
        }
    }
    
    static func getMaterialColor(fromColorString: String?) -> MaterialColor? {
        guard let fromColorString = fromColorString else {
            return nil
        }
        return colorsList.first { (materialColor) -> Bool in
            return materialColor.color.toHexString() == fromColorString
        }
    }
    
    
    
    
}
