-- declare this file as module. Define exports
module MyTime
(
Time,
timeToString
) where

-- declare type 'Time'. Its constructor name - NewTime
data Time h m s = Time {
  hours :: h,
  minutes :: m,
  seconds :: s
  } deriving (Show, Eq, Ord)

-- function timeToString: expects, that type 'v' implements 'Show' typeclass
-- gets object of type 'Time'
-- maps each field value (hours, minutes, seconds) to short vars and implement 'toString'
timeToString :: (Show v) => Time v v v -> String
timeToString (Time {hours = h, minutes = m, seconds = s}) = show h ++ ":" ++ show m ++ ":" ++ show s
