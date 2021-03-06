//
//  RNMask.swift
//  InputMask
//
//  Created by Ivan Zotov on 8/4/17.
//  Copyright © 2017 Ivan Zotov. All rights reserved.
//

import Foundation

open class RNMask : NSObject {
    public static func maskValue(text: String, format: String, precision: Int) -> String {
        let strings = format.split(separator: "/").map(String.init)
        if "currency" == strings[0].lowercased() {
            let symbol = strings.count > 1 ? strings[1] : ""
            return text.currencyInputFormatting(showSymbol: symbol, precision: precision)
        }
        
        let mask : Mask = try! Mask.getOrCreate(withFormat: format, precision: precision)

        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex
            ),
            autocomplete: true
        )

        return result.formattedText.string
    }
    
    public static func unmaskValue(text: String, format: String) -> String {
        let mask : Mask = try! Mask.getOrCreate(withFormat: format, precision: 0)

        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: text,
                caretPosition: text.endIndex
            ),
            autocomplete: true
        )

        return result.extractedValue
    }
}
