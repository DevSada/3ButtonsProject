//
//  ViewController.swift
//  3ButtonsProject
//
//  Created by Alexander Petrenko on 05.04.2024.
//

import UIKit

class ViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    
    private let buttonsInfo: [ButtonInfo] = [
        ButtonInfo(title: "Simple button", action: #selector(buttonTapped)),
        ButtonInfo(title: "Button for size understanding", action: #selector(buttonTapped)),
        ButtonInfo(title: "Modal Button", action: #selector(showModalController))
    ]
    
    private weak var modalButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews() {
        
        view.backgroundColor = .white
        
        for (index, info) in buttonsInfo.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(info.title, for: .normal)
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.setTitleColor(.green, for: .normal)
            button.tintColor = .green
            
            button.layer.borderColor = UIColor.green.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 15
            
            button.semanticContentAttribute = .forceRightToLeft
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 22)
            button.addTarget(self, action: info.action, for: .touchUpInside)
            button.addTarget(self, action: #selector(scaleDownButton(sender:)), for: .touchDown)
            button.addTarget(self, action: #selector(scaleUpButton(sender:)), for: [.touchUpInside, .touchUpOutside])
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            if info.action == #selector(showModalController) {
                modalButton = button
            }
            
            NSLayoutConstraint.activate([
                   button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(index) * 60 + 20)
               ])
        }
        
        
    }
    
    @objc private func buttonTapped() {
            print("Button tapped")
        }

    
    @objc private func showModalController() {
        
        modalButton?.backgroundColor = .systemGray2
        modalButton?.setTitleColor(.systemGray3, for: .normal)
        modalButton?.tintColor = .systemGray3
        modalButton?.layer.borderColor = UIColor.systemGray3.cgColor
        
        let modalVC = UIViewController()
                modalVC.view.backgroundColor = .systemGray2
                modalVC.isModalInPresentation = false
                modalVC.modalPresentationStyle = .pageSheet
                modalVC.presentationController?.delegate = self
                
                present(modalVC, animated: true, completion: nil)
        
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
        if let button = (view.subviews.compactMap { $0 as? UIButton }.filter { $0.currentTitle == "Modal Button" }).first {
            button.backgroundColor = .clear
            button.setTitleColor(.green, for: .normal)
            button.tintColor = .green
            button.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    @objc private func scaleDownButton(sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
    
    @objc private func scaleUpButton(sender: UIButton) {
      
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform.identity
        })
    }
    
}
