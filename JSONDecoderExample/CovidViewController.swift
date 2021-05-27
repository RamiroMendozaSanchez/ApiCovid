//
//  CovidViewController.swift
//  JSONDecoderExample
//
//  Created by Ramiro y Jennifer on 26/05/21.
//

import UIKit

struct Estadistica: Codable{
    var country: String
    var cases: Int
}

class CovidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var estadisticas = [Estadistica]()
    
    
    @IBOutlet weak var tableViewCovid: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                print("Listo para llamar a parse!")
             parse(json: data)
            }

        }
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        print("Se llamo parse y creo decoder")
        let peticion = try? decoder.decode([Estadistica].self, from: json)
        print("JSON: \(peticion!.count)")
        estadisticas = peticion!
        print("Estadisticas: \(estadisticas)")
        tableViewCovid.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estadisticas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableViewCovid.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = estadisticas[indexPath.row].country
        celda.detailTextLabel?.text =  "\(estadisticas[indexPath.row].cases)"
        return celda
    }
}
