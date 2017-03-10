//
//  GameSettings.swift
//  BatInvasion
//
//  Created by Aleksander Makedonski on 3/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit


class GameOptions{
    enum GamePlayMode{
        case NoTimeLimit
        case UnlimitedBullets
    }
    
    enum GameDifficulty{
        case Hard, Medium, Easy
    }
}

class GameSettings{
    
    static let sharedInstance = GameSettings()
    
    //MARK: Private Class Constants
    private let defaults = UserDefaults.standard
    private let keyFirstRun = "FirstRun"
    private let keyTotalRunningTime = "TotalRunningTime"
    private let keyTotalNumberOfBulletsFired = "TotalNumberOfBulletsFired"
    private let keyTotalNumberOfKills = "TotalNumberOfKills"
    
    //MARK: User settings
    private let keyDifficultyLevel = "DifficultyLevel"
    private let keyGamePlayMode = "GamePlayMode"
    
    
    //MARK: Namespaced-GamePlay Mode Settings
    class GamePlayMode{
        static let valueNoTimeLimit = "NoTimeLimit"
        static let valueUnlimitedBullets = "UnlimitedBullets"
    }
    
    //MARK: Namespaced-Difficulty Settings
    class Difficulty{
        static let valueHard = "Hard"
        static let valueMedium = "Medium"
        static let valueEasy = "Easy"
    }
    
    
    //MARK: Namespaced-Level Constants
    class Level1{
        static let keyTotalRunningTime = "Level1RunningTime"
        static let keyNumberOfKills = "Level1NumberOfKills"
        static let keyNumberOfBulletsFired = "Level1NumberOfBulletsFired"
    }
    
    //MARK: Init
    init(){
        if (defaults.object(forKey: keyFirstRun) != nil){
            firstLaunch()
        }
    }
    
    //MARK: Private helper methods
    private func firstLaunch(){
        //Initialize global keys
        defaults.set(0.00, forKey: keyTotalRunningTime)
        defaults.set(0, forKey: keyTotalNumberOfBulletsFired)
        defaults.set(0, forKey: keyTotalNumberOfKills)
        defaults.set(Difficulty.valueEasy, forKey: keyDifficultyLevel)
        defaults.set(GamePlayMode.valueUnlimitedBullets, forKey: keyGamePlayMode)
        
        //Initialize keys for Level1
        defaults.set(0.00, forKey: Level1.keyTotalRunningTime)
        defaults.set(0, forKey: Level1.keyNumberOfKills)
        defaults.set(0, forKey: Level1.keyNumberOfBulletsFired)
        
        defaults.setValue(false, forKey: keyFirstRun)

        defaults.synchronize()
    }
    
    
   
    
    //MARK: Public Method for Game-Wide Settings
    
    func setGamePlayMode(gamePlayMode: GameOptions.GamePlayMode){
        switch(gamePlayMode){
            case .NoTimeLimit:
                defaults.set(GamePlayMode.valueNoTimeLimit, forKey: keyGamePlayMode)
                break
            case .UnlimitedBullets:
                defaults.set(GamePlayMode.valueUnlimitedBullets, forKey: keyGamePlayMode)
                break
        }
        
        defaults.synchronize()
    }
    
    func setGameDifficultyLevel(difficulty: GameOptions.GameDifficulty){
        switch(difficulty){
            case .Hard:
                defaults.set(Difficulty.valueHard, forKey: keyDifficultyLevel)
                break
            case .Medium:
                defaults.set(Difficulty.valueMedium, forKey: keyDifficultyLevel)
                break
            case .Easy:
                defaults.set(Difficulty.valueEasy, forKey: keyDifficultyLevel)
                break
        }
        
        defaults.synchronize()
    }
    
    //MARK: Public Retrieval Methods for Game-Wide Settings
    func getGamePlayMode() -> GameOptions.GamePlayMode?{
        let gamePlayModeString = getGamePlayModeString()
        
        if(gamePlayModeString == GamePlayMode.valueNoTimeLimit){
            return GameOptions.GamePlayMode.NoTimeLimit
        }
        
        if(gamePlayModeString == GamePlayMode.valueUnlimitedBullets){
            return GameOptions.GamePlayMode.UnlimitedBullets
        }
        
        return nil
    }
    
    
    private func getGamePlayModeString() -> String{
        return defaults.value(forKey: keyGamePlayMode)! as! String
    }
    
    
    func getGameDifficulty() -> GameOptions.GameDifficulty?{
        
        let gameDifficultyString = getGameDifficultyString()
        
        if(gameDifficultyString == Difficulty.valueHard){
            return GameOptions.GameDifficulty.Hard
        }
        
        if(gameDifficultyString == Difficulty.valueMedium){
            return GameOptions.GameDifficulty.Medium
        }
        
        if(gameDifficultyString == Difficulty.valueEasy){
            return GameOptions.GameDifficulty.Easy
        }
        
        return nil
    }
    
    private func getGameDifficultyString() -> String{
        return defaults.value(forKey: keyDifficultyLevel)! as! String
    }
    
    
    //MARK: Public retrieval methods for Full Game Stats
    func getTotalRunningTime() -> Double{
        return defaults.value(forKey: keyTotalRunningTime)! as! Double
    }
    
    func getTotalNumberOfBulletsFired() -> Int{
        return defaults.value(forKey: keyTotalNumberOfBulletsFired)! as! Int
    }
    
    func getTotalNumberOfKills() -> Int{
        return defaults.value(forKey: keyTotalNumberOfKills)! as! Int
    }
    
    
    //MARK: Public Saving Methods for Full Game Stats
    func saveTotalRunningTime(totalRunningTime: Double){
        defaults.set(totalRunningTime, forKey: keyTotalRunningTime)
        defaults.synchronize()
    }
    
    func saveTotalNumberOfBulletsFired(totalBulletsFired: Int){
        defaults.set(totalBulletsFired, forKey: keyTotalNumberOfBulletsFired)
        defaults.synchronize()
    }
    
    func saveTotalNumberOfKills(totalNumberOfKills: Int){
        defaults.set(totalNumberOfKills, forKey: keyTotalNumberOfKills)
        defaults.synchronize()
    }
    
    //MARK: Public Retrieval Methods for Game-Level Stats
    func getLevel1RunningTime() -> Double{
        return defaults.value(forKey: Level1.keyTotalRunningTime)! as! Double
    }
    
    func getLevel1TotalBulletsFired() -> Int{
        return defaults.value(forKey: Level1.keyNumberOfBulletsFired)! as! Int
    }
    
    func getLevel1TotalKills() -> Int{
        return defaults.value(forKey: Level1.keyNumberOfKills)! as! Int
    }
    
    //MARK: Public Saving Methods For Game-Level Stats
    func saveLevel1RunningTime(runningTime: Double){
        defaults.set(runningTime, forKey: Level1.keyTotalRunningTime)
        defaults.synchronize()
    }
    
    func saveLevel1TotalBulletsFired(totalBulletsFired: Int){
        defaults.set(totalBulletsFired, forKey: Level1.keyNumberOfBulletsFired)
        defaults.synchronize()
    }
    
    func saveLevel1TotalKills(totalKills: Int){
        defaults.set(totalKills, forKey: Level1.keyNumberOfKills)
        defaults.synchronize()
    }
    
    
}
