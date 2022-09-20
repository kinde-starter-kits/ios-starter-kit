import UIKit

/// Present an error alert with the given message and print it to the console
func alert(message: String, viewController: UIViewController) {
    let defaultAction = UIAlertAction(title: "OK",
                            style: .default)
    
    let alert = UIAlertController(title: "Error",
             message: message,
             preferredStyle: .alert)
    alert.addAction(defaultAction)
    
    print(message)
    viewController.present(alert, animated: true)
}
