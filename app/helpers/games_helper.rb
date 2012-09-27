module GamesHelper

  # Return the prefix for a ship or a shot at a given co-ordinate
  def ship_or_shot_prefix(board, x, y)
    shot = board.shot_at_co_ordinate(x, y)
    if shot.present?
      prefix = shot.is_hit ? "X" : "O"

      # Let's make the most recent shot BOLD
      (shot == board.most_recent_shot) ? content_tag('strong', prefix) : prefix
    else
      ship = board.ship_at_co_ordinate(x, y)
      if ship.present? and !board.is_opponent?
        ship.ship_type.prefix
      else
        raw("&nbsp;&nbsp;")
      end
    end
  end

  # Returns a data list item (<dt> and <dd>) if there is a value present
  def data_list_item(label, value)
    if value.present?
      content_tag('dt', "#{label} -") + content_tag('dd', value)
    end
  end

  # Return the JavaScript method call if this is the opponent's board
  def table_cell_click(game, board, x, y)
    if board.is_opponent?
      "fire_shot(#{game.id}, #{x}, #{y});"
    end
  end

end
