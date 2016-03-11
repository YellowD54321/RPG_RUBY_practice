class Free_Balloon < Scene_Map
  
  def start
    super
    unless $game_system.balloon_event_id <= 0
      @event_id = $game_system.balloon_event_id
      @text = $game_system.balloon_text
      @keep_second = $game_system.balloon_second
      @max_time = @keep_second * 60
      @balloon_window = Balloon_Window.new(@text, @event_id)
    else
      @balloon_window = nil
    end
  end
  
  def update
    super
    unless @balloon_window == nil
      @eventx = $game_map.events[@event_id].screen_x
      @eventy = $game_map.events[@event_id].screen_y
      if @max_time > 0
        @max_time -= 1
        @balloon_window.move(free_balloon_x, free_balloon_y, free_balloon_width, free_balloon_height)
      else
        @balloon_window.hide
        @max_time = 0
        $game_system.balloon_event_id = 0
      end
    end
  end
  
  def free_balloon_x
    @eventx - free_balloon_width / 2
  end
    
  def free_balloon_y
    @eventy - 32 - free_balloon_height
  end
  
  def free_balloon_width
    @balloon_window.width
  end
  
  def free_balloon_height
    @balloon_window.height
  end
  
end
