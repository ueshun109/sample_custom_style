import SwiftUI

// MARK: - SmoothieStyleConfiguration

struct SmoothieStyleConfiguration {
  /// スムージー情報
  let smoothie: Smoothie
  /// サムネイルサイズ
  let thumbnailSize: CGFloat
  /// アイテムをタップしたときのコールバック
  let onTap: () -> Void
}

// MARK: - SmoothieStyle

protocol SmoothieStyle {
  associatedtype Body: View
  @ViewBuilder func makeBody(configuration: SmoothieStyleConfiguration) -> Body
}

extension SmoothieStyle where Self == SmallSmoothieStyle {
  static var small: Self { Self() }
}

extension SmoothieStyle where Self == LargeSmoothieStyle {
  static var large: Self { Self() }
}

// MARK: - SmoothieStyleEnvironmentKey

struct SmoothieStyleEnvironmentKey: EnvironmentKey {
  static var defaultValue: any SmoothieStyle = SmallSmoothieStyle()
}

extension EnvironmentValues {
  var smoothieStyle: any SmoothieStyle {
    get {
      self[SmoothieStyleEnvironmentKey.self]
    }
    set {
      self[SmoothieStyleEnvironmentKey.self] = newValue
    }
  }
}

extension View {
  func smoothieStyle(_ style: some SmoothieStyle) -> some View {
    self.environment(\.smoothieStyle, style)
  }
}

// MARK: - SmoothieView

struct SmoothieView: View {
  @Environment(\.smoothieStyle) private var style
  let smoothie: Smoothie
  let thumbnailSize: CGFloat
  let onTap: () -> Void

  var body: some View {
    let configuration = SmoothieStyleConfiguration(
      smoothie: smoothie,
      thumbnailSize: thumbnailSize,
      onTap: onTap
    )
    AnyView(style.makeBody(configuration: configuration))
  }
}

// MARK: - SmallSmoothieStyle

struct SmallSmoothieStyle: SmoothieStyle {
  func makeBody(configuration: SmoothieStyleConfiguration) -> some View {
    VStack(spacing: 8) {
      thumbnail(configuration.smoothie.id, size: configuration.thumbnailSize)
        .frame(width: configuration.thumbnailSize, height: configuration.thumbnailSize)
        .clipShape(.circle)
      title(configuration.smoothie.title, font: .subheadline)
        .lineLimit(2, reservesSpace: true)
    }
    .frame(width: configuration.thumbnailSize)
  }
}

// MARK: - LargeSmoothieStyle

struct LargeSmoothieStyle: SmoothieStyle {
  func makeBody(configuration: SmoothieStyleConfiguration) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      thumbnail(configuration.smoothie.id, size: configuration.thumbnailSize)
        .frame(height: configuration.thumbnailSize * 0.64)
        .clipShape(.rect)
      title(configuration.smoothie.title, font: .title3)
      description(configuration.smoothie.description, font: .caption)
      price(configuration.smoothie.price, font: .subheadline)
    }
  }
}

/// 🖼 サムネイル
private func thumbnail(_ id: String, size: CGFloat) -> some View {
  Image("smoothie/\(id)")
    .resizable()
    .scaledToFill()
}

/// 👑 スムージーのタイトル
private func title(_ text: String, font: Font) -> some View {
  Text(text)
    .font(font)
    .foregroundStyle(.black)
}

/// 📝 スムージの詳細
private func description(_ text: String, font: Font) -> some View {
  Text(text)
    .font(font)
    .foregroundStyle(.gray)
}

/// 💰価格
private func price(_ value: Int, font: Font) -> some View {
  Text(value, format: .currency(code: "JPY"))
    .font(font)
    .foregroundStyle(.black)
}

// MARK: - Previews

#Preview {
  GeometryReader { proxy in
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        Text("Small smoothie style")
          .font(.title)
          .bold()
          .padding(.horizontal, 16)

        ScrollView(.horizontal) {
          LazyHStack(spacing: 8) {
            ForEach(Smoothie.all) { smoothie in
              SmoothieView(smoothie: smoothie, thumbnailSize: proxy.size.width / 3.89, onTap: {})
            }
            .smoothieStyle(.small)
          }
          .padding(.horizontal, 16)
        }
        Spacer()
      }
    }
  }
}

#Preview {
  GeometryReader { proxy in
    ScrollView {
      LazyVStack(spacing: 16) {
        Section {
          ForEach(Smoothie.all) { smoothie in
            SmoothieView(smoothie: smoothie, thumbnailSize: proxy.size.width - 32, onTap: {})
          }
          .smoothieStyle(.large)
        } header: {
          Text("Large smoothie style")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding(.horizontal, 16)
    }
  }
}
