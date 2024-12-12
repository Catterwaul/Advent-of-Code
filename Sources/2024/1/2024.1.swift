@preconcurrency import Metal
import MetalZoon

public func stuff() async {
  let device: MTLDevice = .default

  let kernelPSO = try! await device.makeComputePipelineState(
    function: (.default(bundle: .module) as MTLLibrary).makeFunction(name: "inOutExample")!
  )

  let commandQueue = device.makeCommandQueue()!
  var array = Array(1...100)
  let length = MemoryLayout<Int>.stride * array.count
  let inBuf = device.makeBuffer(bytesNoCopy: &array, length: length)!
  let outBuf = device.makeBuffer(length: length, options: .storageModeShared)!

  let commandBuffer = commandQueue.makeCommandBuffer()!
  let computeEncoder = commandBuffer.makeComputeCommandEncoder()!
  computeEncoder.setComputePipelineState(kernelPSO)
  computeEncoder.setBuffer(inBuf, offset: 0, index: 0)
  computeEncoder.setBuffer(outBuf, offset: 0, index: 1)

  computeEncoder.dispatchThreads(
    .init(width: array.count, height: 1, depth: 1),
    threadsPerThreadgroup: .init(width: kernelPSO.threadExecutionWidth, height: 1, depth: 1)
  )

  computeEncoder.endEncoding()
  await commandBuffer.complete()


  let resultPointer = outBuf.contents().bindMemory(to: Int.self, capacity: array.count)
  let a = Array(
    UnsafeBufferPointer(start: resultPointer, count: array.count)
  )

  print(a)
}



import protocol Foundation.ContiguousBytes

public extension ContiguousBytes {
  func load<T>(_: T.Type = T.self) -> T {
    withUnsafeBytes { $0.load(as: T.self) }
  }

  func load<Element>(_: [Element].Type = [_].self) -> [Element] {
    withUnsafeBytes {
      $0.withMemoryRebound(to: Element.self, Array.init)
    }
  }
}

public extension Sequence {
  func totalDistance<String: StringProtocol>() -> Int where Element == [String] {
    func sortedList(_ index: Int) -> some Sequence<Int> {
      map { .init($0[index])! }.sorted()
    }

    return zip(sortedList(0), sortedList(1)).reduce(0) {
      $0 + abs($1.1 - $1.0)
    }
  }
}
