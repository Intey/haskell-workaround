module RecurData (
Tree(..),
singleton,
treeInsert,
treeElem,
List,
) where

import Functor'
-- Just list
-- data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)

-- define infix (r - right) op, with 5 priority
infixr 5 :-:
-- List with infix operator - now ':-:' is constructor for List
data List a = Empty | a :-: (List a) deriving (Read, Eq, Ord)

-- list concat. Declare with recursion, by ejecting first element, add recur to
-- rest + target
-- as ':-:' is List type constructor, we can pattern match on it
infixr 5 .++
(.++) :: List a -> List a -> List a
Empty .++ ys = ys
(x :-: xs) .++ ys = x :-: (xs .++ ys)

-- define show interface for own list
-- use hidden recursion function, that has specific interface
instance (Show a) => Show (List a) where
  show Empty = "[]"
  show xs = showRest xs True

-- without typeclass trait `(Show a) =>` we get error - No instance for (Show a).
-- because it's can't determine is `a` is showable
-- `show x` returns to instance with `(a :-: Empty)`.
-- Use additional parameter `IsLastElement` - on first recursion call - its
-- must be true, otherwise - false. With that we determine when to show square
-- braces
type IsLastElement = Bool
showRest :: (Show a) => (List a) -> IsLastElement -> String
showRest (x :-: Empty) False = show x ++ "]"
showRest (x :-: Empty) True = "[" ++ show x ++ "]"
showRest (x :-: xs) True = "[" ++ show x ++ "," ++ showRest xs False
showRest (x :-: xs) False = show x ++ "," ++ showRest xs False
-------------------------------------------------------------------------------

-- Declare binary tree recursively
data Tree a = EmptyTree | Node a (Tree a) (Tree a) -- deriving (Show)
-- custom views
instance (Show a) => Show (Tree a) where
  show EmptyTree = "ø"
  show (Node a EmptyTree EmptyTree) = show a
  show (Node a b c) = showNode "\t"

type Pad = String
showNode :: Tree -> Pad -> String
showNode (Node a b c) pad = pad ++ show a ++ "\n" ++ pad ++ show b "\n" ++ pad ++ show c

-- create tree with only one element
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

-- insertions. Just create singleton, when inserting in Empty Tree
-- When insert in singleton - compare with root node.
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a  = Node a (treeInsert x left) right
  | x > a  = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a  = treeElem x left
    | x > a  = treeElem x right

instance Functor' Tree where
  fmap' f EmptyTree = EmptyTree
  fmap' f (Node a b c) = Node (fmap' f a) (fmap' f c)

main = do
  putStrLn $ show $ foldr treeInsert EmptyTree [1,2]
  putStrLn "====="
  putStrLn $ show $ foldr treeInsert EmptyTree [1,5,2]
  putStrLn "====="
  putStrLn $ show $ foldr treeInsert EmptyTree [1,6,3,5,2]
