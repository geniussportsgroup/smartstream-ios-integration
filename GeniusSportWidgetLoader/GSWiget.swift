//
//  GSWiget.swift
//  GeniusSportWidgetLoader
//
//  Created by Trevor Doodes on 19/03/2018.
//

import UIKit
import WebKit

open class GSWiget: WKWebView {
    
    weak var delegate: GSWidgetListener?
    
    
    /**
     Convenience initializer for widget loader
     
     @param url: URL of the widget you wish to load
    */
    public convenience init(url: URL, delegate: GSWidgetListener) {
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        let js: String = "window.addEventListener('message', receiveMessage, false); function receiveMessage(message) {  window.webkit.messageHandlers.iosListener.postMessage(message.data); }"
        let userScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.removeAllUserScripts()
        contentController.addUserScript(userScript)
        webConfiguration.userContentController = contentController
        self.init(frame: .zero, configuration: webConfiguration)
        self.delegate = delegate
        
        contentController.add(self, name: "iosListener")
        self.load(URLRequest(url: url))
    }
 
}

extension GSWiget: WKScriptMessageHandler {

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
        
        guard let json = jsonDictionary,
              let command = json["command"] as? String,
              command != "resize"
        else { return }
        delegate?.onMessage(type: command, message: json)

    }
}
