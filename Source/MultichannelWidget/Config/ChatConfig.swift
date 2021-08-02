//
//  ChatConfig.swift
//  QiscusSDK
//
//  Created by Ahmad Athaullah on 8/18/16.
//  Copyright © 2016 Ahmad Athaullah. All rights reserved.
//

#if os(iOS)
import UIKit
#endif


/// Qiscus ui style configuration
class ChatConfig: NSObject {
    static var bundle : Bundle? {
        get{
            return nil
        }
    }
    
    var copyright = TextConfiguration.sharedInstance

    static var chatFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body){
        didSet{
            if chatFont.pointSize != UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize{
                if chatFont.fontName != UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).fontName {
                    
                }
            }
        }
    }
    
    static var showSystemMessage: Bool = true
    static var showAvatarSender: Bool = true
    static var showUserNameSender: Bool = true

    static var chatTextMaxWidth:CGFloat = 0.7 * UIScreen.main.bounds.size.width
    static var baseColor:UIColor{
        get{
            return ColorConfiguration.topColor
        }
    }
    fileprivate override init() {}
}
