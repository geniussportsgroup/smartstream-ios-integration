//
//  GSWiget.swift
//  GeniusSportWidgetLoader
//
//  Created by Trevor Doodes on 19/03/2018.
//

import UIKit
import WebKit

open class GSWidget: WKWebView {
    
    weak var delegate: GSWidgetListener?
    
    
    /**
     Convenience initializer for widget loader
     
     - Parameter url: URL of the widget you wish to load
     - Parameter delegate: An object that conforms to the GSWidgetListener protocol
     
    */
    public convenience init(url: URL, delegate: GSWidgetListener) {
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        let js: String = """
                window.addEventListener('message', receiveMessage, false);
                function receiveMessage(message) {
                   window.webkit.messageHandlers.iosMessageListener.postMessage(message.data);
                }

                window.onerror = function errorMessage(msg, url, lineNo, columnNo, error) {
                    var message = [
                        'Message: ' + msg,
                        'URL: ' + url,
                        'Line: ' + lineNo,
                        'Column: ' + columnNo,
                        'Error object: ' + JSON.stringify(error)
                    ].join(' - ');
                   window.webkit.messageHandlers.iosErrorListener.postMessage(message);
                }
        """
        let userScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.removeAllUserScripts()
        contentController.addUserScript(userScript)
        webConfiguration.userContentController = contentController
        self.init(frame: .zero, configuration: webConfiguration)
        self.delegate = delegate
        self.scrollView.delegate = self
        
        contentController.add(self, name: "iosMessageListener")
        contentController.add(self, name: "iosErrorListener")
        self.load(URLRequest(url: url))
    }
 
}

extension GSWidget: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}

extension GSWidget: WKScriptMessageHandler {

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let responseString = message.body as? String else { return }
        switch message.name {
        case "iosMessageListener":
            do {
                self.handleMessage(responseString: responseString)
            }
        case "iosErrorListener":
            do {
                self.handleError(responseString: responseString)
            }
        default:
            return
        }
  
    }
    
    private func handleMessage(responseString: String) {
        var jsonDictionary: [String : Any]?
        if let data = responseString.data(using: String.Encoding.utf8) {
            do {
                jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
            } catch {
                delegate?.onError(type: "Message error", rawMessage: "Failed to parse response")
            }
        }
        
        guard let json = jsonDictionary,
            let command = json["command"] as? String,
            command != "resize"
            else { return }
        delegate?.onMessage(type: command, message: json)
    }
    
    private func handleError(responseString:String) {
        delegate?.onError(type: "Script Error", rawMessage: responseString)
    }
}
