import SwiftUI

@main
struct RelayApp: App {
    @State private var theme = ThemeStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(theme)
                .preferredColorScheme(theme.theme.colorScheme)
                .onOpenURL { url in
                    DeepLinkRouter.shared.handle(url)
                }
        }
    }
}

struct RootTabView: View {
    var body: some View {
        TabView {
            TerminalTabPlaceholder()
                .tabItem {
                    Label("Terminal", systemImage: "terminal")
                }
            SettingsTabPlaceholder()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

/// Placeholder until PR 4 lands TerminalScreen and the session/server lists.
struct TerminalTabPlaceholder: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No Sessions",
                systemImage: "terminal",
                description: Text("Add a server to start a session.")
            )
            .navigationTitle("Terminal")
        }
    }
}

/// Placeholder until PR 9 lands the full settings build-out.
struct SettingsTabPlaceholder: View {
    @Environment(ThemeStore.self) private var theme

    var body: some View {
        @Bindable var theme = theme
        NavigationStack {
            Form {
                Section("Theme") {
                    Picker("Appearance", selection: $theme.theme) {
                        ForEach(AppTheme.allCases) { option in
                            Text(option.label).tag(option)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

/// Routes relay://session/<uuid> deep links. Target selection lands with
/// SessionManager (PR 5) and Live Activities (PR 8).
final class DeepLinkRouter {
    static let shared = DeepLinkRouter()

    private(set) var pendingSessionID: UUID?

    func handle(_ url: URL) {
        guard url.scheme == "relay", url.host == "session" else { return }
        pendingSessionID = UUID(uuidString: url.lastPathComponent)
    }
}
