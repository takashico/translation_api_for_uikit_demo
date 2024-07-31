import Flutter
import UIKit
import SwiftUI
import Combine

public class IosTranslationPlugin: NSObject, FlutterPlugin {
    static var shared: IosTranslationPlugin?

    var translationButtonViewDataSource = TranslationButtonView.DataSource()

    private var channel: FlutterMethodChannel?
    private var cancellableSet: Set<AnyCancellable> = []

    init(channel: FlutterMethodChannel) {
        super.init()
        self.channel = channel
        
        translationButtonViewDataSource.$targetText
            .receive(on: RunLoop.main)
            .sink { [weak self] translatedText in
                self?.channel?.invokeMethod("onTranslated", arguments: translatedText)
            }
            .store(in: &cancellableSet)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "takashico.translation-api-uikit-sample/ios_translation_plugin",
                                           binaryMessenger: registrar.messenger())
        let instance = IosTranslationPlugin(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let factory = TranslationButtonViewFactory()
        registrar.register(factory, withId: "takashico.translation-api-uikit-sample/translation_button_view")
        
        shared = instance
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "setTranslationSourceText" {
            guard let args = call.arguments as? [String: Any],
                  let text = args["text"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument", details: nil))
                return
            }
            translationButtonViewDataSource.sourceText = text
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}

final class TranslationButtonViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return TranslationButtonFlutterPlatformView(frame)
    }
}

final class TranslationButtonFlutterPlatformView: NSObject, FlutterPlatformView {
    private var translationButtonView: UIView?
    
    init(_ frame: CGRect) {
        super.init()
        
        if let plugin = IosTranslationPlugin.shared {
            let contentView = TranslationButtonView(dataSource: plugin.translationButtonViewDataSource)
            let hostingController = UIHostingController(rootView: contentView)
            translationButtonView = hostingController.view
            translationButtonView?.frame = frame
        }
    }

    func view() -> UIView {
        return translationButtonView ?? UIView()
    }
}
