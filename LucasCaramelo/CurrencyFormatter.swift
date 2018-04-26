//
//  String+Decimal.swift
//  LucasCaramelo
//
//  Created by Usuário Convidado on 25/04/18.
//  Copyright © 2018 fiap. All rights reserved.
//

import Foundation

enum CurrencyLocale: String {
    case EN = "en_US"
    case BR = "pt_BR"
}

private func getCurrencyFormatter(_ locale: CurrencyLocale) -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: locale.rawValue)
    formatter.numberStyle = .currency
    return formatter
}

extension Double {
    func toCurrencyString(forLocale currencyLocale: CurrencyLocale = CurrencyLocale.EN, useSymbol: Bool = false) -> String? {
        let formatter = getCurrencyFormatter(currencyLocale)
        if !useSymbol {
            formatter.currencySymbol = ""
        }
        return formatter.string(from: self as NSNumber)
    }
}

extension String {
    func toCurrencyDouble(forLocale currencyLocale: CurrencyLocale = .EN, useSymbol: Bool = false) -> Double {
        let formatter = getCurrencyFormatter(currencyLocale)
        if !useSymbol {
            formatter.currencySymbol = ""
        }
        return formatter.number(from: self)?.doubleValue ?? 0
    }
}
