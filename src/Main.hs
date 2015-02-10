module Main where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V

import Data.Csv --from cassava

type BaseballStats = (BL.ByteString, Int, BL.ByteString, Int)

main :: IO ()
main = do
  csvData <- BL.readFile "batting.csv"
  let summed = fmap (V.foldr summer 0) (baseballStats csvData)
  putStrLn $ "Total atBats was " ++ (show summed)
    where summer = (+) . fourth

fourth :: (a,b,c,d) -> d
fourth (_, _, _, d) = d

baseballStats :: BL.ByteString -> Either String (V.Vector BaseballStats)
baseballStats = decode NoHeader
