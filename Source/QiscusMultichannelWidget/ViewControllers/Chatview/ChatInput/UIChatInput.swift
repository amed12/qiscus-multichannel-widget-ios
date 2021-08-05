//
//  UIChatInput.swift
//  QiscusUI
//
//  Created by Qiscus on 04/09/18.
//

#if os(iOS)
import UIKit
#endif
import QiscusCore

// Blueprint method
protocol UIChatInputAction {
    func send(message : QMessage)
    func typing(_ value: Bool)
    func setHeight(_ value: CGFloat)
}

// internal function
protocol UIChatInputDelegate {
    func send(message : QMessage,onSuccess: @escaping (QMessage) -> Void, onError: @escaping (String) -> Void)
    func typing(_ value: Bool)
    func onHeightChanged(height: CGFloat)
}

class UIChatInput: UIView {
    
    @IBOutlet weak var btnAttachment: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tfInput: UITextField!
    var delegate : UIChatInputDelegate? {
        set {
            self._delegate = newValue
        }
        get {
            return self._delegate
        }
    }
    private var _delegate       : UIChatInputDelegate? = nil
    var contentsView            : UIView!

    // If someone is to initialize a UIChatInput in code
    override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        let nib = UINib(nibName: "UIChatInput", bundle: QiscusMultichannelWidget.bundle)
        commonInit(nib: nib)
    }
    
    // If someone is to initalize a UIChatInput in Storyboard setting the Custom Class of a UIView
    required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        let nib = UINib(nibName: "UIChatInput", bundle: QiscusMultichannelWidget.bundle)
        commonInit(nib: nib)
    }
    
    func commonInit(nib: UINib) {
        self.contentsView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        // 2. Adding the 'contentView' to self (self represents the instance of a WeatherView which is a 'UIView').
        addSubview(contentsView)
        
        // 3. Setting this false allows us to set our constraints on the contentView programtically
        contentsView.translatesAutoresizingMaskIntoConstraints = false

        // 4. Setting the constraints programatically
        contentsView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentsView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentsView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentsView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        self.autoresizingMask  = (UIView.AutoresizingMask.flexibleWidth)
    }
    
    @IBAction private func clickUISendButton(_ sender: Any) {
        guard let text = self.tfInput.text else {return}
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let message = QMessage()
            message.message = text
            message.type    = "text"
            self._delegate?.send(message: message, onSuccess: { (comment) in
                //success
            }, onError: { (error) in
                //error
            })
        }
        self.tfInput.text = ""
    }
}

extension UIChatInput : UIChatInputAction {
    func setHeight(_ value: CGFloat) {
        self._delegate?.onHeightChanged(height: value)
    }
    
    func typing(_ value: Bool) {
        self._delegate?.typing(value)
    }
    
    func send(message : QMessage) {
        self._delegate?.send(message: message, onSuccess: { (comment) in
            //success
        }, onError: { (error) in
            //error
        })
    }
}
