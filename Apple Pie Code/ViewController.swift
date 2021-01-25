//
//  ViewController.swift
//  Apple Pie Code
//
//  Created by Владимир Кефели on 25.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let topStackView = UIStackView()
    let treeImageView = UIImageView()
    let stackView = UIStackView()

    // MARK: - Methods
    func updateUI(to size: CGSize) {
        topStackView.axis = size.height < size.width ? .horizontal : .vertical
        topStackView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup stack view
        stackView.backgroundColor = .clear
        
        // Setup top stack view
        topStackView.backgroundColor = .clear
        topStackView.distribution = .fillEqually
        topStackView.frame = view.bounds
        topStackView.addArrangedSubview(treeImageView)
        topStackView.addArrangedSubview(stackView)
        
        // Setup tree image view
        treeImageView.backgroundColor = .green
        
        // Setup view
        view.addSubview(topStackView)
        view.backgroundColor = .white
        
        
        updateUI(to: view.bounds.size)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(to: size)
    }

}

