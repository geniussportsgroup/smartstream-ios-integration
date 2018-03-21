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
     
     - Parameter type: The message type returned by the widget
     - Parameter message: The message returned by the widget
     
     */
    func onMessage(type: String, message: [String: Any])
    
    /**
     Delegate method fired if a javascrip error occurs on the widget
 
     - Parameter type: String representation of the message type
     - Parameter rawMessage: String representation of the error
     
    */
    func onError(type: String, rawMessage: String)
}
