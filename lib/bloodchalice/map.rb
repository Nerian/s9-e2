class BloodChalice
  class Map 
    attr_accessor :map, :number_of_players    
    
    def initialize(path)
      @map = load_map(path)
    end
        
    def generate_players(number_of_players)
      @number_of_players = number_of_players
      players = []   
      
      @map.each_with_index do |line, y|
        line.each_with_index do |tile, x|          
          if status(tile) == :active_player
            players <<  @map[y][x] = Player.new(map: @map, position: [y, x], number: tile.to_i)
          elsif status(tile) == :inactive_player
            @map[y][x] = ' '
          end
        end
      end
      players
    end
    
    def to_s
      result = ''
      @map.each do |line|            
        line.each { |tile| result += tile.to_s }
        result += "\n"
      end            
      result
    end         
    
    private
    
    def load_map(path)
      filename = ASSETS_FOLDER + "world/#{path}"

      map = File.readlines(filename).each.map do |line|
        line.strip.split(//).each.map do |tile|       
          tile
        end
      end
    end       
    
    def status(tile)
     tile = tile.to_i
     if player?(tile) && active_player?(tile)
       :active_player
     elsif player?(tile)
       :inactive_player
     elsif wall?(tile)
       :wall
     else
       :empty
     end
    end
    
    def wall?(tile)
      tile == '#'
    end        
    
    def active_player?(tile)
      tile.to_i <= @number_of_players
    end
    
    def player?(tile)      
      tile.to_i != 0
    end    
    
  end
end