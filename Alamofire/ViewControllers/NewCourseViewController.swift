
//  ViewController.swift
//  Alamofire
//
//  Created by Vasyl Larin on 24.11.2022.
//

import UIKit

class NewCourseViewController: UIViewController {

    @IBOutlet weak var imageURL: UITextField!
    @IBOutlet weak var courseTitleTF: UITextField!
    @IBOutlet weak var numberOfLessonsTF: UITextField!
    @IBOutlet weak var numberOfTestsTF: UITextField!
    
    var delegate: NewCourseViewControllerDelegate?

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let course = Course(
            name: courseTitleTF.text ?? "Without name",
            imageUrl: imageURL.text ?? "https://r0.mradx.net/img/6C/0C2ADD.jpg",
            numberOfLessons: Int(numberOfLessonsTF.text ?? "") ?? 0,
            numberOfTests: Int(numberOfTestsTF.text ?? "") ?? 0
        )
        delegate?.sendPostRequest(with: course)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

