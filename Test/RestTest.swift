import XCTest

class RestTest : BaseTest {

	func testAdd() {
		let expectation = expect("add")
		let bookToAdd = booksToAdd.first!

		pad.add(path, document: bookToAdd, success: { book in
			self.assertBook(bookToAdd, result: book)
			self.books.append(book)
			expectation.fulfill()
		})

		wait()
	}

	func testGet() {
		let expectation = expect("get")
		let id = books.first!["id"] as! String

		pad.get(path, id: id, success: { book in
			self.assertBook(self.booksToAdd.first!, result: book)
			expectation.fulfill()
		})

		wait()
	}

	func testList() {
		let expectation = expect("list")

		pad.list(path, success: { books in
			XCTAssertEqual(self.booksToAdd.count, books.count)
			self.assertBook(self.booksToAdd.first!, result: books.first!)
			expectation.fulfill()
		})

		wait()
	}

	func testRemove() {
		let expectation = expect("remove")
		let id = books.first!["id"] as! String

		pad.remove(path, id: id, success: { status in
			XCTAssertEqual(204, status)
			expectation.fulfill()
		})

		wait()
	}

	func testUpdate() {
		let expectation = expect("update")

		let book = books.first!
		var document = book["document"] as! [String: String]
		document["title"] = "La fiesta del chivo"

		let id = book["id"] as! String

		pad.update(path, id: id, document: document, success: { updatedBook in
			self.assertBook(document, result: updatedBook)
			expectation.fulfill()
		})

		wait()
	}

}