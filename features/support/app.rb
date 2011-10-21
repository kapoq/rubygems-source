def app
  Rubygems::Source::App.new
end

Rubygems::Source::App.public_folder = TmpDirHelper.root_dir
