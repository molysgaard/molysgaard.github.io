module MathDoc ( mathdoc, mathdocInline, compute) where
import Text.Pandoc
import Text.Regex (mkRegex, matchRegex)
import Data.Maybe
import Text.Pandoc.Writers.HTML
import Data.Set (insert)
import System.Environment (getArgs)
import Data.List (nub, intercalate, isPrefixOf)
import Text.CSL.Pandoc
import System.IO.Unsafe
import Data.Array((!))
import Data.Bits((.|.))
import Data.Either

import qualified Data.Map as M
import Text.Pandoc.CrossRef

import Debug.Trace

setMeta key val (Pandoc (Meta ms) bs) = Pandoc (Meta $ M.insert key val ms) bs

crossRef = go
  where
    go p@(Pandoc meta _) = runCrossRef meta Nothing action p
      where
        action (Pandoc _ bs) = do
          meta' <- crossRefMeta
          bs' <- crossRefBlocks bs
          return $ Pandoc meta' bs'

mathdocRead = def{readerExtensions = insert Ext_tex_math_double_backslash $ 
                                     insert Ext_tex_math_single_backslash $ 
                                     insert Ext_citations $
                                     insert Ext_raw_tex pandocExtensions}
mathdocWrite = def{writerHTMLMathMethod = MathJax "",
                   writerHtml5          = True,
                   writerHighlight      = True,
                   writerNumberSections = True,
                   writerEmailObfuscation = JavascriptObfuscation}

readDoc :: String -> Pandoc
readDoc x = setMeta "linkReferences" (MetaBool True)
--          $ setMeta "autoEqnLabels" (MetaBool True) -- maybe a bit to busy
          $ setMeta "csl" (MetaInlines [Str "ieee.csl"])
          $ setMeta "link-citations" (MetaBool True)
          $ setMeta "reference-section-title" (MetaInlines [Str "References"])
          $ head $ rights [readMarkdown mathdocRead x]

writeDoc :: Pandoc -> String
writeDoc x = writeHtmlString mathdocWrite (unsafePerformIO $ processCites' x)

writeDocT :: Pandoc -> String
writeDocT = writeHtmlString mathdocWrite

mathdoc :: String -> String
mathdoc = compute

mathdocInline :: String -> String
mathdocInline = stripParagraph . writeDocT . crossRef . readDoc
  
compute x = (writeDoc $ bottomUp latex $ crossRef $ readDoc x) ++ "\n"

latex :: Block -> Block
latex x = x

-- strip <p> and </p> of the beginning to the end of the html.
stripParagraph html = if take 3 html == "<p>" 
                        then take (length html - 8) (drop 3 html)
                        else html
