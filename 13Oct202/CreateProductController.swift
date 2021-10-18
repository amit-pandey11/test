//
//  CreateProductController.swift
//  13Oct202
//
//  Created by Amit Pandey on 16/10/21.
//

import UIKit

class CreateProductController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productDescriptionField: UITextView!
    @IBOutlet weak var productRegularPriceField: UITextField!
    @IBOutlet weak var productSalePrice: UITextField!
    
    @IBOutlet weak var storeAddressFiled_1: UITextField!
    @IBOutlet weak var storeAddressField_2: UITextField!
    @IBOutlet weak var storeAddressField_3: UITextField!
    
    var colorsArray: Array<UIColor> = Array()
    var tempColor: UIColor?
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var productImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        colorCollectionView.collectionViewLayout = layout
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
        if let layout = colorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.itemSize = CGSize(width: 40, height: 40)
            layout.invalidateLayout()
        }
        
        colorCollectionView.register(UINib(nibName: "ColorCell", bundle: Bundle.main), forCellWithReuseIdentifier: "color_cell")
        
    }
    
    @IBAction func addImageButtonAction(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        self.present(pickerController, animated: true)
    }
    
    @IBAction func colorButtonAction(_ sender: Any) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func SaveButtonAction(_ sender: UIBarButtonItem) {
        
        let product = ProductClass()
        product.productName = productNameField.text ?? ""
        product.productDescription = productDescriptionField.text ?? ""
        if let rPrice = productRegularPriceField.text, let doubleValue = Double(rPrice) {
            product.productRegularPrice = doubleValue
        }
        if let sPrice = productSalePrice.text, let doubleValue = Double(sPrice) {
            product.productSalePrice = doubleValue
        }
        product.productColors = colorsArray
        if let image = productImage.image {
            product.productImage = image.jpegData(compressionQuality: 0.5)
        }
        
        CoreDataHelper.insertProduct(product: product)
        
        dismiss(animated: true)
    }
    
}

extension CreateProductController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "color_cell", for: indexPath) as? ColorCell else {
            return ColorCell()
        }
        cell.backgroundColor = colorsArray[indexPath.item]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colorsArray.count
    }
    
}

extension CreateProductController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            productImage.image = image
        }
        picker.dismiss(animated: true)
    }
    
}

extension CreateProductController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        print("didSelect color: \(color), continuously: \(continuously)")
        
        if !continuously {
            tempColor = color
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("colorPickerViewControllerDidFinish")
        if let color = tempColor {
            colorsArray.append(color)
            colorCollectionView.reloadData()
        }
    }
    
}
