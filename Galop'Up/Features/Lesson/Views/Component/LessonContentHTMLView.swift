//
//  LessonContentHTMLView.swift
//  Galop'Up
//
//  Created by Emma on 22/11/2026.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    let html: String
    @Binding var height: CGFloat
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences.allowsContentJavaScript = false
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.backgroundColor = .clear
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.height = $height
        
        guard context.coordinator.loadedHTML != html else { return }
        context.coordinator.loadedHTML = html
        
        let css = Bundle.main.url(forResource: "Lesson", withExtension: "css")
            .flatMap { try? String(contentsOf: $0, encoding: .utf8) } ?? ""
        
        let page = """
            <html><head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>\(css)</style>
            </head><body>\(html)</body></html>
            """
        webView.loadHTMLString(page, baseURL: Bundle.main.resourceURL)
    }
    
    @MainActor
    final class Coordinator: NSObject, WKNavigationDelegate {
        var height: Binding<CGFloat>?
        var loadedHTML = ""
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight") { result, _ in
                if let value = (result as? NSNumber)?.doubleValue {
                    self.height?.wrappedValue = CGFloat(value)
                }
            }
        }
    }
}
