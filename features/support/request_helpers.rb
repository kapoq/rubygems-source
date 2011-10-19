module RequestHelpers
  def get_gemspec(package_name)
    get "/quick/Marshal.4.8/#{package_name}spec.rz"
  end
  
  def get_package(package_name)
    get "/gems/#{package_name}"
  end
  
  def get_full_index
    get "/specs.4.8.gz"
  end
end

World(RequestHelpers)
