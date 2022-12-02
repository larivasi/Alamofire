
//  CoursesTableViewController.swift
//  Alamofire
//
//  Created by Vasyl Larin on 29.11.2022.
//

import UIKit

protocol NewCourseViewControllerDelegate {
    func sendPostRequest(with data: Course)
}

class CoursesTableViewController: UITableViewController {
    
    private var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 125
        fetchCourses()
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newCourseVC = segue.destination as? NewCourseViewController else { return }
        newCourseVC.delegate = self
    }
    
    private func fetchCourses() {
        NetworkManager.shared.fetchCourses(from: Link.coursesURL.rawValue) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.courses = courses
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CoursesTableViewController: NewCourseViewControllerDelegate {
    func sendPostRequest(with data: Course) {
        NetworkManager.shared.sendPostRequest(to: Link.postRequest.rawValue, with: data) { [weak self] result in
            switch result {
            case .success(let course):
                self?.courses.append(course)
                self?.tableView.insertRows(
                    at: [IndexPath(row: (self?.courses.count ?? 0) - 1, section: 0)],
                    with: .automatic)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
