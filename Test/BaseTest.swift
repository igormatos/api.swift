import XCTest

class BaseTest : XCTestCase {

	var books = [[String: AnyObject]]()

	var booksToAdd = [
		["title": "Cien años de soledad"],
		["title": "Historias de cronopios y de famas"]
	]

	var pad: Launchpad!
	let path = "/books"
	let server = "http://localhost:8080"

	override func setUp() {
		pad = Launchpad(server: server)

		for bookToAdd in booksToAdd {
			let expectation = expect("setUp")

			pad.add(path, document: bookToAdd, success: { book in
				self.books.append(book)
				expectation.fulfill()
			})

			wait()
		}
	}

	override func tearDown() {
		for book in books {
			let expectation = expect("tearDown")
			let id = book["id"] as! String

			pad.remove(self.path, id: id, success: { status in
				expectation.fulfill()
			})

			wait()
		}
	}

	func assertBook(
		expected: [String: AnyObject], result: [String: AnyObject]) {

		XCTAssertEqual(
			expected["title"] as! String,
			result["document"]!["title"]!! as! String)
	}

	func assertBooks(
		expected: [[String: String]], result: [[String: AnyObject]]) {

		for (index, book) in enumerate(result) {
			assertBook(expected[index], result: book)
		}
	}

}
