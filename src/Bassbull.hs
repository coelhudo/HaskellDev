module Bassbull where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Foldable as F

import Data.Csv.Streaming --from cassava

type BaseballStats = (BL.ByteString, Int, BL.ByteString, Int)

fourth :: (a,b,c,d) -> d
fourth (_, _, _, d) = d

baseballStats :: BL.ByteString -> Records BaseballStats
baseballStats = decode NoHeader

summer :: (a,b,c,Int) -> Int -> Int
summer = (+) . fourth          
                
getAtBatsSum :: FilePath -> IO Int
getAtBatsSum file = do
  csvData <- BL.readFile file
  return $ F.foldr summer 0 (baseballStats csvData)
