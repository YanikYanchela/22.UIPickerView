//
//  ViewController.swift
//  UIAlertController
//
//  Created by Дмитрий Яновский on 8.02.24.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()
    let label = UILabel()
    let labelView = UIView()
    let ViewPicker = UIView()
    let image = UIImageView()
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    var isPickerVisible = false
    
   let country = ["Minsk", "Batumi", "London", "Paris", "Tallin" ]
    var selectedCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        
    
        
    }
    
    private func setupButton(){
        button.backgroundColor = .purple
        button.setTitle("View message", for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.shadowOpacity = 2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAnimation(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(setAlert), for: .touchUpInside)
        
        view.backgroundColor = .orange
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
     func setupLabel(){
        label.text = selectedCity
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines  = 0
         label.isUserInteractionEnabled = true
       
        setupLabelView()
        labelView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: labelView.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: labelView.trailingAnchor ,constant: -10),
            label.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: labelView.topAnchor)
        ])
        
        view.bringSubviewToFront(labelView)
         label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTap)))
         
         
    }
    
    private func setupLabelView(){
        labelView.backgroundColor = .white
        labelView.layer.cornerRadius = 15
        labelView.layer.borderWidth = 2
        labelView.layer.shadowOpacity = 2
        labelView.layer.shadowOffset = CGSize(width: 2, height: 2)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(labelView)
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: view.topAnchor,constant: 550),
            labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            labelView.heightAnchor.constraint(equalToConstant: 60)])
        
        UIView.animate(withDuration: 0.9) {
            self.labelView.alpha = 0.8
        }
    }
    
    private func setupViewPicker(){
        let done = UIButton()
        done.backgroundColor = .purple
        done.setTitle("done", for: .normal)
        done.layer.borderWidth = 2
        done.layer.cornerRadius = 10
        done.setTitleColor(UIColor.black, for: .normal)
        done.translatesAutoresizingMaskIntoConstraints = false
        done.addTarget(self, action: #selector(hidePicker), for: .touchUpInside)
        
        let addImage = UIButton()
        addImage.backgroundColor = .orange
        addImage.setTitle("add image", for: .normal)
        addImage.layer.borderWidth = 2
        addImage.layer.cornerRadius = 10
        addImage.setTitleColor(UIColor.black, for: .normal)
        addImage.translatesAutoresizingMaskIntoConstraints = false
        addImage.addTarget(self, action: #selector(showImageView), for: .touchUpInside)
        
        ViewPicker.frame.origin.y = labelView.frame.origin.y + labelView.frame.size.height
        ViewPicker.backgroundColor = .white
        ViewPicker.layer.cornerRadius = 20
        ViewPicker.layer.borderWidth = 2
        ViewPicker.layer.shadowOpacity = 2
        ViewPicker.layer.shadowOffset = CGSize(width: 2, height: 2)
        ViewPicker.translatesAutoresizingMaskIntoConstraints = false
       
        
        view.addSubview(ViewPicker)
        ViewPicker.addSubview(pickerView)
        ViewPicker.addSubview(done)
        ViewPicker.addSubview(addImage)
        setupImageView()
        
        NSLayoutConstraint.activate([
            ViewPicker.topAnchor.constraint(equalTo: view.topAnchor,constant: 320),
            ViewPicker.widthAnchor.constraint(equalToConstant: 150),
            ViewPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ViewPicker.heightAnchor.constraint(equalToConstant: 200),
            
            done.bottomAnchor.constraint(equalTo: ViewPicker.bottomAnchor, constant: -10),
            done.trailingAnchor.constraint(equalTo: ViewPicker.trailingAnchor, constant: -5),
            done.widthAnchor.constraint(equalToConstant: 50),
            done.heightAnchor.constraint(equalToConstant: 30),
            
            addImage.bottomAnchor.constraint(equalTo: ViewPicker.bottomAnchor, constant: -10),
            addImage.leadingAnchor.constraint(equalTo: ViewPicker.leadingAnchor, constant: 5),
            addImage.widthAnchor.constraint(equalToConstant: 85),
            addImage.heightAnchor.constraint(equalToConstant: 30),
        
            pickerView.topAnchor.constraint(equalTo: ViewPicker.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: done.topAnchor),
            pickerView.trailingAnchor.constraint(equalTo: ViewPicker.trailingAnchor),
            pickerView.leadingAnchor.constraint(equalTo: ViewPicker.leadingAnchor)])
            
        UIView.animate(withDuration: 0.4) {
            self.ViewPicker.alpha = 0.8
        }
    }
    
    private func setupImageView(){
        
        image.backgroundColor = .systemGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.cornerRadius = 20
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: ViewPicker.topAnchor , constant: 20),
            image.bottomAnchor.constraint(equalTo: ViewPicker.bottomAnchor , constant: -20),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            image.leadingAnchor.constraint(equalTo: ViewPicker.trailingAnchor, constant: 10)])
    }
    
        func alert(){
            let alert = UIAlertController(title: "Важное сообщение" , message: "Спасибо, что выбрали наше приложение!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.setupLabel()
                self.label.text = "Tap me pls!!!"
                
        
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {
                _ in print ("cancel")
                
                self.labelView.removeFromSuperview()
                self.ViewPicker.removeFromSuperview()
                self.image.removeFromSuperview()
            }))
            present(alert, animated: true)
            
        }
    

    @objc func labelTap(){
        setupViewPicker()
    }
    
    @objc func hidePicker(){
        self.ViewPicker.removeFromSuperview()
        self.image.removeFromSuperview()
    }

    @objc func showImageView(){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        
    }
        @objc func setAlert(){
            alert()
            
        }
        
        @objc func buttonAnimation(_ sender: UIButton) {
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { finished in
                UIView.animate(withDuration: 0.1) {
                    sender.transform = .identity
                }
            }
        }
        
        
    
}
