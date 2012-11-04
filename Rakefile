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

BASE_PATH  = File.dirname(__FILE__)
BACKUP_DIR = "/tmp/dotfiles_#{Time.now.strftime("%Y%m%d%H%M%S")}"

# rake dotfiles:setup [-v|--verbose] [noop=true|false] [force=true|false]
#
# When the server has been set up, run for the first
#
# Usage:
#   $ rake dotfiles:setup -v noop=true
#   $ rake dotfiles:setup -v force=true
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

    mkdir(BACKUP_DIR)

    # Create a Symbolic Link
    Dir.new(BASE_PATH).entries.reject{ |file| IGNORE_FILES.include?(file) }.each do |file|
      src  = File.join(BASE_PATH, file)
      dest = File.join(Dir.home, file)

      unless File.identical?(src, dest)
        options = { noop: noop, verbose: verbose }
        cp_r(src, BACKUP_DIR, options)
      end

      # otherwize it will be created dest/src
      next if File.exists?(dest) && Dir.exist?(src) && File.identical?(src, dest)

      options = { noop: noop, verbose: verbose, force: force }
      symlink(src, dest, options)
    end

    if Dir.empty?(BACKUP_DIR)
      Dir.rmdir(BACKUP_DIR)
    else
      puts "backuped at #{BACKUP_DIR}"
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

class Dir
  def Dir.empty?(path)
    Dir.entries(path) == %w(. ..)
  end
end
