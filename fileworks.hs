import System.IO

-- Excected usage
-- ``` ct <- getContentTest "test.list"
-- ``` putStr ct

-- lazy reading. we need to "unlazy" reading. Otherwise - can't read from close
-- file.
-- getContentTest filename = do
--   handle <- openFile filename ReadMode
--   contents <- hGetContents handle
--   hClose handle
--   return contents

-- `withFile'` shown pattern: pass pure functions, that works with content.
-- Functional DI
withFile' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
withFile' path mode f = do
    handle <- openFile path mode
    result <- f handle
    hClose handle
    return result

-- needs to return string
readFile' filename = do
  handle <- openFile filename ReadMode
  contents <- hGetContents handle
  hClose handle
  return contents


-- main = do
--   withFile' "test.list" ReadMode (\handle -> do
--     contents <- hGetContents handle
--     putStr contents)

-- works, but empty results
main = do
  content <- readFile' "test.list"
  putStr content

