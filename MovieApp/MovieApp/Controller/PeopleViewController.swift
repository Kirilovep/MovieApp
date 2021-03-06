//
//  PeopleViewController.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
import ExpandableLabel

class PeopleViewController: UIViewController {
    
    //MARK:- Properties -
    var detailedInfoCast: Cast?
    var detailedInfoCrew: Crew?
    var detailId = 0
    var detailPhoto:String?
    private var personInfo: People?
    private var personImages: [Profile] = [] {
        didSet {
            addButton()
        }
    }
    private var moviesForPeople: [PersonMovie] = []
    private let networkManager = NetworkManager()
    
    //MARK:- IBOutlets-
    @IBOutlet weak var knowForLabel: UILabel!
    @IBOutlet weak var graphyLabel: UILabel!
    @IBOutlet weak var moviesLabel: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthdayLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView! {
        didSet {
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
            
            let nib = UINib(nibName: Cells.imageCollectionNib.rawValue, bundle: nil)
            imagesCollectionView.register(nib, forCellWithReuseIdentifier: Cells.imageCollectionCellIdentifier.rawValue)
        }
    }
    @IBOutlet weak var knowsForLabel: UILabel!
    @IBOutlet weak var biographyLabel: ExpandableLabel!
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView.delegate = self
            moviesTableView.dataSource = self
            
            let nib = UINib(nibName: Cells.moviesTableViewCellNib.rawValue, bundle: nil)
            moviesTableView.register(nib, forCellReuseIdentifier: Cells.moviesCellIdentifier.rawValue)
            moviesTableView.rowHeight = 100
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        hidePersonInformation(true)
        parseInfo()
        parseImages()
        parseMovies()
    }
    
    //MARK:- Private methods-
    private func setImagesForCastAndCrew() {
        if let profilePathCast = self.detailedInfoCast?.profilePath {
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePathCast )
            self.characterImage.kf.setImage(with: url)
        } else if let profilePathCrew = self.detailedInfoCrew?.profilePath {
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePathCrew)
            self.characterImage.kf.setImage(with: url)
        } else if let profilePath = personInfo?.profilePath {
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePath)
            self.characterImage.kf.setImage(with: url)
        } else {
            self.characterImage.image = UIImage(named: Images.imageForPeople.rawValue)
        }
    }
    private func parseInfo() {
        networkManager.loadPeople(detailId) { [weak self] (infoPeople) in
            DispatchQueue.main.async {
                self?.personInfo = infoPeople
                self?.updateView()
            }
           
        }
    }
    private func parseImages() {
        networkManager.loadPersonImages(detailId) { [weak self] (images) in
            DispatchQueue.main.async {
                self?.personImages = images
                self?.imagesCollectionView.reloadData()
            }
        }
    }
    private func parseMovies() {
        networkManager.loadMoviesForPeople(detailId) { [weak self] (moviesСast, moviesCrew) in
            DispatchQueue.main.async {
                self?.moviesForPeople = moviesСast ?? []
                self?.moviesForPeople.append(contentsOf: moviesCrew ?? [])
                if let castCount = moviesСast?.count,let crewCount = moviesCrew?.count {
                    self?.tableViewHeight.constant = CGFloat((castCount + crewCount) * 100)
                    self?.moviesTableView.reloadData()
                }
            }
        }
    }
    private func updateView() {
            self.activityIndicator.startAnimating()
            self.hidePersonInformation(false)
            if let infoPeopleCast = self.detailedInfoCast {
                self.nameLabel.text = infoPeopleCast.name
            } else if let infoPeopleCrew = self.detailedInfoCrew {
                self.nameLabel.text = infoPeopleCrew.name
            } else {
                self.nameLabel.text = self.personInfo?.name
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let birthday = self.personInfo?.birthday, let date = dateFormatter.date(from: birthday) {
                dateFormatter.dateFormat = "MMMM dd, yyyy"
                self.birthdayLabel.text = dateFormatter.string(from: date)
            } else {
                self.birthdayLabel.text = "Not available"
            }
            self.placeOfBirthdayLabel.text = self.personInfo?.placeOfBirth
            self.knowsForLabel.text = self.personInfo?.knownForDepartment
            self.biographyLabel.shouldCollapse = true
            self.biographyLabel.numberOfLines = 4
            self.biographyLabel.collapsedAttributedLink = NSAttributedString(
                string: "Show more", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
            )
            self.biographyLabel.expandedAttributedLink = NSAttributedString(
                string: "Show less", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
            )
            self.biographyLabel.text = self.personInfo?.biography
            self.setImagesForCastAndCrew()
            self.activityIndicator.stopAnimating()
    }
    private func hidePersonInformation(_ isHidden: Bool) {
        nameLabel.isHidden = isHidden
        knowsForLabel.isHidden = isHidden
        placeOfBirthdayLabel.isHidden = isHidden
        biographyLabel.isHidden = isHidden
        birthdayLabel.isHidden = isHidden
        characterImage.isHidden = isHidden
        moviesTableView.isHidden = isHidden
        knowForLabel.isHidden = isHidden
        graphyLabel.isHidden = isHidden
        moviesLabel.isHidden = isHidden
    }
    private func addButton() {
        let likeTappedButton = UIBarButtonItem(image: #imageLiteral(resourceName: "like"), style: .plain, target: self, action: #selector(addTapped))
            self.navigationItem.rightBarButtonItem = likeTappedButton
    }
    
    @objc
    private func addTapped() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let movieData = MovieCoreData(context: context)
        movieData.title = personInfo?.name
        movieData.image = personInfo?.profilePath
        movieData.department = personInfo?.knownForDepartment
        let idPeople = Int64(personInfo?.id ?? 0)
        movieData.id = idPeople
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "heart")
    }
}

//MARK:- Collection View extension -
extension PeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.imageCollectionCellIdentifier.rawValue, for: indexPath) as! ImageCollectionViewCell
        cell.configure(personImages[indexPath.row])
        return cell
    }
    
}

extension PeopleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imagesCollectionView {
            return ImageCollectionViewCell.size
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}

//MARK:- Table View extension -
extension PeopleViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesForPeople.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.moviesCellIdentifier.rawValue, for: indexPath) as! MoviesTableViewCell
        cell.configure(moviesForPeople[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = storyboard?.instantiateViewController(withIdentifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
        desVC.detailId = moviesForPeople[indexPath.row].id
        navigationController?.pushViewController(desVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
