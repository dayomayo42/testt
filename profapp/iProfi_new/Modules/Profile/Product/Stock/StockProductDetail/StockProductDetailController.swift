//
//  StockProductDetailController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 09.11.2020.
//

import UIKit

class StockProductDetailController: UIViewController {
    var presenter: StockProductDetailPresenterProtocol!
    let configurator: StockProductDetailConfiguratorProtocol = StockProductDetailConfigurator()
    
    @IBOutlet weak var scrollView: UIScrollView!
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
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var photoPlate: UIView!
    var photoURL: URL?
    var model: StockProduct?
    var isEditMode = false
    
    var lastOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        presenter.editAction(isEdit: isEditMode)
        presenter.fillView(with: model!)
    }
    
    @IBAction func backAction(_ sender: Any) {
        presenter.backAction()
    }
    
    @IBAction func supplierAction(_ sender: Any) {
        presenter.chooseSupplier()
    }
    
    @IBAction func addAction(_ sender: Any) {
        presenter.postEditModel()
    }
    
    @IBAction func editAction(_ sender: Any) {
        presenter.editAction(isEdit: !isEditMode)
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        presenter.deleteAction()
    }
    
    @IBAction func addPhotoAction(_ sender: Any) {
        presenter.choosePhoto()
    }
}

extension StockProductDetailController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lastOffset = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = CGFloat((textField.tag * 70))
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.checkField()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
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

extension StockProductDetailController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
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
            self.scrollView.contentOffset.y = 0
        }
    }
}

extension StockProductDetailController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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

