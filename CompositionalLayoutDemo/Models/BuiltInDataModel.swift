//
//  BuiltInMockData.swift
//  CompositionalLayoutDemo
//
//  Created by Burkay Atar on 6.05.2024.
//

import Foundation

class BuiltInDataModel {
    
    struct Workout: Hashable {
        var identifier: UUID = UUID()
        var title: String
        var explanation: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct BuiltInWorkouts: Hashable {
        var identifier: UUID = UUID()
        var title: String
        var workouts: [Workout]
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    var collections: [BuiltInWorkouts] {
        return _collections
    }
    
    init() {
        generateCollections()
    }
    
    fileprivate var _collections = [BuiltInWorkouts]()
}

extension BuiltInDataModel {
    private func generateCollections() {
        _collections = [
            BuiltInWorkouts(title: "Full Body Workouts",
                            workouts: [ Workout(title: "Full Body Title 1", explanation: "Full Body Subtitle 1"),
                                        Workout(title: "Full Body Title 2", explanation: "Full Body Subtitle 2"),
                                        Workout(title: "Full Body Title 3", explanation: "Full Body Subtitle 3"),
                                        Workout(title: "Full Body Title 4", explanation: "Full Body Subtitle 4"),
                                      ]),
            
            BuiltInWorkouts(title: "Lower Body Workouts",
                            workouts: [ Workout(title: "Lower Body Title 1", explanation: "Lower Body Subtitle 1"),
                                        Workout(title: "Lower Body Title 2", explanation: "Lower Body Subtitle 2"),
                                        Workout(title: "Lower Body Title 3", explanation: "Lower Body Subtitle 3"),
                                        Workout(title: "Lower Body Title 4", explanation: "Lower Body Subtitle 4"),
                                      ]),
            
            BuiltInWorkouts(title: "Upper Body Workouts",
                            workouts: [ Workout(title: "Upper Body Title 1", explanation: "Upper Body Subtitle 1"),
                                        Workout(title: "Upper Body Title 2", explanation: "Upper Body Subtitle 2"),
                                        Workout(title: "Upper Body Title 3", explanation: "Upper Body Subtitle 3"),
                                        Workout(title: "Upper Body Title 4", explanation: "Upper Body Subtitle 4"),
                                      ]),
            
            BuiltInWorkouts(title: "Leg Workouts",
                            workouts: [ Workout(title: "Leg Title 1", explanation: "Leg Subtitle 1"),
                                        Workout(title: "Leg Title 2", explanation: "Leg Subtitle 2"),
                                        Workout(title: "Leg Title 3", explanation: "Leg Subtitle 3"),
                                        Workout(title: "Leg Title 4", explanation: "Leg Subtitle 4"),
                                      ])
        ]
    }
}
