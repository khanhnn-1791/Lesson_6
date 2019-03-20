//
//  ViewController.swift
//  parse_json
//
//  Created by nguyen.nam.khanh on 3/20/19.
//  Copyright © 2019 nguyen.nam.khanh. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {

    //MARK : Properties
    @IBOutlet weak var tableView: UITableView!
    
    private var objects = [Object]()
    private let spinner = UIActivityIndicatorView(style: .gray)
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadData()
    }
    
    //MARK: Methods
    private func prepareUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    private func loadData() {
       indicator()
        let url = URL(string: "https://api.github.com/users/google/repos")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in
            
            guard let data = data else {
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                for i in json as! [[String: AnyObject]] {
                    let obj = Object()
                    obj.mapping(map: Map(mappingType: MappingType.fromJSON, JSON: i))                    
                    self.objects.append(obj)
                }
            } catch let jsonError {
                print(jsonError)
            }
            
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.tableView.reloadData()
                self.tableView.separatorStyle = .singleLine
            }
        }
        task.resume()
    }
    private func indicator() {
        view.addSubview(spinner)
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(44))
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        view.addSubview(spinner)
        spinner.startAnimating()
    }
}


    //MARK: Extensions
extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = objects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.object = object
        cell.selectionStyle = .none
        return cell
    }
    
    
}

