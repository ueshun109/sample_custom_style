enum SmoothieDataSource {
  case live
  case failed

  func fetchSmoothies() async throws -> [Smoothie] {
    switch self {
    case .live:
      try? await Task.sleep(nanoseconds: 1_000_000_000)
      return .all
    case .failed:
      throw "error"
    }
  }
}

extension String: Error {}
