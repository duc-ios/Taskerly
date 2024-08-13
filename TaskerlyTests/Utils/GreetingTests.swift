//
//  GreetingTests.swift
//  TaskerlyTests
//
//  Created by Duc on 13/8/24.
//

@testable import Taskerly
import XCTest

final class GreetingTests: XCTestCase {
    var greeting: Greeting!

    override func setUpWithError() throws {
        greeting = Greeting()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMorning() throws {
        // given
        let date = Calendar.current.date(from: DateComponents(hour: 0))!

        // when
        let result = greeting.text(date: date)

        // then
        XCTAssertEqual(result, "Good Morning!")
    }

    func testAfternoon() throws {
        // given
        let date = Calendar.current.date(from: DateComponents(hour: 12))!

        // when
        let result = greeting.text(date: date)

        // then
        XCTAssertEqual(result, "Good Afternoon!")
    }

    func testNight() throws {
        // given
        let date = Calendar.current.date(from: DateComponents(hour: 17))!

        // when
        let result = greeting.text(date: date)

        // then
        XCTAssertEqual(result, "Good Evening!")
    }
}
