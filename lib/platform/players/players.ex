defmodule Platform.Players do
  alias Platform.Players.Player
  alias Platform.WhiteCards

  def create(attrs) do
    white_cards = WhiteCards.random(10)

    %Player{all_white_cards: white_cards}
    |> Player.changeset(attrs, :create)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  def select_white_card(%Player{} = player, white_card_id, max_picks) do
    white_card = Enum.find(player.all_white_cards, fn card -> card.id == white_card_id end)

    if Enum.find(player.selected_white_cards, fn card -> card.id == white_card_id end) do
      %{player | selected_white_cards: player.selected_white_cards -- [white_card]}
    else
      if length(player.selected_white_cards) < max_picks do
        %{player | selected_white_cards: player.selected_white_cards ++ [white_card]}
      else
        player
      end
    end
  end

  def reset_for_new_round(%Player{} = player) do
    if player.confirmed do
      new_white_cards = player.all_white_cards -- player.selected_white_cards ++ WhiteCards.random(length(player.selected_white_cards))
      %{player | all_white_cards: new_white_cards, selected_white_cards: []}
    else
      %{player | selected_white_cards: []}
    end
  end


  def reset_selected_white_cards(%Player{} = player) do
    if player.confirmed do
      player
    else
      %{player | selected_white_cards: []}
    end
  end

  def get_white_card_index(%Player{} = player, white_card_id) when is_integer(white_card_id) do
    index = Enum.find_index(player.selected_white_cards, fn card -> card.id == white_card_id end)

    if index do
      index + 1
    else
      nil
    end
  end

  def generate_name do
    [
      [
        "autumn",
        "hidden",
        "bitter",
        "misty",
        "silent",
        "empty",
        "dry",
        "dark",
        "summer",
        "icy",
        "delicate",
        "quiet",
        "white",
        "cool",
        "spring",
        "winter",
        "patient",
        "twilight",
        "dawn",
        "crimson",
        "wispy",
        "weathered",
        "blue",
        "billowing",
        "broken",
        "cold",
        "damp",
        "falling",
        "frosty",
        "green",
        "long",
        "late",
        "lingering",
        "bold",
        "little",
        "morning",
        "muddy",
        "old",
        "red",
        "rough",
        "still",
        "small",
        "sparkling",
        "throbbing",
        "shy",
        "wandering",
        "withered",
        "wild",
        "black",
        "young",
        "holy",
        "solitary",
        "fragrant",
        "aged",
        "snowy",
        "proud",
        "floral",
        "restless",
        "divine",
        "polished",
        "ancient",
        "purple",
        "lively",
        "nameless"
      ],
      [
        "waterfall",
        "river",
        "breeze",
        "moon",
        "rain",
        "wind",
        "sea",
        "morning",
        "snow",
        "lake",
        "sunset",
        "pine",
        "shadow",
        "leaf",
        "dawn",
        "glitter",
        "forest",
        "hill",
        "cloud",
        "meadow",
        "sun",
        "glade",
        "bird",
        "brook",
        "butterfly",
        "bush",
        "dew",
        "dust",
        "field",
        "fire",
        "flower",
        "firefly",
        "feather",
        "grass",
        "haze",
        "mountain",
        "night",
        "pond",
        "darkness",
        "snowflake",
        "silence",
        "sound",
        "sky",
        "shape",
        "surf",
        "thunder",
        "violet",
        "water",
        "wildflower",
        "wave",
        "water",
        "resonance",
        "sun",
        "wood",
        "dream",
        "cherry",
        "tree",
        "fog",
        "frost",
        "voice",
        "paper",
        "frog",
        "smoke",
        "star"
      ]
    ]
    |> Enum.map(fn names -> Enum.random(names) end)
    |> Enum.join("-")
  end
end
