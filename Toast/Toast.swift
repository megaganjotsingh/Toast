//
//  Toast.swift
//  Wishwell
//
//  Created by Admin on 23/06/23.
//

import Foundation
import UIKit.UIView

class Toast {    
    
    static private var initialTransform: CGAffineTransform {
        CGAffineTransform(scaleX: 0.7, y: 0.7).translatedBy(x: 0, y: UIScreen.main.bounds.height)
    }
    static private var closeTimer: Timer?
        
    static func show(with text: String) {
        guard let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window , let rootView = window.rootViewController?.view else { return }
        
        let view = window.viewWithTag(909090)
        if let view = view {
            view.removeFromSuperview()
        }
        
        let toastView = ToastView()
        toastView.messageLabel.text = "Yor blessings and personal note has been sent"
        rootView.addSubview(toastView)
        toastView.layoutIfNeeded()
        toastView.layer.cornerRadius = toastView.frame.height / 2
        toastView.transform = initialTransform

        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16),
            toastView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -16),
            toastView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -100),
        ])
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .allowUserInteraction,
            animations: {
                toastView.transform = .identity
            }, completion: { _ in })
        
        closeTimer?.invalidate()
        closeTimer = Timer.scheduledTimer(
            withTimeInterval: .init(4),
            repeats: false
        ) { [self] _ in
            DispatchQueue.main.async {
                self.close()
            }
        }
        toastView.onTapButton = {
            close()
        }
    }
    
    static private func close() {
        closeTimer?.invalidate()
        guard let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else { return }
        let view = window.viewWithTag(909090)
        if let view = view {
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: .allowUserInteraction,
                animations: {
                    view.transform = self.initialTransform
                }, completion: { _ in
                    view.removeFromSuperview()
                    
                }
            )
        }
    }
}

fileprivate class ToastView: UIView {
    let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textColor = UIColor.white
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.numberOfLines = 5
        messageLabel.textAlignment = .left
        messageLabel.font = .systemFont(ofSize: 16, weight: .medium)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var onTapButton: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    func setUpUI() {
        backgroundColor = .blue.withAlphaComponent(0.5)
        translatesAutoresizingMaskIntoConstraints = false
        tag = 909090
        addSubview(messageLabel)
        addSubview(button)
        button.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        
        align()
    }
    
    func align() {
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    @objc func onTapButton(_ sender: UIButton) {
        onTapButton?()
    }
}
