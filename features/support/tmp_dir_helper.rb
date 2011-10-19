module TmpDirHelper
  PATH = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "tmp", "rubygems-server"))
  
  def self.root_dir
    PATH
  end
  
  def self.gem_dir
    File.join(root_dir, "gems")
  end

  def self.local_dir
    File.join(root_dir, "local")
  end
  
  def self.reset
    FileUtils.rm_r(Dir["#{File.join(root_dir, "*")}"])
    setup
  end

  def self.remove
    FileUtils.rm_r(root_dir)
  end

  def self.setup
    FileUtils.mkdir_p(gem_dir)
    FileUtils.mkdir_p(local_dir)
  end

  def self.in_gem_dir(&block)
    Dir.chdir(gem_dir)
    yield
    Dir.chdir(root_dir)
  end

  def self.in_local_dir(&block)
    Dir.chdir(local_dir)
    yield
    Dir.chdir(root_dir)
  end
end

Before do
  TmpDirHelper.setup
  TmpDirHelper.reset
  Dir.chdir(TmpDirHelper.root_dir)
end

at_exit do
  TmpDirHelper.remove
end

Rubygems::Source::App.public_folder = TmpDirHelper.root_dir
