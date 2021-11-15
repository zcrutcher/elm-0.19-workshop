module Main exposing (main)

-- NOTE: Make sure to follow the instructions in the README for part3
-- to install the elm/browser package before running elm make!
--
-- FYI: 👇 You can see our new `Article` module in `src/Article.elm`

import Article
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL


initialModel =
    { tags = Article.tags
    , selectedTag = "elm"
    , allArticles = Article.feed
    }



-- UPDATE

type Msg =
    UpdateCurrentlySelected String


update msg model =
    case msg of 
        UpdateCurrentlySelected selected ->
            {model | selectedTag = selected}



-- VIEW


view model =
    let
        {- 👉 TODO: Filter the articles down to only the ones
                    that include the currently selected tag.

           💡 HINT: Replace `True` below with something involving
                    `List.member`, `article.tags`, and `model.selectedTag`

                    Docs for List.member: http://package.elm-lang.org/packages/elm-lang/core/latest/List#member
        -}
        articles =
            List.filter (\article -> List.member model.selectedTag article.tags)
                model.allArticles

        feed =
            List.map viewArticle articles
    in
    div [ class "home-page" ]
        [ viewBanner
        , div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] feed
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p [] [ text "Popular Tags" ]
                        , viewTags model
                        ]
                    ]
                ]
            ]
        ]


viewArticle article =
    div [ class "article-preview" ]
        [ h1 [] [ text article.title ]
        , p [] [ text article.description ]
        , span [] [ text "Read more..." ]
        ]


viewBanner =
    div [ class "banner" ]
        [ div [ class "container" ]
            [ h1 [ class "logo-font" ] [ text "conduit" ]
            , p [] [ text "A place to share your knowledge." ]
            ]
        ]


viewTag selectedTagName tagName =
    let
        otherClass =
            if tagName == selectedTagName then
                "tag-selected"

            else
                "tag-default"
    in
    button
        [ class ("tag-pill " ++ otherClass) , onClick (UpdateCurrentlySelected tagName)]
        [ text tagName ]
{- 👉 TODO: Add an `onClick` handler which sends a msg
                    that our `update` function above will use
                    to set the currently selected tag to `tagName`.

           💡 HINT: It should look something like this:

                    , onClick { description = … , data = … }

                    👆 Don't forget to add a comma before `onClick`!
        -}

viewTags model =
    div [ class "tag-list" ] (List.map (viewTag model.selectedTag) model.tags)



-- MAIN


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
