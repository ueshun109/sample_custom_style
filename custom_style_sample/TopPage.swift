import SwiftUI

struct TopPage: View {
  @State private var smoothiesState = SmoothiesState(dataSource: .live)

  var body: some View {
    NavigationStack {
      switch smoothiesState.smoothies {
      case .idle, .loading:
        list(["mock": .all])
          .task { await smoothiesState.load() }
          .redacted(reason: .placeholder)
          .disabled(true)
      case .success(let v):
        list(v)
      case .failure(let error):
        Text(error.localizedDescription)
      }
    }
    .navigationTitle("TOP")
  }

  /// 📚 スムージーの一覧
  func list(_ data: [String: [Smoothie]]) -> some View {
    let keys = data.map(\.key).sorted()
    let values = keys.compactMap { data[$0] }
    return GeometryReader { proxy in
      ScrollView {
        ForEach(keys.indices, id: \.self) { index in
          Section {
            sectionBody(values[index], width: proxy.size.width)
          } header: {
            NavigationLink {
              DetailedSmoothiesPage(smoothies: values[index])
            } label: {
              sectionHeader(keys[index])
            }
            .foregroundStyle(.primary)
          }
        }
      }
    }
  }

  /// 🎩 セクションタイトル
  func sectionHeader(_ title: String) -> some View {
    HStack {
      Text(title)
        .font(.title)
        .bold()

      Spacer()

      Label {
        Text("Detail")
      } icon: {
        Image(systemName: "chevron.right")
      }
      .labelStyle(.titleFirst)
    }
    .padding(.horizontal, 16)
  }

  /// 💪 セクションボディ
  func sectionBody(_ smoothies: [Smoothie], width: CGFloat) -> some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 24) {
        ForEach(Smoothie.all) { smoothie in
          SmoothieView(smoothie: smoothie, thumbnailSize: width / 3.89, onTap: {})
        }
        .smoothieStyle(.small)
      }
      .padding(.horizontal, 16)
    }
  }
}

#Preview {
  TopPage()
}

// MARK: - LabelStyle

extension LabelStyle where Self == TitleFirstLabelStyle {
  static var titleFirst: Self { TitleFirstLabelStyle() }
}

struct TitleFirstLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.title
      configuration.icon
    }
  }
}
