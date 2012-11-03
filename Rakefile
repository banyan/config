# coding: utf-8
require 'rake'

# These files will be ignored to create symlink
IGNORE_FILES = %w(
  .
  ..
  .git
  README.md
  Rakefile
  bin
)

BASE_PATH = File.dirname(__FILE__)

# rake dotfiles:setup [-v|--verbose] [noop=true|false] [force=true|false]
# サーバセットアップ後、一番はじめに行う
# $ rake dotfiles:setup -v noop=true
# $ rake dotfiles:setup -v force=true
namespace :dotfiles do
  desc "install and setup dotfiles"
  task :setup do
    Rake::Task["dotfiles:symlink"].invoke
    Rake::Task["dotfiles:vim:install_plugins"].invoke
  end
end

# rake symlink [-v|--verbose] [noop=true|false] [force=true|false]
namespace :dotfiles do
  desc "create dotfiles symlink into user's home directory"
  task :symlink do
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
  end
end

# rake dotfiles:vim:install_plugins [-v|--verbose] [noop=true|false]
# $ rake dotfiles:vim:install_plugins -v noop=true
namespace :dotfiles do
  namespace :vim do
    desc "Run BundleInstall"
    task :install_plugins do
      noop  = ENV['noop']  == "true"
      command = 'vim -c "BundleInstall" -c "quit"'
      if noop
        puts command
      else
        system(command)
      end
    end
  end
end
