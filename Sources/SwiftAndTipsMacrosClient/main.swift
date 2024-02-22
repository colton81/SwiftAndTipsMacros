/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
*/

import SwiftAndTipsMacros
import Foundation
import DataGenerator

@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
public struct VINData: Codable,Identifiable, Hashable {
    public var id:UUID = .init()
    public var bodyClass: String
    public var displacementL: String
    public var doors: String
    public var engineCylinders: String
    public var engineHP: String
    
    public var engineManufacturer: String
    public var errorCode: String
    public var errorText: String
    public var fuelTypePrimary: String
    @SampleBuilderItem(category: .creditCardNumber)
    public var make: String
    
    @SampleBuilderItem(category: .firstName)
    public var manufacturer: String
    

    @SampleBuilderItem(category: .firstName)
    public var model: String
    public var modelID: String
    
    @SampleBuilderItem(category: .username)
    public var modelYear: String
    
    public var plantCity: String
    public var plantCompanyName: String
    public var plantCountry: String
    public var plantState: String
    public var series: String
    public var trim: String
    
    @SampleBuilderItem(category: .vin)
    public var vin: String
    
    public var vehicleType: String
    
    enum CodingKeys: String, CodingKey {
        case bodyClass = "BodyClass"
        case displacementL = "DisplacementL"
        case doors = "Doors"
        case engineCylinders = "EngineCylinders"
        case engineHP = "EngineHP"
        case engineManufacturer = "EngineManufacturer"
        case errorCode = "ErrorCode"
        case errorText = "ErrorText"
        case fuelTypePrimary = "FuelTypePrimary"
        case make = "Make"
        case manufacturer = "Manufacturer"
        case model = "Model"
        case modelID = "ModelID"
        case modelYear = "ModelYear"
        case plantCity = "PlantCity"
        case plantCompanyName = "PlantCompanyName"
        case plantCountry = "PlantCountry"
        case plantState = "PlantState"
        case series = "Series"
        case trim = "Trim"
        case vin = "VIN"
        case vehicleType = "VehicleType"
    }

    
}

extension VINData{
    public init(bodyClass: String = "", displacementL: String = "", doors: String = "", engineCylinders: String = "", engineHP: String = "", engineManufacturer: String = "", errorCode: String = "", errorText: String = "", fuelTypePrimary: String = "", make: String = "", manufacturer: String = "", model: String = "", modelID: String = "", modelYear: String = "", plantCity: String = "", plantCompanyName: String = "", plantCountry: String = "", plantState: String = "", series: String = "", trim: String = "", vin: String = "", vehicleType: String = "") {
        self.bodyClass = bodyClass
        self.displacementL = displacementL
        self.doors = doors
        self.engineCylinders = engineCylinders
        self.engineHP = engineHP
        self.engineManufacturer = engineManufacturer
        self.errorCode = errorCode
        self.errorText = errorText
        self.fuelTypePrimary = fuelTypePrimary
        self.make = make
        self.manufacturer = manufacturer
        self.model = model
        self.modelID = modelID
        self.modelYear = modelYear
        self.plantCity = plantCity
        self.plantCompanyName = plantCompanyName
        self.plantCountry = plantCountry
        self.plantState = plantState
        self.series = series
        self.trim = trim
        self.vin = vin
        self.vehicleType = vehicleType
    }
}


//@SampleBuilder(numberOfItems: 5)
//struct Person {
//    let id: UUID
//    let item1: String
//    let item2: Int
//    let item3: Bool
//    let item4: Data
//    let item5: Date
//    let item6: Double
//    let item7: Float
//    let item8: Int8
//    let item9: Int16
//    let item10: Int32
//    let item11: Int64
//    let item12: UInt8
//    let item13: UInt16
//    let item14: UInt32
//    let item15: UInt64
//    let item16: URL
//    let item17: CGPoint
//    let item18: CGFloat
//    let item19: CGRect
//    let item20: CGSize
//    let item21: CGVector
//}


//
//@SampleBuilder(numberOfItems: 10)
//struct Review {
//    let rating: Int
//    let time: Date
//    let product: Product
//}
//
//@SampleBuilder(numberOfItems: 3)
//struct Product {
//    var price: Int
//    var description: String
//    
////    init(price: Int) {
////        self.price = 0
////        self.description = ""
////    }
//}

//@SampleBuilder(numberOfItems: 3)
//struct Order {
//    var productList: [Product]
//    var address: String
//    var time: Date
//}

//@SampleBuilder(numberOfItems: 3)
//struct Example {
//    let x: Int
//    var y: String
//    
//    static var notAValidStoredProperty: Self {
//        .init(x: 0, y: "Hello World")
//    }
//    
//    var aComputedProperty: String {
//        "Hello"
//    }
//}


//@SampleBuilder(numberOfItems: 3)
//struct Example {
//    let x: Int
//    private var y: String {
//        didSet {
//            print("didSet called")
//        }
//        willSet {
//            print("willSet called")
//        }
//    }
//    static var asd: Self {
//        .init(x: 0, y: "Hello World")
//    }
//    var z: String {
//        get { y }
//    }
//    var w: String {
//        get {
//            y
//        }
//        set {
//            y = newValue
//        }
//    }
//}

//@SampleBuilder(numberOfItems: 3)
//struct Product {
//    var price: Int
//    var description: String
//    var dict1: [String: Int]
//    var dict2: [String: [Int]]
//    var dict3: [String: [String: Example]]
//}
//
//@SampleBuilder(numberOfItems: 3)
//struct Example {
//    let x: Int
//    let y: String
//    let myEnum: MyEnum
//}
//
//@SampleBuilder(numberOfItems: 20)
//struct Product {
//    var item1: Int
//    var item2: String
//}
//
//@SampleBuilder(numberOfItems: 6)
//enum MyEnum {
//    indirect case case1(String, Int, String, [String])
//    case case2
//    case case3(String, [Product])
//}



//
//@SampleBuilder(numberOfItems: 6)
//struct Test {
//    var item1: [[Int]: [[String: [String: [Int: [Int: MyEnum]]]]]]
//}






//@SampleBuilder(numberOfItems: 3)
//enum Example {
//    case response(time: Date, name: String, Data)
//}





















