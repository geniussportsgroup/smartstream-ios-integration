//
//  GSWidgetListener.swift
//  GeniusSportWidgetLoader
//
//  Created by Trevor Doodes on 20/03/2018.
//

import Foundation

public protocol GSWidgetListener: class {
    /**
     Delegate method fired when window.post message posted
     
     @param type: String representation of the message type
     @param message: Message content
     */
    func onMessage(type: String, message: [String: Any])
    
    /**
     Delegate method fired if a javascrip error occurs on the widget
 
     @param type: String representation of the message type
     @param rawMessage: String representation of the error 
    */
    func onError(type: String, rawMessage: String)
}
