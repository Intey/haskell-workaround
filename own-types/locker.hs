import qualified Data.Map as Map

-- declare type of state for locker - something like a chest
data LockerState = Taken | Free deriving (Show, Eq)
-- aliases
type Code = String
-- and our chests: key(Int) -> value(LockerState, Code)
type LockerMap = Map.Map Int (LockerState, Code)

-- search for open locker. Returns value of type `Either`: `Left error` or `Right Code`
lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
  case Map.lookup lockerNumber map of
    Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
    Just (state, code) -> if state /= Taken
      then Right code
      else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"
