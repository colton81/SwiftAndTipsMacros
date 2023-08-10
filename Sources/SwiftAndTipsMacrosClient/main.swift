import SwiftAndTipsMacros
import Foundation

let x = #binaryString(10)

print(x)

@SampleBuilder(numberOfItems: 3)
struct Person {
    let id: UUID
    let item1: String
    let item2: Int
    let item3: Bool
    let item4: Data
    let item5: Date
    let item6: Double
    let item7: Float
    let item8: Int8
    let item9: Int16
    let item10: Int32
    let item11: Int64
    let item12: UInt8
    let item13: UInt16
    let item14: UInt32
    let item15: UInt64
    let item16: URL
    let item17: CGPoint
    let item18: CGFloat
    let item19: CGRect
    let item20: CGSize
    let item21: CGVector
}

