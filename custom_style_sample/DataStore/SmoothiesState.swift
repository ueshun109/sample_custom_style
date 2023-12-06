import Observation

@Observable
final class SmoothiesState {
  var smoothies: LoadState<[String: [Smoothie]]> = .idle
  private let dataSource: SmoothieDataSource

  init(dataSource: SmoothieDataSource = .live) {
    self.dataSource = dataSource
  }

  func load() async {
    do {
      let response = try await dataSource.fetchSmoothies()
      // このあたりは適当な値をセット
      let sectionTitles = ["Tokyo", "Osaka", "Aichi", "Kyoto"]
      let sectionItems = [response, response, response, response]
      let value = Dictionary(uniqueKeysWithValues: zip(sectionTitles, sectionItems))
      self.smoothies = .success(value)
    } catch {
      self.smoothies = .failure(error)
    }
  }
}
