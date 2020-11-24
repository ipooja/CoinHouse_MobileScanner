//
//  LookUpVC.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import UIKit

class LookUpVC: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lookUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var homeViewModel: AddressVM?
    
    var searchText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recheckVM()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.textField.text = ""
        searchText = ""
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func recheckVM() {
        if homeViewModel == nil {
            homeViewModel = AddressVM(repo: AddressApiCallRepo())
        }
    }
    
    @IBAction func lookUpbuttonTapped() {
        if searchText != nil && !searchText.isEmpty {
            if let viewModel = homeViewModel {
                self.view.endEditing(true)
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                viewModel.getScreenData { (boolFlag, message) in
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    if boolFlag {
                        let pushView = UIStoryboard.loadViewController(storyBoardName: "Main", identifierVC: "TransactionViewController", type: TransactionViewController.self)
                        pushView.dataModel = self.homeViewModel?.dataModel
                        self.navigationController?.pushViewController(pushView, animated: true)
                    } else {
                        self.showAlert(message)
                    }
                }
            }
        } else {
            showAlert()
        }
    }
    
    func showAlert(_ message: String? = "Please enter some value in textfield to lookup.") {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                break
            }}))
        self.present(alert, animated: true, completion: nil)
    }    
}


extension LookUpVC: UITextFieldDelegate {
    // MARK: - TextField Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        searchText = txtAfterUpdate
        print(txtAfterUpdate)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}


extension UIStoryboard {
    class func loadViewController<T: UIViewController>(storyBoardName: String, identifierVC: String, type: T.Type, function: String = #function) -> T {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifierVC) as? T else {
            fatalError("ViewController with identifier \(identifierVC), not found in  Storyboard.\nFile : \(storyBoardName) \n\nFunction : \(function)")
        }
        return controller
    }
}
