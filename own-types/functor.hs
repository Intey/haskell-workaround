module Functor (
Functor',
) where


import qualified Data.Map as Map
-- Declare functor typeclass. Type, that implements this typeclass, should
-- realize `fmap'` which takes `b function(a);` and element of type `a`, evals
-- and returns `b`
-- Otherwise, we can this of f as Type constructor, for example - `Maybe`. It's
-- takes 1 argument and return concrete thing
-- We can think about this as, as function, that apply other one to object with
-- type a
-- its like simple `map`. For example, we can implement this for binary-tree,
-- and apply `f` to each node
class Functor' f where
  fmap' :: (a -> b) -> f a -> f b

-- implement this typeclass for lists. Just like a map
instance Functor' [] where
  fmap' = map

-- for `Maybe`, go in this box, apply function for value and return same box, with type
-- we can write like this
-- `instance Functor' (Maybe m) where` but we can't because in this case,
-- `Maybe m` is concrete, so it's can't binds in Functor' declaration.
-- In this case, we suppose, that: `(a -> b) -> Maybe m a -> Maybe m b` - it's
-- bullshit.
instance Functor' Maybe where
  fmap' f (Just x) = Just (f x)
  fmap' f Nothing = Nothing

instance Functor' (Either a) where
  fmap' f (Right a) = Right (f a)
  fmap' f (Left a) = Left a


instance Functor' (Map.Map k) where
  fmap' f m = fmap f m

-- usage
main = do
  let objectStr val = ("[Object " ++ val ++ "]")
  fmap' objectStr (Just "thing")

