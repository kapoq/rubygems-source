require 'rubygems/builder'
require 'rubygems/indexer'

module GemHelpers
  def build_gemspec(gemspec)
    builder = Gem::Builder.new(gemspec)
    builder.ui = Gem::SilentUI.new
    builder.build
  end

  def build_gem(name, version, summary = "Gemcutter", platform = "ruby")
    build_gemspec(new_gemspec(name, version, summary, platform))
  end

  def new_gemspec(name, version, summary, platform)
    gemspec = Gem::Specification.new do |s|
      s.name = name
      s.platform = platform
      s.version = "#{version}"
      s.authors = ["John Doe"]
      s.date = "#{Time.now.strftime('%Y-%m-%d')}"
      s.description = "#{summary}"
      s.email = "john.doe@example.org"
      s.files = []
      s.homepage = "http://example.org/#{name}"
      s.require_paths = ["lib"]
      s.rubygems_version = %q{1.3.5}
      s.summary = "#{summary}"
      s.test_files = []
    end

    def gemspec.validate
      "not validating on purpose"
    end

    gemspec
  end
  
  def read_compressed_gem_index(string_io)
    Marshal.load(Gem.gunzip(string_io))
  end

  def map_table_to_gem_index(table)
    table.rows.map { |r| r[1] = Gem::Version.new(r[1]); r }
  end

  def read_compressed_gemspec(str)
    Marshal.load(Gem.inflate(str))
  end

  def clear_gem_specs_and_update_gem_indices
    Gem.post_reset{ Gem::Specification.all = nil }
    Gem::Indexer.new(TmpDirHelper.root_dir).generate_index
  end

  def assert_available_for_install(package_name)
    assert_gem_present_in_index(package_name)
    assert_gemspec_present(package_name)
    assert_gem_package_present(package_name)
  end

  def assert_gem_present_in_index(package_name)
    get_full_index
    index = read_compressed_gem_index(last_body)
    (index.detect { |s| "#{s[0]}-#{s[1].to_s}.gem" == package_name } && true).should be_true
  end
  
  def assert_gemspec_present(package_name)
    get_gemspec(package_name)
    last_response.status.should eq 200
  end
  
  def assert_gem_package_present(package_name)
    get_package(package_name)
    last_response.status.should eq 200
  end

  def assert_exactly_these_gems_in_index(table)
    actual_index   = read_compressed_gem_index(last_body)
    expected_index = map_table_to_gem_index(table)
  
    actual_index.should have_same_members_as(expected_index)
  end
end

World(GemHelpers)
