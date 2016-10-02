module Main exposing (..)

import Html exposing (Html, div, button, text)
import Navigation
import Routing exposing (Route(..))


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , update = update
        , view = view
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    {}


empty : Model
empty =
    Model


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        route =
            Routing.routeFromResult result
    in
        case route of
            MainRoute ->
                ( empty, Cmd.none )

            NotFoundRoute ->
                ( empty, Cmd.none )


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    init result



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ text "It works" ]
