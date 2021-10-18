//
//  CoreDataHelper.swift
//  13Oct202
//
//  Created by Amit Pandey on 16/10/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    static let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
    
    // PRODUCT TABLE
    static let TABLE = "Product"
    
    static let ID = "id"
    static let NAME = "name"
    static let DESCRIPTION = "descriptions"
    static let R_PRICE = "r_price"
    static let S_PRICE = "s_price"
    static let IMAGE = "product_photo"
    static let STORES = "stores"
    static let PRODUCT_IMAGE = "product_photo"
    static let COLORS = "colors"
    
    
    class func insertProduct(product: ProductClass) {
        print("insertProduct() called")
        
        let context = APP_DELEGATE.persistentContainer.viewContext
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: TABLE, into: context)
        entity.setValue(numberOfProductsInCoreData(), forKey: ID)
        entity.setValue(product.productName, forKey: NAME)
        entity.setValue(product.productDescription, forKey: DESCRIPTION)
        entity.setValue(product.productRegularPrice, forKey: R_PRICE)
        entity.setValue(product.productSalePrice, forKey: S_PRICE)
        if let image = product.productImage {
            let data = try! NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            entity.setValue(data, forKey: IMAGE)
        }
        if let array = product.productColors {
            let colorsArray = try! NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
            entity.setValue(colorsArray, forKey: COLORS)
        }
        if let dictionary = product.storeAddress {
            let dict = try! NSKeyedArchiver.archivedData(withRootObject: dictionary, requiringSecureCoding: true)
            entity.setValue(dict, forKey: COLORS)
        }
        
        do {
            try context.save()
        }
        catch (let exception) {
            print("Exception: \(exception)")
        }
    }
    
    class func numberOfProductsInCoreData() -> NSNumber {
        print("numberOfProductsInCoreData() called")
        
        let context = APP_DELEGATE.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE)
        
        do {
            let count = try context.count(for: fetchRequest)
            return NSNumber(value: count)
        } catch {
            print(error.localizedDescription)
            return NSNumber(value: 0)
        }
    }
    
    class func fetchAllProducts() -> [ProductClass] {
        print("fetchAllProducts() called")
        
        var pArray:[ProductClass] = []
        
        let context = APP_DELEGATE.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE)
        
        do {
            let array = try context.fetch(fetchRequest) as! [NSManagedObject]
            if array.count > 0 {
                for object in array {
                    let prod = ProductClass()
                    prod.productName = object.value(forKey: NAME) as! String
                    prod.productDescription = object.value(forKey: DESCRIPTION) as! String
                    prod.productSalePrice = object.value(forKey: S_PRICE) as! Double
                    prod.productRegularPrice = object.value(forKey: R_PRICE) as! Double
                    if let imgd = object.value(forKey: IMAGE) as? Data {
                        prod.productImage = try! NSKeyedUnarchiver.unarchivedObject(ofClass: NSData.self, from: imgd) as Data?
                    }
                    if let address = object.value(forKey: STORES) as? Data {
                        prod.storeAddress = try! NSKeyedUnarchiver.unarchivedObject(ofClass: NSDictionary.self, from: address) as! [String: String]?
                    }
                    
                    pArray.append(prod)
                }
                
            }
            return pArray
        } catch {
            print(error.localizedDescription)
            return pArray
        }
    }
    
    
}
