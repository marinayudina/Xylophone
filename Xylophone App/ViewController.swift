//
//  ViewController.swift
//  Xylophone App
//
//  Created by Марина on 22.07.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer?
    private var nameButtons = ["C", "D", "E", "F", "G", "A", "B"]
    

    private lazy var buttonsStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.spacing = 5
//        stackview.backgroundColor = .black
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        setConstraints()
        createButtons()

    }
    
    private func createButtons() {
        for (index, nameButton) in nameButtons.enumerated() {
            let space = 5 + (index * 5)
            createButton(name: nameButton, space: space)
        }
    }
    
    private func createButton(name: String, space: Int) {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(name, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 45)
        button.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        
        buttonsStack.addArrangedSubview(button)
//        button.layer.cornerRadius = 10
//        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: width).isActive = true
        button.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor, constant: CGFloat(space)).isActive = true
        button.trailingAnchor.constraint(equalTo: buttonsStack.trailingAnchor, constant: CGFloat(-1 * space)).isActive = true
//        button.heightAnchor.constraint(equalTo: buttonsStack.heightAnchor, multiplier: 1/7).isActive = true
        
        button.backgroundColor = getColor(for: name)
    }
    
    private func getColor(for name: String) -> UIColor {
        switch name {
        case "C": return .systemRed
        case "D": return .systemOrange
        case "E": return .systemYellow
        case "F": return .systemGreen
        case "G": return .systemIndigo
        case "A": return .systemBlue
        case "B": return .systemPurple
        default: return .white
        }
    }

    private func setupView() {
//        view.addSubview(cButton)
//        view.addSubview(dButton)
//        view.addSubview(eButton)

//        buttonsStack.addArrangedSubview(cButton)
//        buttonsStack.addArrangedSubview(dButton)
//        buttonsStack.addArrangedSubview(eButton)
        view.addSubview(buttonsStack)
    }
    
    @objc func buttonsTapped(_ sender: UIButton) {
        playSound(sender.currentTitle!)
        
        sender.alpha = 0.5
        
        //задержка на 2 сек 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            sender.alpha = 1
        }
        
    }
    
    func playSound(_ name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}

extension ViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
//            cButton.heightAnchor.constraint(equalTo: buttonsStack.heightAnchor, multiplier: 0.3),
//            cButton.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor),
//            cButton.trailingAnchor.constraint(equalTo: buttonsStack.trailingAnchor),
//            
//            dButton.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor, constant: 5),
//            dButton.trailingAnchor.constraint(equalTo: buttonsStack.trailingAnchor, constant: -5),
//            dButton.heightAnchor.constraint(equalTo: buttonsStack.heightAnchor, multiplier: 0.3),
//            
//            eButton.heightAnchor.constraint(equalTo: buttonsStack.heightAnchor, multiplier: 0.3),
//            eButton.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor, constant: 10),
//            eButton.trailingAnchor.constraint(equalTo: buttonsStack.trailingAnchor, constant: -10),
            
            buttonsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
