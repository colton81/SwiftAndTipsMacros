/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
*/

//
//  SampleBuilderTests.swift
//  
//
//  Created by Pedro Rojas on 05/08/23.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(Macros)
import Macros

fileprivate let testMacros: [String: Macro.Type] = [
    "SampleBuilder": SampleBuilderMacro.self,
    "SampleBuilderItem": SampleBuilderItemMacro.self
]
#else
    //#error("Macros library is not running")
#endif


final class SampleBuilderTests: XCTestCase {
    // MARK: - Structs
    func testSampleBuilderMacro_Int_and_String() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Example {
                let x: Int
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let x: Int
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_supportedType() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
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
            """#,
            expandedSource: """
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
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(id: DataGenerator.default.uuid(), item1: DataGenerator.default.string(), item2: DataGenerator.default.int(), item3: DataGenerator.default.bool(), item4: DataGenerator.default.data(), item5: DataGenerator.default.date(), item6: DataGenerator.default.double(), item7: DataGenerator.default.float(), item8: DataGenerator.default.int8(), item9: DataGenerator.default.int16(), item10: DataGenerator.default.int32(), item11: DataGenerator.default.int64(), item12: DataGenerator.default.uint8(), item13: DataGenerator.default.uint16(), item14: DataGenerator.default.uint32(), item15: DataGenerator.default.uint64(), item16: DataGenerator.default.url(), item17: DataGenerator.default.cgpoint(), item18: DataGenerator.default.cgfloat(), item19: DataGenerator.default.cgrect(), item20: DataGenerator.default.cgsize(), item21: DataGenerator.default.cgvector()),
                        .init(id: DataGenerator.default.uuid(), item1: DataGenerator.default.string(), item2: DataGenerator.default.int(), item3: DataGenerator.default.bool(), item4: DataGenerator.default.data(), item5: DataGenerator.default.date(), item6: DataGenerator.default.double(), item7: DataGenerator.default.float(), item8: DataGenerator.default.int8(), item9: DataGenerator.default.int16(), item10: DataGenerator.default.int32(), item11: DataGenerator.default.int64(), item12: DataGenerator.default.uint8(), item13: DataGenerator.default.uint16(), item14: DataGenerator.default.uint32(), item15: DataGenerator.default.uint64(), item16: DataGenerator.default.url(), item17: DataGenerator.default.cgpoint(), item18: DataGenerator.default.cgfloat(), item19: DataGenerator.default.cgrect(), item20: DataGenerator.default.cgsize(), item21: DataGenerator.default.cgvector()),
                        .init(id: DataGenerator.default.uuid(), item1: DataGenerator.default.string(), item2: DataGenerator.default.int(), item3: DataGenerator.default.bool(), item4: DataGenerator.default.data(), item5: DataGenerator.default.date(), item6: DataGenerator.default.double(), item7: DataGenerator.default.float(), item8: DataGenerator.default.int8(), item9: DataGenerator.default.int16(), item10: DataGenerator.default.int32(), item11: DataGenerator.default.int64(), item12: DataGenerator.default.uint8(), item13: DataGenerator.default.uint16(), item14: DataGenerator.default.uint32(), item15: DataGenerator.default.uint64(), item16: DataGenerator.default.url(), item17: DataGenerator.default.cgpoint(), item18: DataGenerator.default.cgfloat(), item19: DataGenerator.default.cgrect(), item20: DataGenerator.default.cgsize(), item21: DataGenerator.default.cgvector()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSampleBuilderMacro_customStruct() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Review {
                let rating: Int
                let time: Date
                let product: Product
            }

            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Product {
                var price: Int
                var description: String
            }
            """#,
            expandedSource: """
            struct Review {
                let rating: Int
                let time: Date
                let product: Product
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(rating: DataGenerator.default.int(), time: DataGenerator.default.date(), product: Product.sample.first!),
                        .init(rating: DataGenerator.default.int(), time: DataGenerator.default.date(), product: Product.sample.first!),
                        .init(rating: DataGenerator.default.int(), time: DataGenerator.default.date(), product: Product.sample.first!),
                    ]
                }
                #endif
            }
            struct Product {
                var price: Int
                var description: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string()),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string()),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSampleBuilderMacro_array() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Product {
                var price: Int
                var description: String
                let array: [Int]
            }
            """#,
            expandedSource: """
            struct Product {
                var price: Int
                var description: String
                let array: [Int]
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), array: [DataGenerator.default.int()]),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), array: [DataGenerator.default.int()]),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), array: [DataGenerator.default.int()]),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_ignore_static_variable() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Example {
                let x: Int
                private var y: String
                static var asd: Self {
                    .init(x: 0, y: "Hello World")
                }
            }
            """#,
            expandedSource: """
            struct Example {
                let x: Int
                private var y: String
                static var asd: Self {
                    .init(x: 0, y: "Hello World")
                }
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSampleBuilderMacro_ignore_not_stored_properties() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Example {
                let x: Int
                private var y: String {
                    didSet {
                        print("didSet called")
                    }
                    willSet {
                        print("willSet called")
                    }
                }
                static var asd: Self {
                    .init(x: 0, y: "Hello World")
                }
                var z: String {
                    get { y }
                }
                var w: String {
                    get {
                        y
                    }
                    set {
                        y = newValue
                    }
                }
            }
            """#,
            expandedSource: """
            struct Example {
                let x: Int
                private var y: String {
                    didSet {
                        print("didSet called")
                    }
                    willSet {
                        print("willSet called")
                    }
                }
                static var asd: Self {
                    .init(x: 0, y: "Hello World")
                }
                var z: String {
                    get { y }
                }
                var w: String {
                    get {
                        y
                    }
                    set {
                        y = newValue
                    }
                }
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_struct_with_custom_init_one_parameter() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Product {
                var price: Int
                var description: String
            
                init(price: Int) {
                    self.price = price
                    self.description = ""
                }
            }
            """#,
            expandedSource: """
            struct Product {
                var price: Int
                var description: String
            
                init(price: Int) {
                    self.price = price
                    self.description = ""
                }
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.default.int()),
                        .init(price: DataGenerator.default.int()),
                        .init(price: DataGenerator.default.int()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_struct_with_custom_init_many_parameter() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Product {
                var price: Int
                var description: String
                var date: Date
                var id: UUID
            
                init(price: Int, date: Date) {
                    self.price = price
                    self.description = ""
                    self.date = date
                    self.id = UUID()
                }
            }
            """#,
            expandedSource: """
            struct Product {
                var price: Int
                var description: String
                var date: Date
                var id: UUID
            
                init(price: Int, date: Date) {
                    self.price = price
                    self.description = ""
                    self.date = date
                    self.id = UUID()
                }
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.default.int(), date: DataGenerator.default.date()),
                        .init(price: DataGenerator.default.int(), date: DataGenerator.default.date()),
                        .init(price: DataGenerator.default.int(), date: DataGenerator.default.date()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_struct_with_many_inits() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Product {
                var price: Int
                var description: String
                var date: Date
                var id: UUID
            
                init(price: Int, date: Date) {
                    self.price = price
                    self.description = ""
                    self.date = date
                    self.id = UUID()
                }
            
                init(price: Int, date: Date, id: UUID, description: String) {
                    self.price = price
                    self.description = description
                    self.date = date
                    self.id = id
                }
            }
            """#,
            expandedSource: """
            struct Product {
                var price: Int
                var description: String
                var date: Date
                var id: UUID
            
                init(price: Int, date: Date) {
                    self.price = price
                    self.description = ""
                    self.date = date
                    self.id = UUID()
                }
            
                init(price: Int, date: Date, id: UUID, description: String) {
                    self.price = price
                    self.description = description
                    self.date = date
                    self.id = id
                }
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.default.int(), date: DataGenerator.default.date(), id: DataGenerator.default.uuid(), description: DataGenerator.default.string()),
                        .init(price: DataGenerator.default.int(), date: DataGenerator.default.date(), id: DataGenerator.default.uuid(), description: DataGenerator.default.string()),
                        .init(price: DataGenerator.default.int(), date: DataGenerator.default.date(), id: DataGenerator.default.uuid(), description: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_dictionary_property() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Product {
                var price: Int
                var description: String
                var dict: [String: Int]
            }
            """#,
            expandedSource: """
            struct Product {
                var price: Int
                var description: String
                var dict: [String: Int]
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), dict: [DataGenerator.default.string(): DataGenerator.default.int()]),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), dict: [DataGenerator.default.string(): DataGenerator.default.int()]),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), dict: [DataGenerator.default.string(): DataGenerator.default.int()]),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_multiple_dictionary_properties() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Example {
                let x: Int
                let y: String
            }

            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Product {
                var price: Int
                var description: String
                var dict1: [String: Int]
                var dict2: [String: [Int]]
                var dict3: [String: [String: Example]]
            }
            """#,
            expandedSource: """
            struct Example {
                let x: Int
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            struct Product {
                var price: Int
                var description: String
                var dict1: [String: Int]
                var dict2: [String: [Int]]
                var dict3: [String: [String: Example]]
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), dict1: [DataGenerator.default.string(): DataGenerator.default.int()], dict2: [DataGenerator.default.string(): [DataGenerator.default.int()]], dict3: [DataGenerator.default.string(): [DataGenerator.default.string(): Example.sample.first!]]),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), dict1: [DataGenerator.default.string(): DataGenerator.default.int()], dict2: [DataGenerator.default.string(): [DataGenerator.default.int()]], dict3: [DataGenerator.default.string(): [DataGenerator.default.string(): Example.sample.first!]]),
                        .init(price: DataGenerator.default.int(), description: DataGenerator.default.string(), dict1: [DataGenerator.default.string(): DataGenerator.default.int()], dict2: [DataGenerator.default.string(): [DataGenerator.default.int()]], dict3: [DataGenerator.default.string(): [DataGenerator.default.string(): Example.sample.first!]]),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Optionals
    func testSampleBuilderMacro_optionals_supported_types() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
            struct Example {
                let item1: Int?
                let item2: String??
            }
            """#,
            expandedSource: """
            struct Example {
                let item1: Int?
                let item2: String??
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(item1: DataGenerator.random().int(), item2: DataGenerator.random().string()),
                        .init(item1: DataGenerator.random().int(), item2: DataGenerator.random().string()),
                        .init(item1: DataGenerator.random().int(), item2: DataGenerator.random().string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_optionals_supported_custom_types() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
            struct Example {
                let item1: Int?
                let item2: Product?
            }
            
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
            struct Product {
                var price: Int
                var description: String
            }
            """#,
            expandedSource: """
            struct Example {
                let item1: Int?
                let item2: Product?
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(item1: DataGenerator.random().int(), item2: Product.sample.first!),
                        .init(item1: DataGenerator.random().int(), item2: Product.sample.first!),
                        .init(item1: DataGenerator.random().int(), item2: Product.sample.first!),
                    ]
                }
                #endif
            }
            struct Product {
                var price: Int
                var description: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(price: DataGenerator.random().int(), description: DataGenerator.random().string()),
                        .init(price: DataGenerator.random().int(), description: DataGenerator.random().string()),
                        .init(price: DataGenerator.random().int(), description: DataGenerator.random().string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_optionals_nested() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
            struct Example {
                let item1: Int????????
            }
            """#,
            expandedSource: """
            struct Example {
                let item1: Int????????
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(item1: DataGenerator.random().int()),
                        .init(item1: DataGenerator.random().int()),
                        .init(item1: DataGenerator.random().int()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Enums
    func testSampleBuilderMacro_enum() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 5, dataGeneratorType: .default)
            enum MyEnum {
                case case1(String)
                case case2
                case case3(String)
            }
            """#,
            expandedSource: """
            enum MyEnum {
                case case1(String)
                case case2
                case case3(String)
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .case1(DataGenerator.default.string()),
                        .case2,
                        .case3(DataGenerator.default.string()),
                        .case1(DataGenerator.default.string()),
                        .case2,
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSampleBuilderMacro_enum_with_indirect_case() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            struct Example {
                let x: Int
                let y: String
                let myEnum: MyEnum
            }

            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .default)
            enum MyEnum {
                indirect case case1(String, Int, String, String, Example)
                case case2
                case case3(String)
            }
            """#,
            expandedSource: """
            struct Example {
                let x: Int
                let y: String
                let myEnum: MyEnum
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string(), myEnum: MyEnum.sample.first!),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string(), myEnum: MyEnum.sample.first!),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string(), myEnum: MyEnum.sample.first!),
                    ]
                }
                #endif
            }
            enum MyEnum {
                indirect case case1(String, Int, String, String, Example)
                case case2
                case case3(String)
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), DataGenerator.default.string(), Example.sample.first!),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSampleBuilderMacro_enum_with_arrays() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 6, dataGeneratorType: .default)
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
            }
            """#,
            expandedSource: """
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSampleBuilderMacro_enum_with_custom_associated_value() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 6, dataGeneratorType: .default)
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
                case case3(Product)
            }
            
            @SampleBuilder(numberOfItems: 2, dataGeneratorType: .default)
            struct Product {
                var item1: Int
                var item2: String
            }
            """#,
            expandedSource: """
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
                case case3(Product)
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                        .case3(Product.sample.first!),
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                        .case3(Product.sample.first!),
                    ]
                }
                #endif
            }
            struct Product {
                var item1: Int
                var item2: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(item1: DataGenerator.default.int(), item2: DataGenerator.default.string()),
                        .init(item1: DataGenerator.default.int(), item2: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSampleBuilderMacro_enum_with_dictionary() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 6, dataGeneratorType: .default)
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
                case case3(Product)
                case case4([String: Int])
            }
            
            @SampleBuilder(numberOfItems: 2, dataGeneratorType: .default)
            struct Product {
                var item1: Int
                var item2: String
            }
            """#,
            expandedSource: """
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
                case case3(Product)
                case case4([String: Int])
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                        .case3(Product.sample.first!),
                        .case4([DataGenerator.default.string(): DataGenerator.default.int()]),
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                    ]
                }
                #endif
            }
            struct Product {
                var item1: Int
                var item2: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(item1: DataGenerator.default.int(), item2: DataGenerator.default.string()),
                        .init(item1: DataGenerator.default.int(), item2: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Nested types
    func testSampleBuilderMacro_nested_arrays() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 6, dataGeneratorType: .default)
            struct Test {
                var item1: Int
                var item2: [[String]]
                var item3: [[[[Int]]]]
            }
            """#,
            expandedSource: """
            struct Test {
                var item1: Int
                var item2: [[String]]
                var item3: [[[[Int]]]]
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(item1: DataGenerator.default.int(), item2: [[DataGenerator.default.string()]], item3: [[[[DataGenerator.default.int()]]]]),
                        .init(item1: DataGenerator.default.int(), item2: [[DataGenerator.default.string()]], item3: [[[[DataGenerator.default.int()]]]]),
                        .init(item1: DataGenerator.default.int(), item2: [[DataGenerator.default.string()]], item3: [[[[DataGenerator.default.int()]]]]),
                        .init(item1: DataGenerator.default.int(), item2: [[DataGenerator.default.string()]], item3: [[[[DataGenerator.default.int()]]]]),
                        .init(item1: DataGenerator.default.int(), item2: [[DataGenerator.default.string()]], item3: [[[[DataGenerator.default.int()]]]]),
                        .init(item1: DataGenerator.default.int(), item2: [[DataGenerator.default.string()]], item3: [[[[DataGenerator.default.int()]]]]),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_nested_dictionaries() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 6, dataGeneratorType: .default)
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
                case case3(Product)
                case case4([String: Product])
            }

            @SampleBuilder(numberOfItems: 6, dataGeneratorType: .default)
            struct Test {
                var item1: [[Int]: [[String: [String: [Int: [Int: MyEnum]]]]]]
            }
            """#,
            expandedSource: """
            enum MyEnum {
                indirect case case1(String, Int, String, [String])
                case case2
                case case3(Product)
                case case4([String: Product])
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                        .case3(Product.sample.first!),
                        .case4([DataGenerator.default.string(): Product.sample.first!]),
                        .case1(DataGenerator.default.string(), DataGenerator.default.int(), DataGenerator.default.string(), [DataGenerator.default.string()]),
                        .case2,
                    ]
                }
                #endif
            }
            struct Test {
                var item1: [[Int]: [[String: [String: [Int: [Int: MyEnum]]]]]]
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(item1: [[DataGenerator.default.int()]: [[DataGenerator.default.string(): [DataGenerator.default.string(): [DataGenerator.default.int(): [DataGenerator.default.int(): MyEnum.sample.first!]]]]]]),
                        .init(item1: [[DataGenerator.default.int()]: [[DataGenerator.default.string(): [DataGenerator.default.string(): [DataGenerator.default.int(): [DataGenerator.default.int(): MyEnum.sample.first!]]]]]]),
                        .init(item1: [[DataGenerator.default.int()]: [[DataGenerator.default.string(): [DataGenerator.default.string(): [DataGenerator.default.int(): [DataGenerator.default.int(): MyEnum.sample.first!]]]]]]),
                        .init(item1: [[DataGenerator.default.int()]: [[DataGenerator.default.string(): [DataGenerator.default.string(): [DataGenerator.default.int(): [DataGenerator.default.int(): MyEnum.sample.first!]]]]]]),
                        .init(item1: [[DataGenerator.default.int()]: [[DataGenerator.default.string(): [DataGenerator.default.string(): [DataGenerator.default.int(): [DataGenerator.default.int(): MyEnum.sample.first!]]]]]]),
                        .init(item1: [[DataGenerator.default.int()]: [[DataGenerator.default.string(): [DataGenerator.default.string(): [DataGenerator.default.int(): [DataGenerator.default.int(): MyEnum.sample.first!]]]]]]),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Errors In Classes
    func testSampleBuilderMacro_error_classes() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .default)
            class MyClass {
                
            }
            """#,
            expandedSource: """
            class MyClass {
                
            }
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "@SampleBuilder can only be applied to Structs and Enums",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Errors In Number of Items Parameter
    func testSampleBuilderMacro_error_numberOfItems_equal_to_zero() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 0, dataGeneratorType: .default)
            struct Example {
                let item: Int
            }
            """#,
            expandedSource: """
            struct Example {
                let item: Int
            }
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "'numberOfitems' argument must be greater than zero",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_error_numberOfItems_less_than_zero() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: -1, dataGeneratorType: .default)
            struct Example {
                let item: Int
            }
            """#,
            expandedSource: """
            struct Example {
                let item: Int
            }
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "'numberOfitems' argument must be greater than zero",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Errors in Enums
    func testSampleBuilderMacro_error_enum_with_no_cases() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 5, dataGeneratorType: .default)
            enum Example {
            }
            """#,
            expandedSource: """
            enum Example {
            }
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "Enum must contain at least one case",
                    line: 1,
                    column: 1,
                    fixIts: [FixItSpec(message: "add a new enum case")]
                )
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_error_enum_with_associated_values_and_argument_names() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            enum Example {
                case response(time: Date, name: String, Data)
            }
            """#,
            expandedSource: """
            enum Example {
                case response(time: Date, name: String, Data)
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .response(time: DataGenerator.default.date(), name: DataGenerator.default.string(), DataGenerator.default.data()),
                        .response(time: DataGenerator.default.date(), name: DataGenerator.default.string(), DataGenerator.default.data()),
                        .response(time: DataGenerator.default.date(), name: DataGenerator.default.string(), DataGenerator.default.data()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Multiple Attributes
    func testSampleBuilderMacro_multiple_attributes_in_struct() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @OneAttribute(data: Data())
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .default)
            @AnotherAttribute(data: Data())
            struct Example {
                let x: Int
                let y: String
            }
            """#,
            expandedSource: """
            @OneAttribute(data: Data())
            @AnotherAttribute(data: Data())
            struct Example {
                let x: Int
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                        .init(x: DataGenerator.default.int(), y: DataGenerator.default.string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_multiple_attributes_in_property() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
            struct Example {
                let x: Int
                @MyAttribute
                @SampleBuilderItem(category: .email)
                @AnotherAttribute(date: Date())
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let x: Int
                @MyAttribute
                @AnotherAttribute(date: Date())
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(x: DataGenerator.random().int(), y: DataGenerator.random(dataCategory: .init(rawValue: "email")).string()),
                        .init(x: DataGenerator.random().int(), y: DataGenerator.random(dataCategory: .init(rawValue: "email")).string()),
                        .init(x: DataGenerator.random().int(), y: DataGenerator.random(dataCategory: .init(rawValue: "email")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: - Random Generator
    func testSampleBuilderMacro_random_generator_email_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .email)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "email")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_firsName_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .firstName)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "firstName")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_lastName_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .lastName)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "lastName")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_address_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .address)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "address")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_appVersion_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .appVersion)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "appVersion")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_creditCardNumber_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .creditCardNumber)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "creditCardNumber")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_companyName_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .companyName)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "companyName")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_username_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .username)
                let y: String
            }
            """#,
            expandedSource: """
            struct Example {
                let y: String
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "username")).string()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_price_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .price)
                let y: Double
            }
            """#,
            expandedSource: """
            struct Example {
                let y: Double
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "price")).double()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_url_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .url)
                let y: URL
            }
            """#,
            expandedSource: """
            struct Example {
                let y: URL
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "url")).url()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    func testSampleBuilderMacro_random_generator_image_category() throws{
        #if canImport(Macros)
        assertMacroExpansion(
            #"""
            @SampleBuilder(numberOfItems: 1, dataGeneratorType: .random)
            struct Example {
                @SampleBuilderItem(category: .image(width: 243, height: 123))
                let y: URL
            }
            """#,
            expandedSource: """
            struct Example {
                let y: URL
            
                #if DEBUG
                static var sample: [Self] {
                    [
                        .init(y: DataGenerator.random(dataCategory: .init(rawValue: "image(width:243,height:123)")).url()),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
