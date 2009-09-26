IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 100

require 'irb/completion'
require 'date'
require 'pathname'
require 'pp'
require 'rubygems'
gem 'wirble'; require 'wirble'

Wirble.init
Wirble.colorize
