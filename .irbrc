IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000

require 'irb/completion'
require 'date'
require 'pathname'
require 'pp'
require 'rubygems'

if defined?(Hirb) == 'constant'
  Hirb.enable
end

gem 'wirble'; require 'wirble'
Wirble.init
Wirble.colorize
