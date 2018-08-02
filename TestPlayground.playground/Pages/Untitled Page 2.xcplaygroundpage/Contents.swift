//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
let dateFormatter = DateFormatter()
let date = Date(timeIntervalSinceReferenceDate: 410220000)

// US English Locale (en_US)
dateFormatter.locale = Locale(identifier: "hr_HR")
dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d") // set template after setting locale
//dateFormatter.dateStyle = .full
//dateFormatter.dateFormat = "EEEE, MMMM d."
print(dateFormatter.string(from: date))
