module Main exposing (..)
import Browser
import Html exposing (Html, div, p, button, text)
import Html.Events exposing (onClick)
import Html exposing (h1)

main : Program () Model Msg
main = Browser.element 
    {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
    }

type Model =
    Loading
    | Loaded Data
    | Failure

type alias Data =
    {
    pings: Int
    }

init: () -> (Model, Cmd Msg)
init _ = 
    (
    Loading,
    Cmd.none
    )

type Msg =
    SubmitLocation
    | Ping

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Ping -> case model of
            Loading -> (Loaded <| Data 0, Cmd.none)
            Loaded data -> (Loaded {data | pings = data.pings + 1}, Cmd.none)
            Failure -> (Failure, Cmd.none)
        SubmitLocation -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

viewPings: Model -> String
viewPings model =
    case model of
        Loading -> "Loading..."
        Failure -> "Failed to load"
        Loaded data -> data.pings |> String.fromInt

view : Model -> Html Msg
view model =
    div [] [
        h1 [] [text "Toby Ueno"],
        p [] [text <| viewPings model],
        button [onClick Ping] [text "Ping!"]
    ]
