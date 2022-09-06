--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
import           Data.Monoid (mappend, Monoid (..))
import           Hakyll
import           Hakyll.Core.Compiler
import           Hakyll.Web.Html
import           System.FilePath.Posix
import           Text.Pandoc
import           MathDoc
import           Control.Monad
import           Control.Applicative        ((<$>), Alternative (..), (<$>))
import           Data.Maybe
import Data.Monoid
--------------------------------------------------------------------------------
import System.Directory
import Debug.Trace

contentRoute = gsubRoute "content/" (const "")
contentMarkdownRoute = composeRoutes contentRoute (setExtension "html")

main :: IO ()
main = do
  hakyll $ do
    -- static resources
    match (fromList idPages) $ do
        route   idRoute
        compile copyFileCompiler
    -- css
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler
    -- markdown pages
    match "content/pages/*.md" $ do
        route contentMarkdownRoute
        compile $ mathCompiler
            >>= loadAndApplyTemplate "templates/default.html" postCtx
        --    >>= relativizeUrls
    -- html pages
    match "content/pages/*.html" $ do
        route contentMarkdownRoute
        compile $ mathCompiler
            >>= loadAndApplyTemplate "templates/default.html" postCtx
    -- posts
    match "content/posts/*/*.md" $ do
        route contentMarkdownRoute
        compile $ mathCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
        --    >>= relativizeUrls
--    -- drafts
--    match "content/drafts/*.md" $ do
--        route contentMarkdownRoute
--        compile $ mathCompiler
--            >>= loadAndApplyTemplate "templates/post.html"    postCtx
--            >>= loadAndApplyTemplate "templates/default.html" postCtx
--        --    >>= relativizeUrls

    -- raw posts
    -- this one is needed to copy over images and other resources for the blog posts
    match "content/posts/*/**" $ version "raw" $ do
        route contentRoute
        compile copyFileCompiler

    match "files/**" $ version "raw" $ do
        route   idRoute
        compile copyFileCompiler

    -- Archive
    match "content/archive.html" $ do
        route contentRoute
        let indexCtx = field "posts" $ \_ ->
                            postList (filterArchived True)
        compile $ getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" (indexCtx `mappend` postCtx)
            --    >>= relativizeUrls
    -- Index
    match "content/index.html" $ do
        route contentRoute
        let indexCtx = field "posts" $ \_ ->
                            postList (filterArchived False)
        compile $ getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" (indexCtx `mappend` postCtx)
            --    >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

filterArchived :: Bool -> [Item String] -> Compiler [Item String]
filterArchived removeArchived items = do
    let predicate :: Item String -> Compiler Bool
        predicate item = do
            m <- getMetadataField (itemIdentifier item) "archived"
            case m of
                Just "true" -> return removeArchived
                _ -> return (not removeArchived)
    filteredItems <- filterM predicate items
    recentFirst filteredItems

mathDoc :: Item String -> Compiler (Item String)
mathDoc = return . fmap mathdoc

mathCompiler = getResourceBody >>= mathDoc
--mathCompiler = getResourceString >>= mathDoc

idPages = ["mathjax_conf.js", "CNAME"]

htmlTitleField :: Context String
htmlTitleField = Context $ \k _ i -> 
    if (k /= "htmltitle")
    then do empty
    else do value <- getMetadataField (itemIdentifier i) "title"
            return $ StringField (if isNothing value then "" else fromJust value)
                                                                    
--defaultField :: String -> Context String
--defaultField f =
--  let fun i = do
--            val <- getMetadataField (itemIdentifier i) f
--            case val of
--                Nothing -> return empty
--                Just a -> return a
--  in field f fun

defaultField f = Context $ \k _ i -> 
    if (k /= f)
    then empty
    else do value <- getMetadataField (itemIdentifier i) f
            case value of
                Nothing -> empty
                (Just a) -> traceShow ("GRESS", a) $ return $ StringField a

defaultMathField :: String -> Context String
defaultMathField f = Context $ \k _ i -> 
    if (k /= f)
    then traceShow ("EMPTY", f, k, itemIdentifier i) empty
    else do value <- traceShow ("GETTING", f, itemIdentifier i) $ getMetadataField (itemIdentifier i) k
            case value of
                Nothing -> traceShow ("NOTHING", f, itemIdentifier i) empty
                (Just a) -> return . StringField $ traceShow ("nisse1", f, itemIdentifier i) (mathdocInline $ traceShow ("nisse2", f, itemIdentifier i) a)

-- | Filepath of the underlying file of the item
relativeDirectoryField :: String -> Context a
relativeDirectoryField key = field key $ return . joinPath . drop 1 . splitPath . dropFileName . toFilePath . itemIdentifier

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    defaultMathField "summary" <>
    dateField "date" "%F" <>
    htmlTitleField        <>
    defaultField "thumbnail" <>
    defaultField "thumbnailtype" <>
    relativeDirectoryField "reldir" <>
    constField "tags"  "" <>
    defaultContext -- this contains all metadata fields, these are overwritten by the fields above when nessescary
--------------------------------------------------------------------------------
postList :: ([Item String] -> Compiler [Item String]) -> Compiler String
postList sortFilter = do
    posts   <- sortFilter =<< loadAll ("content/posts/*/*.md" .&&. hasNoVersion)
    itemTpl <- loadBody "templates/post-item.html"
    list    <- applyTemplateList itemTpl postCtx posts
    return list
