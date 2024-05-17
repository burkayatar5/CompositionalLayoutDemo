//
//  CreateViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Burkay Atar on 6.05.2024.
//

import UIKit
///BuiltIn segment is default.
class CreateViewController: UIViewController {
    
    private var builtInData = BuiltInDataModel()
    private var customData = CustomDataModel()

    private var collectionView: UICollectionView! = nil
    private var segmentedControl: UISegmentedControl! = nil
    
    private var dataSourceBuiltIn: UICollectionViewDiffableDataSource<BuiltInDataModel.BuiltInWorkouts, BuiltInDataModel.Workout>! = nil
    private var currentSnapshotBuiltIn: NSDiffableDataSourceSnapshot<BuiltInDataModel.BuiltInWorkouts, BuiltInDataModel.Workout>! = nil
    
    private var dataSourceCustom: UICollectionViewDiffableDataSource<CustomDataModel.CustomWorkouts, CustomDataModel.Workout>! = nil
    private var currentSnapshotCustom: NSDiffableDataSourceSnapshot<CustomDataModel.CustomWorkouts, CustomDataModel.Workout>! = nil
    
    private var customLayout: UICollectionViewLayout! = nil
    private var listLayout: UICollectionViewLayout! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Compositional Layout"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        
        customLayout = createBuiltInLayout()
        listLayout = createListLayout()
        
        configureSegmentedControl()
        configureCollectionView()
        configureConstraints()
        configureCustom()
        configureBuiltIn()
    }
}

///Configuring UI elements and layout constraints
extension CreateViewController {
    private func configureSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Built In","Custom"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(sender:)), for: .valueChanged)
        view.addSubview(segmentedControl)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

///Data and view configurations.
extension CreateViewController {
    
    private func configureBuiltIn() {
        createBuiltInDataSource()
        supplementProviderBuiltIn()
        configureSnapshotBuiltIn()
    }
    
    private func configureCustom() {
        createCustomDataSource()
        supplementProviderCustom()
        configureSnapshotCustom()
    }
}

///BuiltIn Segment Related Functions
extension CreateViewController {
    
    private func createBuiltInLayout() -> UICollectionViewLayout {

        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                      heightDimension: .fractionalHeight(1.0))
        //item
        let builtInItem: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                                       heightDimension: .absolute(250))
        
