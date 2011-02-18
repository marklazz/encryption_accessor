require 'rubygems'
require 'echoe'

# PACKAGING ============================================================

Echoe.new('encryption_accessor', '0.0.2') do |p|
  p.description = "Accessor's to encrypt/decrypt fields when data is stored encrypted on DB"
  p.url = 'https://github.com/marklazz/encryption_accessor'
  p.author = 'Marcelo Giorgi'
  p.email = 'marklazz.uy@gmail.com'
  p.ignore_pattern = [ 'tmp/*', 'script/*', '*.sh' ]
  p.runtime_dependencies = []
  p.development_dependencies = [ 'spec' ]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
