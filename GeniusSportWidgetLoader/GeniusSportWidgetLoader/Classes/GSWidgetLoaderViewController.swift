//
//  GSWidgetLoaderViewController.swift
//  GeniusSportWidgetLoader
//
//  Created by Trevor Doodes on 19/03/2018.
//

import UIKit
import WebKit

open class GSWidgetLoaderViewController: UIViewController {
    
    private let widgetURL: URL
    private var webView: WKWebView?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.widgetURL = URL(string: "https://betfred.betstream.betgenius.com/betstream-view/fixturelist/betfredinplay/html")!
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.widgetURL = URL(string: "https://betfred.betstream.betgenius.com/betstream-view/fixturelist/betfredinplay/html")!
        super.init(coder: aDecoder)
    }
    
    open override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        let js: String = "window.addEventListener('message', receiveMessage, false); function receiveMessage(message) {  window.webkit.messageHandlers.iosListener.postMessage(message.data); }"
        let userScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.removeAllUserScripts()
        contentController.addUserScript(userScript)
        
        contentController.add(self, name: "iosListener")
        
        webConfiguration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        webView?.load(URLRequest(url: widgetURL))
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GSWidgetLoaderViewController: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let responseString = message.body as? String else { return }
        
        var jsonDictionary: [String : Any]?
        if let data = responseString.data(using: String.Encoding.utf8) {
            do {
                jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
            } catch {
                print("failed to parse")
            }
        }
        
        if let json = jsonDictionary {
            print(json["command"] ?? "")
            print(json["selection"] ?? "")
        }
    }
}
