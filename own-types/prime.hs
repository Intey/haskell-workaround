
-- Typeclass - interface

-- data type (Type) - is types list, os one level tree

-- Value constructor - least of single types tree. Is right part of assign in
-- type declaration. Its can get type-template (type variable) or not

-- type constructors - just names, or 'type-context'. This is a one of possible
-- labels for type. On type can have as many type constructors as needed.
-- We can think, that type - is typeclass, and Type-Constructor - concrete type

-- simple type with 4 'type constructors'
-- new Types declared tiwh 'data' keyword
data Lights = Red | Green | Blue | Purple
-- aliasing type
type Color = Lights

-- declare Show interface realization for Lights class. we we try to show
-- something  of Lights type, it will use this "function"
instance Show Lights where
  show Red = "stop"
  show Green = "go"
  show Blue = "wtf?"
  show Purple = "deeeeep"

-- declare typeclass(interface) with mutual recursion declaration. When
-- instantiate, just implement one of `==` or `/=`
-- declared in Prelude

-- class Eq a where
--   (==) :: a -> a -> Bool
--   (/=) :: a -> a -> Bool
--   x == y = not (x /= y)
--   x /= y = not (x == y)

-- Instantiate typeclass `Eq` for DataType `Maybe`, for each it's type var `m`
-- which is instance of Eq.
-- declared in Prelude

-- instance (Eq m) => Eq (Maybe m) where
--   Just x == Just y = x == y
--   Nothing == Nothing = True
--   _ == _ = False


-- Same as Either
-- a b - type parameters, template vars, etc.
-- data Either a b = Right a | Left b
-- with type parameters, we can decouple our type (`Either`) from it's
-- paramenters type. Instead `a`, `b` we can use any type. In other functions
-- we can use this as "i don't doubt about its type parametars types".
-- But we do something with type parameters, some operations, or use functions
-- from some typeclasses, we should insert typeclass constrain (Eq a => ...) in
-- our function.

-- example function
myFn :: (Either a b) -> (Either b a)
myFn (Right a) = Left a
myFn (Left a) = Right a
