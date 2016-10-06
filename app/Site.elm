module Site exposing (..)

import ChildUpdate
import Html exposing (..)
import Html.Attributes exposing (src)
import Json.Decode exposing ((:=))
import Json.Encode


-- MODEL


type alias Model =
    { welcome : String
    , logo : String
    }


empty : Model
empty =
    Model "" ""


decode : Json.Encode.Value -> Model
decode data =
    let
        result =
            Json.Decode.decodeValue decoder data
    in
        case result of
            Ok model ->
                model

            Err err ->
                Model err ""


decoder : Json.Decode.Decoder Model
decoder =
    Json.Decode.object2 Model
        ("welcome" := Json.Decode.string)
        ("logo" := Json.Decode.string)



-- UPDATE FOR PARENT


type alias HasOne model =
    { model | site : Model }


updateOne : (Msg -> msg) -> Msg -> HasOne m -> ( HasOne m, Cmd msg )
updateOne =
    ChildUpdate.updateOne update .site (\m x -> { m | site = x })



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text model.welcome
        , img [ src model.logo ] []
        ]
