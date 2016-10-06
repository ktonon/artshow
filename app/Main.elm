port module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (class)
import Json.Encode
import Navigation
import Routing exposing (Route(..))
import Site


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
    { site : Site.Model
    }


empty : Model
empty =
    Model Site.empty


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
    = LoadData Json.Encode.Value
    | SiteMessage Site.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadData data ->
            ( { model | site = (Site.decode data) }, Cmd.none )

        SiteMessage cMsg ->
            Site.updateOne SiteMessage cMsg model



-- SUBSCRIPTIONS


port data : (Json.Encode.Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    data LoadData



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "row" ]
        [ div [ class "one-half column" ]
            [ Html.App.map SiteMessage (Site.view model.site) ]
        , div [ class "one-half column" ] [ div [ class "fa fa-car fa-5x" ] [] ]
        ]
