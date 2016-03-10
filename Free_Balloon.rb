class Free_Balloon < Scene_Map
  
  def start
    super
      @event_id = $game_system.balloon_event_id#從game_system讀取目標事件的ID
      @text = $game_system.balloon_text#從game_system讀取對話內容
      @keep_second = $game_system.balloon_second#從game_system讀取氣球對話框顯示時間(秒數)
      @max_time = @keep_second * 60
      @balloon_window = Balloon_Window.new(@text, @event_id)#創建氣球對話框
  end
  
  def update
    super
      @eventx = $game_map.events[@event_id].screen_x#更新目標事件位置
      @eventy = $game_map.events[@event_id].screen_y#更新目標事件位置
      if @max_time > 0#時間計數
        @max_time -= 1
        @balloon_window.move(free_balloon_x, free_balloon_y, free_balloon_width, free_balloon_height)#更新氣球對話框位置
      else
        @balloon_window.close#關閉氣球對話框
        @max_time = 0
      end
  end
  
  def free_balloon_x#氣球對話框X軸計算
    @eventx - free_balloon_width / 2
  end
    
  def free_balloon_y#氣球對話框Y軸計算
    @eventy - 32 - free_balloon_height
  end
  
  def free_balloon_width#氣球對話框寬度計算
    @balloon_window.width
  end
  
  def free_balloon_height#氣球對話框高度計算
    @balloon_window.height
  end
  
end
