import SwiftUI
import Combine
import Translation

struct TranslationButtonView: View {

    final class DataSource: ObservableObject {
        @Published var sourceText = ""
        @Published fileprivate(set) var targetText = ""
    }

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    @State private var configuration: TranslationSession.Configuration?
    @ObservedObject private var dataSource: DataSource

    var body: some View {
        Button {
            triggerTranslation()
        } label: {
            Image(systemName: "translate")
        }
        .translationTask(configuration) { session in
            do {
                let response = try await session.translate(dataSource.sourceText)
                dataSource.targetText = response.targetText
            } catch (let error) {
                dataSource.targetText = error.localizedDescription
            }
        }
    }
}

private extension TranslationButtonView {
    func triggerTranslation() {
        if configuration == nil {
            configuration = .init(source: Locale.Language(identifier: "ja"),
                                  target: Locale.Language(identifier: "en"))
        } else {
            configuration?.invalidate()
        }
    }
}

#Preview {
    TranslationButtonView(dataSource: TranslationButtonView.DataSource())
}
