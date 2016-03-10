class Balloon_Window < Window_Base
  
  def initialize(text, event_id)
  #------------------------------------------------------------------------
  #讀取目標事件位置
  #------------------------------------------------------------------------
    unless event_id == 0
      @eventx = $game_map.events[event_id].screen_x
      @eventy = $game_map.events[event_id].screen_y
    else
      @eventx = 0
      @eventy = 0
    end
    @text = text
    super(0, 0, 0, 0)
    free_balloon_width
    free_balloon_height
    set_position
    process_text
    self.arrows_visible = false
  end
  
  #------------------------------------------------------------------------
  #設定氣球對話框位置與寬高
  #------------------------------------------------------------------------
  def set_position
    self.width = free_balloon_width
    self.height = free_balloon_height
    self.x = free_balloon_x
    self.y = free_balloon_y
    self.contents = Bitmap.new(@longest, @text_height * @text_line)
  end
  
  def free_balloon_x
    @eventx - free_balloon_width / 2
  end
    
  def free_balloon_y
    @eventy - 32 - free_balloon_height
  end
  
  #------------------------------------------------------------------------
  #氣球對話框寬度計算
  #------------------------------------------------------------------------
  def free_balloon_width
    @text_line = 1
    width_counting = 0
    text_width = []
    character = ""
    @longest = 0
    text = convert_escape_characters(@text)
    until text.empty?
      character = text.slice!(0, 1)
      case character
      when "\n"
        @text_line += 1 
        width_counting = 0
      when "\e"
        text.slice!(/\w|\w\[.\]|\w\[..\]|\^|\{|\}|\$|\.|\||\!|\<|\>|\\/)
      else
        width_counting += text_size(character).width 
        text_width[@text_line] = width_counting
      end
    end
    text_width.compact!
   @longest = text_width.max == nil ? 0 : text_width.max
    @text_line = 1 unless @text_line > 0
    @balloon_width = @longest + standard_padding * 2
  end
  
  #------------------------------------------------------------------------
  #氣球對話框高度計算
  #------------------------------------------------------------------------
  def free_balloon_height
    text = convert_escape_characters(@text)
    @text_height = calc_line_height(text)
    @balloon_height = @text_height * @text_line + standard_padding * 2
  end

  #------------------------------------------------------------------------
  #文字顯示處理
  #------------------------------------------------------------------------
  def process_text
    text = convert_escape_characters(@text)
    pos = {:x => 0, :y => 0, :new_x => 0, :height => calc_line_height(text)}
    process_character(text.slice!(0, 1), text, pos) until text.empty?
  end
  
end
