extension Datastore {

	public func add(path: String, document: AnyObject)
		-> Promise<[String: AnyObject]> {

		return Promise<[String: AnyObject]>(promise: { (fulfill, reject) in
			self.add(
				path, document: document, success: fulfill, failure: reject)
		})
	}

	public func get(path: String, id: String) -> Promise<[String: AnyObject]> {
		return Promise<[String: AnyObject]>(promise: { (fulfill, reject) in
			self.get(path, id: id, success: fulfill, failure: reject)
		})
	}

	public func get(path: String, query: Query? = nil)
		-> Promise<[[String: AnyObject]]> {

		return Promise<[[String: AnyObject]]>(promise: { (fulfill, reject) in
			self.get(path, query: query, success: fulfill, failure: reject)
		})
	}

	public func remove(path: String, id: String) -> Promise<Int> {
		return Promise<Int>(promise: { (fulfill, reject) in
			self.remove(path, id: id, success: fulfill, failure: reject)
		})
	}

	public func update(path: String, id: String, document: AnyObject)
		-> Promise<[String: AnyObject]> {

		return Promise<[String: AnyObject]>(promise: { (fulfill, reject) in
			self.update(
				path, id: id, document: document, success: fulfill,
				failure: reject)
		})
	}

}