module Site exposing (..)

import ChildUpdate
import Html exposing (..)
import Html.Attributes exposing (class, src, style)
import Json.Decode exposing ((:=))
import Json.Encode


-- MODEL


type alias Model =
    { pageTitle : String
    , banner : String
    }


decoder : Json.Decode.Decoder Model
decoder =
    Json.Decode.object2 Model
        ("pageTitle" := Json.Decode.string)
        ("banner" := Json.Decode.string)


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
    header [ style [ ( "background-image", "url(" ++ model.banner ++ ")" ) ] ]
        [ div [ class "title" ]
            [ h1 [ class "center white" ] [ text model.pageTitle ]
            ]
        ]
