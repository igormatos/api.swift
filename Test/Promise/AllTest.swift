import XCTest

class AllTest : XCTestCase {

	func testAll() {
		let expectation = expect("testAll")
		var output = [Any?]()

		let p = Promise {
			return "one"
		}
		.all(
			{ value in
				XCTAssertEqual("one", value)
				return "two"
			},
			{ value in
				XCTAssertEqual("one", value)
				return "three"
			}
		)

		p.done { value, error in
			output = value!
			XCTAssertNil(error)
			expectation.fulfill()
		}

		wait {
			XCTAssertEqual(2, output.count)
			XCTAssertEqual("two", output.first! as? String)
			XCTAssertEqual("three", output.last! as? String)
		}
	}

}