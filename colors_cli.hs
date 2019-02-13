import Control.Monad

main = do
  colors <- forM [1..5] (\a -> do
    putStrLn $ "Color for num" ++ show a ++ "?"
    getLine
    )
  putStrLn "colors:"
  -- mapM apply action-function for list
  mapM putStrLn colors
