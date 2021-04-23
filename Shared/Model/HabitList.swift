//
//  HabitList.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import Foundation

protocol HabitList {
    var filter: HabitMatcher { get set }
    
    /** Inserts a new habit in the list.
        If the id of the habit is null, the list will assign it a new id, which is guaranteed to be unique in the scope of the list. If id is not null, the caller should make sure that the list does not already contain another habit with same id, otherwise a `Error` will be thrown.
    - Parameter habit: the habit to be inserted
    - Throws: `HabitError.duplicateHabit` if the habit is already on the list.
    */
    func add(habit: Habit) throws
    
    /**
     Returns the habit with specified id.
     
      - Parameter id: the id of the habit
      - Returns: the habit, or `nil` if none exist
     */
    func getById(id: Int) -> Habit?
    
    /**
     Returns the habit with specified uuid.
     
      - Parameter uuid: the `UUID` of the habit
      - Returns: the habit, or `nil` if none exist
     */
    func getByUUID(uuid: UUID) -> Habit?
    
    /**
     Returns the habit that occupies a certain position.
     
      - Parameter position: the position of the desired habit
      - Returns: the habit at that position
      - Throws: `HabitError.positionOutOfIndex` when the position is invalid
     */
    func getByPosition(position: Int) throws -> Habit
}


