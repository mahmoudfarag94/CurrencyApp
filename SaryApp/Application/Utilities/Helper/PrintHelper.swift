//
//  PrintHelper.swift
//  SaryAPP
//
//  Created by Mahmoud Farag.
//

import Foundation


func NetworkLogger<T>(_ items: T, separator: String = " ", terminator: String = "\n") {
    print("""
            \n===================== 📢 =========================
            \(items)
            ======================= 🚀  =========================
            """, separator: separator, terminator: terminator)
}
