//
//  StockProductAddController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 06.11.2020.
//

import UIKit

class StockProductAddController: UIViewController {
    var presenter: StockProductAddPresenterProtocol!
    let configurator: StockProductAddConfiguratorProtocol = StockProductAddConfigurator()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var descPlate: UIView!
    @IBOutlet weak var descField: UITextView!
    
    @IBOutlet weak var sellPricePlate: UIView!
    @IBOutlet weak var sellPriceField: UITextField!
    @IBOutlet weak var sellPriceCurrency: UILabel!
    
    @IBOutlet weak var defaultPricePlate: UIView!
    @IBOutlet weak var defaultPriceField: UITextField!
    @IBOutlet weak var defaultPriceCurrency: UILabel!
    
    @IBOutlet weak var supplierLabel: UILabel!
    @IBOutlet weak var supplierPlate: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var namePlate: UIView!
    
    @IBOutlet weak var photoView: UIImageView!
    
    var photoURL: URL?
    var lastOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func supplierAction(_ sender: Any) {
        presenter.chooseSupplier()
    }
    
    @IBAction func addAction(_ sender: Any) {
        presenter.postProduct()
    }
    
    @IBAction func addPhotoAction(_ sender: Any) {
        presenter.choosePhoto()
    }
}

extension StockProductAddController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat((textField.tag * 70))
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.checkField()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.checkField()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension StockProductAddController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        lastOffset = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = 300
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        presenter.checkField()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter.checkField()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
        }
    }
}

extension StockProductAddController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        if let url = info[.imageURL] as? URL {
            photoURL = url
        } else if let img = info[.originalImage] as? UIImage {
            img.saveToCameraRoll { url in
                if let url = url {
                    self.photoURL = url
                }
            }
        }
        photoView.image = image
       // presenter.postPhoto()
        picker.dismiss(animated: true, completion: nil)
    }
}

