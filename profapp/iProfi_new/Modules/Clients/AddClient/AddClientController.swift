//
//  AddClientController.swift
//  iProfi_new
//
//  Created by Artyom Vlasov on 25.10.2020.
//

import UIKit
import Photos
import TinkoffASDKUI

class AddClientController: UIViewController {
    var presenter: AddClientPresenterProtocol!
    let configurator: AddClientConfiguratorProtocol = AddClientConfigurator()
    var delegate: ContactClientDelegate?
    
    @IBOutlet weak var surnameView: UIView!
    @IBOutlet weak var surnameField: UITextField!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var patronymicView: UIView!
    @IBOutlet weak var patronymicField: UITextField!
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberField: PhoneNumberView!
    
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var mailField: UITextField!
    
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var birthField: UITextField!
    
    @IBOutlet weak var sexView: UIView!
    @IBOutlet weak var sexField: UITextField!
    
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteField: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    
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
    
    @IBAction func countryAction(_ sender: Any) {
        presenter.openChooseCountry()
    }
    
    @IBAction func addPhotoAction(_ sender: Any) {
        presenter.choosePhoto()
    }
    
    @IBAction func editPhoto(_ sender: Any) {
        presenter.choosePhoto()
    }
    
    @IBAction func addClient(_ sender: Any) {
        presenter.postClient(model: CreateClientModel(name: nameField.text, midname: patronymicField.text, lastname: surnameField.text, phone: phoneNumberField.text, email: mailField.text, gender: sexField.text, birth: birthField.text, note: noteField.text, image: ""))
    }
}


extension AddClientController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pos = textField.tag == 0 ? 80 : textField.tag == 1 ? nameView.frame.minY : textField.tag == 2 ? patronymicView.frame.minY : textField.tag == 3 ? phoneNumberView.frame.minY : textField.tag == 4 ? mailView.frame.minY : textField.tag == 5 ? birthView.frame.minY : sexView.frame.minY
        if textField == sexField && textField.text?.count == 0 {
            sexField.text = "Мужской"
        }
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = pos - 80
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

extension AddClientController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let pos = noteView.frame.minY
        lastOffset = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = pos - 80
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter.checkField()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.lastOffset
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        presenter.checkField()
        return true
    }
}


extension AddClientController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        row == 0 ? "Мужской" : "Женский"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.checkField()
        sexField.text = row == 0 ? "Мужской" : "Женский"
    }
}


extension AddClientController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
        photoImage.image = image
        photoView.isHidden = false
        addPhotoView.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
}

extension UIImage {
    func saveToCameraRoll(completion: @escaping (URL?) -> Void) {
        var placeHolder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self)
            placeHolder = creationRequest.placeholderForCreatedAsset!
        }, completionHandler: { success, _ in
            guard success, let placeholder = placeHolder else {
                completion(nil)
                return
            }
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
            guard let asset = assets.firstObject else {
                completion(nil)
                return
            }
            asset.requestContentEditingInput(with: nil, completionHandler: { editingInput, _ in
                completion(editingInput?.fullSizeImageURL)
            })
        })
    }
}
