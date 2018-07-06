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
    -- pages
    match "content/pages/*.md" $ do
        route contentMarkdownRoute
        compile $ mathCompiler
            >>= loadAndApplyTemplate "templates/default.html" postCtx
        --    >>= relativizeUrls
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
    match "content/posts/*/**" $ version "raw" $ do
        route contentRoute
        compile copyFileCompiler
{-
    match "files/*" $ version "raw" $ do
        route   idRoute
        compile copyFileCompiler
    create ["archive.html"] $ do
        route idRoute
        compile $ do
            let archiveCtx =
                    field "posts" (\_ -> postList recentFirst) `mappend`
                    constField "title" "Archives"              `mappend`
                    titleField    "htmltitle"                  `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls
-}
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
                                                                    
betterTitleField :: Context String
betterTitleField = Context $ \k _ i -> 
    if (k /= "title")
    then do empty
    else do value <- getMetadataField (itemIdentifier i) "title"
            return $ StringField (mathdocInline $ if isNothing value then "" else fromJust value)

sourceField key = field key $
    fmap (maybe empty (sourceUrl . toUrl)) . getRoute . itemIdentifier

sourceUrl xs = (take (length xs - 4) xs) ++ "md"

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    sourceField "source"  `mappend`
    htmlTitleField        `mappend`
    dateField "date" "%F" `mappend`
    bodyField     "body"  `mappend`
    betterTitleField      `mappend`
    defaultContext        `mappend`
    constField "tags"  "" `mappend`
    missingField
--------------------------------------------------------------------------------
postList :: ([Item String] -> Compiler [Item String]) -> Compiler String
postList sortFilter = do
    posts   <- sortFilter =<< loadAll ("content/posts/*/*.md" .&&. hasNoVersion)
    --posts   <- loadAll ("content/posts/*/*.md" .&&. hasNoVersion)
    itemTpl <- loadBody "templates/post-item.html"
    list    <- applyTemplateList itemTpl postCtx posts
    return list
