class Life::Field
  attr_reader :population, :generation, :grid
  #***************************************
  def initialize *args
    @grid       = []
    @population = 0
    @generation = 0
    height, width, field = nil
    case args[0].class.to_s
    when 'Fixnum'
      height = args[0]
      width  = args[1]
    when 'Array'
      field = args[0]
    end
    
    if !field.nil?
      @grid = field.map!{|r| r.map!{|c| (c == 1 ? Life::Cell.new(true) : Life::Cell.new(false)) }}
    elsif !height.nil? && !width.nil?
      row = []
      width.times{ row << Life::Cell.new }
      height.times{ @grid << row }
    end
  end
  #***************************************
  def to_s
    @grid.map{|r| r.map{|c| (c.alive? ? "0" : ' ') }.join}.join("\n")
  end
  #***************************************
  def random
    pop = 0
    @grid.length.times do |i|
      @grid[i].length.times do |j|
        val = (rand(10000000000000000000000000000000)%2)
        if(val.to_s == '0')
          @grid[i][j].alive = true
          pop += 1
        else
          @grid[i][j].alive = false
        end
      end
      @grid.map!{|r| r.shuffle }
      @population = pop
      @generation = 0
    end
  end
  #***************************************
  def evolve num
    is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
    clear      = (is_windows.nil? ? 'clear' : 'cls')
    system(clear)
    puts %[Generation: #{@generation}]
    puts %[Population: #{@population}]
    puts self.to_s
    sleep 0.5
    num.times{ 
      system(clear)
      self.step; puts %[Generation: #{@generation}]
      puts %[Population: #{@population}]
      puts self.to_s 
      sleep 0.5
    }
  end
  #***************************************
  def step
    pop     = 0
    mapping = []

    @grid.length.times do |i|
      @grid[i].length.times do |j|
        cell           = @grid[i][j]
        cell_live      = false
        live_neighbors = check_neighbors(i, j)

        if cell.alive?
          if live_neighbors == 2 || live_neighbors == 3
            cell_live = true
          end
        else
          if live_neighbors == 3
            cell_live = true
          end
        end

        cell_fate = {:i => i, :j => j, alive: false}
        if cell_live
          cell_fate[:alive] = true
          pop += 1
        end
        mapping << cell_fate
      end # loop
    end # loop

    @population = pop
    @generation += 1
    mapping.each{|m| @grid[m[:i]][m[:j]].alive = m[:alive] }
  end
  #***************************************
  def check_neighbors i, j
    live_neighbors = 0
    neighbors      = {
      :ml => Life::Cell.new, :mr => Life::Cell.new, :tl => Life::Cell.new, :tm => Life::Cell.new, 
      :tr => Life::Cell.new, :bl => Life::Cell.new, :bm => Life::Cell.new, :br => Life::Cell.new
    }
    # top #
    unless((i-1)<0)
      neighbors[:tl] = (j-1<0 ? Life::Cell.new : @grid[i-1][j-1])
      neighbors[:tm] = @grid[i-1][j]||Life::Cell.new
      neighbors[:tr] = @grid[i-1][j+1]||Life::Cell.new
    end
    # middle #
    neighbors[:ml] = (j-1 < 0 ? Life::Cell.new : @grid[i][j-1])
    neighbors[:mr] = ((j+1) > (@grid[i].length-1) ? Life::Cell.new : @grid[i][j+1])
    # bottom #
    unless((i+1)>(@grid.length-1))
      neighbors[:bl] = (j-1<0 ? Life::Cell.new : @grid[i+1][j-1])
      neighbors[:bm] = @grid[i+1][j]||Life::Cell.new
      neighbors[:br] = @grid[i+1][j+1]||Life::Cell.new
    end
    neighbors.each do |k, v|
      if(v.alive?)
        live_neighbors += 1
      end
    end
    live_neighbors
  end
end # class
