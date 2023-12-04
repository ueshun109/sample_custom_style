import SwiftUI

struct DetailedSmoothiesPage: View {
  let smoothies: [Smoothie]

  var body: some View {
    GeometryReader { proxy in
      List {
        ForEach(smoothies) { smoothie in
          SmoothieView(smoothie: smoothie, thumbnailSize: proxy.size.width - 32, onTap: {})
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
        .smoothieStyle(.large)
      }
      .listStyle(.plain)
    }
  }
}

#Preview {
  DetailedSmoothiesPage(smoothies: .all)
}
