require 'rake'
require 'pathname'
require 'erb'
require 'cgi'
require 'rake/clean'
require 'rake/packagetask'

TEMPLATE = Pathname('src/info.plist.erb')
SCRIPT = Pathname('src/togglemic.applescript')
INFO_PLIST = Pathname('build/info.plist')
ICON_SOURCE = Rake::FileList.new('src/*.png')
ICON_TARGET = ICON_SOURCE.pathmap('%{^src/,build/}X.png')
RELEASE = Pathname('release/togglemic.alfredworkflow')

CLEAN.include(INFO_PLIST, ICON_TARGET)
CLOBBER.include(RELEASE)

desc 'generate info.plist'
file INFO_PLIST => [TEMPLATE, SCRIPT] do |file|
  Pathname(file.name.to_s).write(ERB.new(TEMPLATE.read).result)
end

ICON_TARGET.each do |icon|
  file icon do |icon_file|
    cp icon_file.name.pathmap('%{^build,src}X.png'), 'build/'
  end
end

task :icons => ICON_TARGET

desc 'generate release'
file RELEASE => [INFO_PLIST, :icons] do |file|
  release_file = Pathname(file.name.to_s)
  sh "zip --junk-paths #{release_file} build/*"
end
