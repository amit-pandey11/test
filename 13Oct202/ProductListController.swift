//
//  ProductListController.swift
//  13Oct202
//
//  Created by Amit Pandey on 16/10/21.
//

import UIKit

class ProductListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var productsArray: [ProductClass]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Number of products - \(CoreDataHelper.numberOfProductsInCoreData())")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "product_cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productsArray = CoreDataHelper.fetchAllProducts()
        
    }

}

extension ProductListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*guard let productA = productsArray, let pData = productA[indexPath.row] as? ProductClass else {
            return UITableViewCell()
        }*/
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for:  indexPath) as? ProductTableViewCell else {
            let cell = ProductTableViewCell()
            //cell.drawCell(cellData: pData)
            return cell
        }
        cell.drawCell(cellData: productsArray![indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}
