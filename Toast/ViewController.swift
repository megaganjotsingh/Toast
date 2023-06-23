//
//  ViewController.swift
//  Toast
//
//  Created by Admin on 23/06/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Tap Me", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        button.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
    }

    @objc func onTapButton(_ button: UIButton) {
        Toast.show(with: "ConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnectedConnected")
    }

}

