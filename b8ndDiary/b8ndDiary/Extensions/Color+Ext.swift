//
//  Color+ext.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI
extension Color {
    
    init(_ hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

enum Colors {
    case red1
    case Black1
    case Blue1
    case Blue2
    case Blue3
    case Blue4
    case Blue5
    case Gray1
    case Gray2
    case Gray3
    case Yellow1
    
    var color: Color {
        switch self {
        case .red1:
            return Color(0xCE0000)
        case .Black1:
            return Color(0x000000)
        case .Blue1:
            return Color(0xE3F2FD)
        case .Blue2:
            return Color(0xB6E0FF)
        case .Blue3:
            return Color(0x93C2E4)
        case .Blue4:
            return Color(0x0083EC)
        case .Blue5:
            return Color(0x4B5568)
        case .Gray1:
            return Color(0xF4F4F4)
        case .Gray2:
            return Color(0xD9D9D9)
        case .Gray3:
            return Color(0x727272)
        case .Yellow1:
            return Color(0xFEEF9F)
        }
    }
}

extension Color {
    private static let skyBlue = "skyBlue"
    private static let yellow = "yellow"
    private static let blue = "blue"
    private static let darkBlue = "darkBlue"
    
    static func fromString(_ s: String) -> Color {
        switch s {
        case skyBlue:
            return Colors.Blue1.color
        case yellow:
            return Colors.Yellow1.color
        case blue:
            return Colors.Blue2.color
        case darkBlue:
            return Colors.Blue3.color
        default:
            return Colors.Blue1.color
        }
    }
    
    static func toString(_ c: Color) -> String {
        switch c {
        case Colors.Blue1.color:
            return skyBlue
        case Colors.Yellow1.color:
            return yellow
        case Colors.Blue2.color:
            return blue
        case Colors.Blue3.color:
            return darkBlue
        default:
            return skyBlue
        }
    }
}
