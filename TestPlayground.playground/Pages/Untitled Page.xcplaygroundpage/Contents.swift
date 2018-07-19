import UIKit

var str = "Hello, playground"
var code = "EUR"
NSLocale.isoCurrencyCodes

Locale.isoRegionCodes
Locale.availableIdentifiers.map({ locale -> String in
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: locale)
    return numberFormatter.currencyCode
}).forEach { (symbol) in
    print(symbol)
}

