#!/usr/bin/env ruby
# encoding: utf-8

require 'fileutils'

def is_mac
  RUBY_PLATFORM =~ /darwin/ ? true : false
end

# Change Paths as you like
if is_mac
  SRC_PATH = "#{ENV['HOME']}/Sources/"
  BIN_PATH = "#{ENV['HOME']}/bin/"
else
  SRC_PATH = "/usr/local/src/"
  BIN_PATH = "/usr/local/bin/"
end

VERSIONS = %w(
  scala-2.7.7.final
  scala-2.8.0.RC1
  scala-2.8.0.final
)

COMMANDS = %w(
  scala
  fsc
  scalac
  scaladoc
)

version = ARGV.first
unless VERSIONS.include? version then
  puts "Usage: ./scala_switch.rb version [#{VERSIONS.join(' ')}]"
  exit
end

def remove_symbolic_link
  COMMANDS.each do |c|
    FileUtils.rm(BIN_PATH + "/#{c}") if FileTest.exist?(BIN_PATH + "/#{c}")
  end
end

def create_symbolic_link(version)
  COMMANDS.each do |c|
    original = SRC_PATH + version + "/bin/#{c}"
    unless FileTest.exist?(original)
      puts "invalid scala's bin path."
      exit
    end
    link     = BIN_PATH + c
    FileUtils.symlink(original, link)
  end
end

remove_symbolic_link
create_symbolic_link(version)

