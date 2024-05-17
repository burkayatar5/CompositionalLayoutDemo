//
//  CustomDataModel.swift
//  CompositionalLayoutDemo
//
//  Created by Burkay Atar on 8.05.2024.
//

import Foundation

class CustomDataModel {
    
    struct WorkoutDetail: Hashable {
        var identifier: UUID = UUID()
        var title: String
        var explanation: String
        var video: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct Workout: Hashable {
        var identifier: UUID = UUID()
        var title: String
        var detail: [WorkoutDetail]
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct CustomWorkouts: Hashable {
        var identifier: UUID = UUID()
        var title: String
        var workouts: [Workout]
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    var collections: [CustomWorkouts] {
        return _collections
    }
    
    init() {
        generateCollections()
    }
    
    fileprivate var _collections = [CustomWorkouts]()
}

extension CustomDataModel {
    private func generateCollections() {
        _collections = [
            CustomWorkouts(title: "Workout List",
                           workouts: [ Workout(title: "Arm Workouts",
                                               detail: [ WorkoutDetail(title: "Arm 1",
                                                                       explanation: "Arm explanation 1",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Arm 2",
                                                                       explanation: "Arm explanation 2",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Arm 3",
                                                                       explanation: "Arm explanation 3",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Arm 4",
                                                                       explanation: "Arm explanation 4",
                                                                       video: "armWorkoutVideo")
                                               ]),
                                       Workout(title: "Leg Workouts",
                                               detail: [ WorkoutDetail(title: "Leg 1",
                                                                       explanation: "Leg explanation 1",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Leg 2",
                                                                       explanation: "Leg explanation 2",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Leg 3",
                                                                       explanation: "Leg explanation 3",
                                                                       video: "armWorkoutVideo")
                                               ]),
                                       Workout(title: "Core Workouts",
                                               detail: [ WorkoutDetail(title: "Core 1",
                                                                       explanation: "Core explanation 1",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Core 2",
                                                                       explanation: "Core explanation 2",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Core 3",
                                                                       explanation: "Arm explanation 3",
                                                                       video: "armWorkoutVideo")
                                               ]),
                                       Workout(title: "Back Workouts",
                                               detail: [ WorkoutDetail(title: "Back 1",
                                                                       explanation: "Back explanation 1",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Back 2",
                                                                       explanation: "Back explanation 2",
                                                                       video: "armWorkoutVideo"),
                                                         WorkoutDetail(title: "Back 3",
                                                                       explanation: "Back explanation 3",
                                                                       video: "armWorkoutVideo")
                                               ]),
                           ])
        ]
    }
}