        let builtInGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                                       subitems: [builtInItem])
        
        builtInGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        //section
        let section = NSCollectionLayoutSection(group: builtInGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.interGroupSpacing = 10
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HeaderCollectionReusableView.identifier, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        //layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    /// Create and register built in segment cell
    /// - Returns: Built in cell confiuration with given cell view and cell model type.
    private func registerBuiltInCell() -> UICollectionView.CellRegistration<BuiltInCollectionViewCell, BuiltInDataModel.Workout> {
        //cell configuration
        
        let cellRegistration = UICollectionView.CellRegistration<BuiltInCollectionViewCell, BuiltInDataModel.Workout> { cell, indexPath, workoutItem in
            // Populate the cell with our item.
            cell.titleLabel.text = workoutItem.title
            cell.explanationLabel.text = workoutItem.explanation
            
            var contentConfiguration = cell.defaultBackgroundConfiguration()
            contentConfiguration.cornerRadius = 30
            contentConfiguration.backgroundColor = .systemGray
            cell.backgroundConfiguration = contentConfiguration
        }
        
        /* Can be used as well for simple cell layouts.
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, BuiltInDataModel.Workout> { cell, indexPath, workoutItem in
            
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = workoutItem.title
            contentConfiguration.secondaryText = workoutItem.title
            
            var backgroundContent = cell.defaultBackgroundConfiguration()
            backgroundContent.backgroundColor = .systemGray
            backgroundContent.cornerRadius = 30
            
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = backgroundContent
        }
        */
        
        return cellRegistration
    }
    
    /// Create built in data source using cell we want the register.
    private func createBuiltInDataSource() {
        let cellRegistration = self.registerBuiltInCell()
        dataSourceBuiltIn = UICollectionViewDiffableDataSource<BuiltInDataModel.BuiltInWorkouts, BuiltInDataModel.Workout>(collectionView: collectionView) {
           [weak self] (collectionView: UICollectionView, indexPath: IndexPath, identifier: BuiltInDataModel.Workout) -> UICollectionViewCell? in
            // Return the cell.
            return self?.collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    /// - Returns: header view, configured with given resuable view.
    private func headerRegistrationBuiltIn() -> UICollectionView.SupplementaryRegistration<HeaderCollectionReusableView> {
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderCollectionReusableView>(elementKind: HeaderCollectionReusableView.identifier) { [weak self] supplementaryView, elementKind, indexPath in
            if let snapshot = self?.currentSnapshotBuiltIn {
                // Populate the view with our section's description.
                let workoutCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = workoutCategory.title
            }
        }
        return headerRegistration
    }
    
    /// Supplement header view to the given data source
    private func supplementProviderBuiltIn() {
        let headerRegistration = self.headerRegistrationBuiltIn()
        dataSourceBuiltIn.supplementaryViewProvider = { [weak self] (view, kind, index) in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
        }
    }
    
    /// Snapshot configuration for data display.
    private func configureSnapshotBuiltIn() {
        currentSnapshotBuiltIn = NSDiffableDataSourceSnapshot<BuiltInDataModel.BuiltInWorkouts, BuiltInDataModel.Workout>()
        builtInData.collections.forEach { [weak self] in
            let collection = $0
            self?.currentSnapshotBuiltIn.appendSections([collection])
            self?.currentSnapshotBuiltIn.appendItems(collection.workouts)
        }
        dataSourceBuiltIn.apply(currentSnapshotBuiltIn, animatingDifferences: false)
    }
}

///Custom Segment Related Functions
extension CreateViewController {
    
    /// - Returns: CollectionViewLayout for list appearance.
    private func createListLayout() -> UICollectionViewLayout {
        /*
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
         */
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            
            var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            config.headerMode = .supplementary
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: HeaderCollectionReusableView.identifier,
                alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        
        return layout
    }
    
    /// Create and register custom segment cell
    /// - Returns: Custom cell confiuration with given cell view and cell model type.
    private func registerCustomCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, CustomDataModel.Workout> {
        //Cell configuration
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CustomDataModel.Workout> { (cell, indexPath, workoutItem) in
            // Populate the cell with custom workout names.
            var content = cell.defaultContentConfiguration()
            content.text = workoutItem.title
            content.secondaryText =  "Avaliable Content: " + String(describing: workoutItem.detail.count)
            
            cell.contentConfiguration =  content
            cell.accessories = [.disclosureIndicator()]
            
        }
        return cellRegistration
    }
    
    /// Create custom data source using cell we want the register.
    private func createCustomDataSource() {
        let cellRegistration = self.registerCustomCell()
        dataSourceCustom = UICollectionViewDiffableDataSource<CustomDataModel.CustomWorkouts, CustomDataModel.Workout>(collectionView: collectionView) {
            [weak self] (collectionView: UICollectionView, indexPath: IndexPath, identifier: CustomDataModel.Workout) -> UICollectionViewCell? in
            // Return the cell.
            return self?.collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    /// - Returns: header view, configured with given resuable view.
    /// Key point is here that you need to specify the header type you want to register when creating layout otherwise you will get an elementKind mismatch error.
    private func headerRegistrationCustom() -> UICollectionView.SupplementaryRegistration<HeaderCollectionReusableView> {
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderCollectionReusableView>(elementKind: HeaderCollectionReusableView.identifier) { [weak self] supplementaryView, elementKind, indexPath in
            if let customSnapshot = self?.currentSnapshotCustom {
                let customWorkouts = customSnapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = customWorkouts.title
            }
        }
        return headerRegistration
    }
    
    /// Supplement header view to the given data source
    private func supplementProviderCustom() {
        let headerRegistration = self.headerRegistrationCustom()
        dataSourceCustom.supplementaryViewProvider = { [weak self] (view, kind, index) in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
        }
    }
    
    /// Snapshot configuration for data display.
    private func configureSnapshotCustom() {
        currentSnapshotCustom = NSDiffableDataSourceSnapshot<CustomDataModel.CustomWorkouts, CustomDataModel.Workout>()
        customData.collections.forEach { [weak self] in
            let collection = $0
            self?.currentSnapshotCustom.appendSections([collection])
            self?.currentSnapshotCustom.appendItems(collection.workouts)
        }
        dataSourceCustom.apply(currentSnapshotCustom, animatingDifferences: false)
    }
}

///Segmented Control related methods
extension CreateViewController {
    @objc
    private func segmentValueChanged(sender: UISegmentedControl ) {
        switch sender.selectedSegmentIndex {
            case 0:
                collectionView.dataSource = dataSourceBuiltIn
                collectionView.setCollectionViewLayout(customLayout, animated: false)

                //Also works
                //collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: true)
            
                scrollToFirstItems(dataSource: dataSourceBuiltIn)
                scrollToTop(dataSource: dataSourceBuiltIn)
            case 1:
                collectionView.dataSource = dataSourceCustom
                collectionView.setCollectionViewLayout(listLayout, animated: false)
            default:
                print("default triggered.")
        }
    }
    
    private func scrollToTop<SectionType: Hashable & Sendable, ItemType: Hashable & Sendable>(dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>) {
        
        guard let dataSource = collectionView.dataSource as? UICollectionViewDiffableDataSource<SectionType, ItemType> else {
            return
        }
        
        if let firstSection = dataSource.snapshot().sectionIdentifiers.first,
           let firstItem = dataSource.snapshot().itemIdentifiers(inSection: firstSection).first {
            collectionView.scrollToItem(at: dataSource.indexPath(for: firstItem) ?? IndexPath(row: 0, section: 0),
                                        at: .centeredVertically,
                                        animated: true)
            //Also works
            //collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: true)
        }
    }
    
    private func scrollToFirstItems<SectionType: Hashable & Sendable, ItemType: Hashable & Sendable>(dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>) {
        
        guard let dataSource = collectionView.dataSource as? UICollectionViewDiffableDataSource<SectionType, ItemType> else {
            return
        }
        
        for sectionIndex in 0..<dataSource.numberOfSections(in: collectionView) {
            let indexPath = IndexPath(item: 0, section: sectionIndex)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
    }
}
