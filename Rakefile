# coding: utf-8

require 'rake'

# These files will be ignored to create symlink
IGNORE_FILES = %w(
  .
  ..
  .git
  README
  Rakefile
)

BASE_PATH = File.dirname(__FILE__)

# rake install [-v|--verbose] [noop=true|false] [force=true|false]
# 通常の使い方、確認してから基本的に上書きする
# 1. rake install -v noop=true
# 2. rake install -v force=true
desc "install the dot files into user's home directory"
task :install do
  force = ENV['force'] == "true"
  noop  = ENV['noop']  == "true"

  # Create a Symbolic Link
  Dir.new(BASE_PATH).entries.reject{ |file| IGNORE_FILES.include?(file) }.each do |file|
    options = { noop: noop, verbose: verbose, force: force }
    symlink("#{BASE_PATH}/#{file}", "~/", options)
  end

  # Install Vim Plugins
  system('vim -c "BundleInstall" -c "quit"') unless noop

  if $?
    puts "Successfully initialized... ;)"
  else
    puts "Oops! O_o"
  end
end
