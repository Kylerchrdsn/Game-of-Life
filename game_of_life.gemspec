Gem::Specification.new do |s|
  s.name        = %[game_of_life]
  s.version     = '0.0.2'
  s.licenses    = ['MIT']
  s.summary     = %[An implementation of Conway's Game of Life.]
  s.authors     = ['Kyle Richardson']
  s.email       = 'kylerchrdsn@gmail.com'
  s.files       = Dir['lib/**/*.rb']+['README.md', 'LICENSE']
  s.executables = ['glider_gun.rb', 'garden_of_eden.rb', 'random.rb']
  s.description = %[
    == Summary ==

      An implementation of Conway's Game of Life. The gem includes classes needed to make a field of cells,
    and iterate the field through a number of generations. This implementation does not use a toroidal array.
    This is a console program which is compatible with Linux, Mac OS, and Windows.
    The gem was built with a couple of executable scripts: 'garden_of_eden.rb' and 'glider_gun.rb'. These scripts will be added
    to the user's path, when the gem is installed.

    == Requirements ==

      1.) Linux, Mac OS, or Windows
      2.) Ruby >= 1.9.3

      If you are using Windows.
      3.) 7-Zip or other application, for extracting files from game_of_life.tar.gz

    == Usage ==

      1.) Extract files from game_of_life.tar.gz
      2.) Open terminal
      3.) Navigate to the directory that contains game_of_life-0.0.1.gem
      4.) Run the following commands:

          $ gem install game_of_life-0.0.1.gem
          $ garden_of_eden.rb
  ]
end

