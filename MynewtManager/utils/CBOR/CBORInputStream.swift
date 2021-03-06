public protocol CBORInputStream {
	mutating func popByte() throws -> UInt8
	mutating func popBytes(_ n: Int) throws -> ArraySlice<UInt8>
}

// FUCK: https://openradar.appspot.com/23255436
internal struct ArraySliceUInt8 {
	var slice : ArraySlice<UInt8>
}

extension ArraySliceUInt8: CBORInputStream {

	mutating func popByte() throws -> UInt8 {
		if slice.count < 1 { throw CBORError.unfinishedSequence }
		return slice.removeFirst()
	}

	mutating func popBytes(_ n: Int) throws -> ArraySlice<UInt8> {
		if slice.count < n { throw CBORError.unfinishedSequence }
		let result = slice.prefix(n)
		slice = slice.dropFirst(n)
		return result
	}

}
