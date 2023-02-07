//
//  CatImageScreenController.swift
//  CatFacts
//
//
import UIKit

class CatImagesScreenController: UIViewController {
    
    let manager = CatImagesManager.shared
    
    let backgroundImage: UIImageView = AppBackgroundImage()
    
    let label = LargeTitleLabel(text: "Just click to get a random image")
    
    let progressIndicator: UIActivityIndicatorView = ProgressIndicator()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var button: UIButton = {
        var button = PinkRoundedButton(text: "Get Images")
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @objc func onClick() {
        self.progressIndicator.startAnimating()
        manager.getFacts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Ocorreu um erro:  \(error)")
                return
            case .success(let image):
                
                let isGif = image.file.contains(".gif")
                
                guard let url = URL(string: image.file) else { return }
                
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.progressIndicator.stopAnimating()
                        if isGif {
                            // Implementar depois
                        }
                        self.image.image = UIImage(data: data)
                        
                    }
                }.resume()
                
            }
        }
    }
}

extension CatImagesScreenController : ViewCodeBuild {
    func buildViewHierarchy() {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(label)
        self.view.addSubview(button)
        self.view.addSubview(image)
        self.view.addSubview(progressIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Background Image
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            // MARK: - Label
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.label.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            //  MARK: - Button
            self.button.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 30),
            self.button.centerXAnchor.constraint(equalTo: self.label.centerXAnchor),
            self.button.widthAnchor.constraint(equalToConstant: 200),
            
            // MARK: - Image
            self.image.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 80),
            self.image.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.image.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.image.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.image.heightAnchor.constraint(equalToConstant: 200),
            
            // MARK: - ProgressIndicator
            self.progressIndicator.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 80),
            self.progressIndicator.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.progressIndicator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.progressIndicator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
