//
//  WeatherSnapshotViewController.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/17/21.
//

import UIKit

class WeatherSnapshotViewController: UIViewController {
    @IBOutlet weak var conditionsIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UITextView!
    @IBOutlet weak var standardWeatherBackground: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    /*
    @IBOutlet weak var weatherDetailsTableView: UITableView!
 */
    
    let rest = RestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.cornerRadius = 25
        standardWeatherBackground.layer.cornerRadius = 25
        //getUsersList()
        //getNonExistingUser()
        //createUser()
        getSingleUser()

    }
    
    func getUsersList() {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        // The following will make RestManager create the following URL:
        // https://reqres.in/api/users?page=2
        rest.urlQueryParameters.add(value: "2", forKey: "page")
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
                        print(userData.description)
                    }
            
            print("\n\nResponse HTTP Headers:\n")
             
                    if let response = results.response {
                        for (key, value) in response.headers.allValues() {
                            print(key, value)
                        }
                    }
        }
    }
    
    func getNonExistingUser() {
        guard let url = URL(string: "https://reqres.in/api/users/100") else { return }
     
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let response = results.response {
                if response.httpStatusCode != 200 {
                    print("\nRequest failed with HTTP status code", response.httpStatusCode, "\n")
                }
            }
        }
    }

    
    //FAKE/PRACTICE: Creates a POST request. Fake, but will return a proper response.
    func createUser() {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
     
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: "John", forKey: "name")
        rest.httpBodyParameters.add(value: "Developer", forKey: "job")
     
        rest.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 201 {
                guard let data = results.data else { return }
                let decoder = JSONDecoder()
                guard let jobUser = try? decoder.decode(JobUser.self, from: data) else { return }
                print(jobUser.description)
            }
        }
    }
    
    
    func getSingleUser() {
        guard let url = URL(string: "https://reqres.in/api/users/1") else { return }
     
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let singleUserData = try? decoder.decode(SingleUserData.self, from: data),
                    let user = singleUserData.data,
                    let avatar = user.avatar,
                    let url = URL(string: avatar) else { return }
     
                self.rest.getData(fromURL: url, completion: { (avatarData) in
                    guard let avatarData = avatarData else { return }
                    let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                    let saveURL = cachesDirectory.appendingPathComponent("avatar.jpg")
                    try? avatarData.write(to: saveURL)
                    print("\nSaved Avatar URL:\n\(saveURL)\n")
                })
     
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
