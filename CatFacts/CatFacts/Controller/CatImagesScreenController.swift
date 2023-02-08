//
//  CatImageScreenController.swift
//  CatFacts
//
//
import UIKit

class CatImagesScreenController: UIViewController {
    
    let manager = CatImagesManager.shared
    
    private var currentImage: String?
    
    lazy var backgroundImage: UIImageView = AppBackgroundImage()
    
    let label = LargeTitleLabel(text: "A random cat image to save")
    
    let progressIndicator: UIActivityIndicatorView = ProgressIndicator()
    
    lazy var column: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var row: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    lazy var buttonNewImage: UIButton = {
        var button = PinkRoundedButton(text: "New image")
        button.titleLabel?.frame = CGRect(x: 0, y: 0, width: 200, height: 0)
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        return button
    }()

    
    lazy var buttonSaveImage: UIButton = {
        var button = PinkRoundedButton(text: "Save image")
        button.titleLabel?.frame = CGRect(x: 0, y: 0, width: 200, height: 0)
        button.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.loadImage()
    }
    
    @objc func saveImage() {
        guard let url = currentImage else {
            let alert = UIAlertController(
                title: "No image to save",
                message: "Try click in button \"New image\"",
                preferredStyle: .alert
            )
            
            let dismissAction = UIAlertAction(title: "Close", style: .default) { action in return }
            
            alert.addAction(dismissAction)
            self.present(alert, animated: true)
            
            return
        }
        let imageURL = URL(string: url)!
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let startIndex = url.lastIndex(of: "/")!
        let name = url[startIndex..<url.endIndex]
        let fileName = documentDir.appendingPathComponent(String(name), isDirectory: false)
        print(fileName.relativePath)
        
        URLSession.shared.downloadTask(with: imageURL) { tempFileURL, response, error in
            if let imageTempFileURL = tempFileURL {
                do {
                    let image = try Data(contentsOf: imageTempFileURL)
                    try image.write(to: fileName)
                    DispatchQueue.main.async {
                        let alert = UIAlertController(
                            title: "Image saved in: ",
                            message: "\(imageTempFileURL.relativePath)",
                            preferredStyle: .actionSheet
                        )
                        
                        let dismissAction = UIAlertAction(title: "Close", style: .default) { action in return }
                        
                        alert.addAction(dismissAction)
                        self.present(alert, animated: true)
                    }
                } catch {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(
                            title: "Could not save image",
                            message: "\(error)",
                            preferredStyle: .alert
                        )
                        
                        let dismissAction = UIAlertAction(title: "Close", style: .default) { action in return }
                        
                        alert.addAction(dismissAction)
                        self.present(alert, animated: true)
                    }
                    
                    return
                }
            }
            
        }.resume()
    }
    
    @objc func loadImage() {
        self.progressIndicator.startAnimating()
        manager.getFacts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Ocorreu um erro:  \(error)")
                return
            case .success(let image):
                
                guard let url = URL(string: image.file) else { return }
                self.currentImage = image.file
                
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.progressIndicator.stopAnimating()
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
        self.row.addArrangedSubview(buttonNewImage)
        self.row.addArrangedSubview(buttonSaveImage)
        self.column.addArrangedSubview(label)
        self.column.addArrangedSubview(row)
        self.column.addArrangedSubview(image)
       
        self.view.addSubview(column)
        self.view.addSubview(progressIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: - Column
            self.column.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.column.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,  constant: -10),
            self.column.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.column.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            // MARK: - ProgressIndicator
            self.progressIndicator.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.progressIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            
            // MARK: - Background Image
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = UIColor(named: "backgroundPink")
    }
    
    
}
