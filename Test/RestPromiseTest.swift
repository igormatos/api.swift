import XCTest

class RestPromiseTest : BaseTest {

	func testAdd_Then_Update_Then_Remove() {
		let expectation = expectationWithDescription("add")
		var bookToAdd = booksToAdd.first!

		pad.add(path, document: bookToAdd)
		.then { (book) -> (Promise<[String: AnyObject]>) in
			self.assertBook(bookToAdd, result: book)
			self.books.append(book)
			bookToAdd["title"] = "La fiesta del chivo"

			return self.pad.update(
				self.path, id: book["id"]! as! String, document: bookToAdd)
		}
		.then { (updatedBook) -> (Promise<Int>) in
			self.assertBook(bookToAdd, result: updatedBook)
			let id = updatedBook["id"]! as! String

			return self.pad.remove(self.path, id: id)
		}
		.then { (status) -> () in
			XCTAssertEqual(204, status)
			expectation.fulfill()
		}
		.done()

		wait()
	}

	func testAdd() {
		let expectation = expectationWithDescription("add")
		let bookToAdd = booksToAdd.first!

		pad.add(path, document: bookToAdd).then { (book) -> () in
			self.assertBook(bookToAdd, result: book)
			self.books.append(book)
			expectation.fulfill()
		}
		.done()

		wait()
	}

	func testGet() {
		let expectation = expectationWithDescription("get")
		let id = books.first!["id"] as! String

		pad.get(path, id: id).then { (book) -> () in
			self.assertBook(self.booksToAdd.first!, result: book)
			expectation.fulfill()
		}
		.done()

		wait()
	}

	func testList() {
		let expectation = expectationWithDescription("list")

		pad.list(path).then { (books) -> () in
			XCTAssertEqual(self.booksToAdd.count, books.count)
			self.assertBook(self.booksToAdd.first!, result: books.first!)
			expectation.fulfill()
		}
		.done()

		wait()
	}

	func testRemove() {
		let expectation = expectationWithDescription("remove")
		let id = books.first!["id"] as! String

		pad.remove(path, id: id).then { (status) -> () in
			XCTAssertEqual(204, status)
			expectation.fulfill()
		}
		.done()

		wait()
	}

	func testUpdate() {
		let expectation = expectationWithDescription("update")

		let book = books.first!
		var document = book["document"] as! [String: String]
		document["title"] = "La fiesta del chivo"

		let id = book["id"] as! String

		pad.update(path, id: id, document: document).then { updatedBook -> () in
			self.assertBook(document, result: updatedBook)
			expectation.fulfill()
		}
		.done()

		wait()
	}

}