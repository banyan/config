# coding: utf-8

require 'rake'

# These files will be ignored to create symlink
IGNORE_FILES = %w(
  .
  ..
  .git
  README
  Rakefile
  bin
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

  options = { noop: noop, verbose: verbose, force: force }

  # Create a Symbolic Link
  Dir.new(BASE_PATH).entries.reject{ |file| IGNORE_FILES.include?(file) }.each do |file|
    src  = File.join(BASE_PATH, file)
    dest = File.join(Dir.home, file)

    # dest がすでに存在しディレクトリであるときは dest/src が作られるので飛ばす
    next if File.exists?(dest) && Dir.exist?(src)

    symlink(src, dest, options)
  end

  # Install Vim Plugins
  system('vim -c "BundleInstall" -c "quit"') unless noop
end
