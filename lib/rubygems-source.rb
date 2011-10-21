require "rubygems/package"
require "rubygems/user_interaction"
require "rubygems/indexer"
require "sinatra/base"

module Rubygems
  module Source
    autoload :Version, "rubygems-source/version"
    
    class App < Sinatra::Base      
      set :show_exceptions, false
      set :raise_errors, true

      helpers do
        def path_to_gem(gem_file_name = "")
          File.join(settings.public_folder, "gems", gem_file_name)
        end
        
        def clear_gem_specs_and_update_gem_indices
          Gem.post_reset{ Gem::Specification.all = nil }
          Gem::Indexer.new(settings.public_folder).generate_index
        end

        def get_spec(data)
          Gem::Package.open(StringIO.new(data), "r", nil) { |pkg| pkg.metadata }
        rescue Gem::Package::FormatError
          false
        end
      end      

      # #
      # # ROUTES
      # #

      # PUSH
      post "/api/v1/gems" do
        if spec = get_spec(request.body.read)
          filename = path_to_gem("#{spec.original_name}.gem")
          FileUtils.mkdir_p(path_to_gem) unless File.directory?(path_to_gem)
          if File.exists?(filename)
            "#{spec.original_name} already exists and will not be overwritten."
            status 409
          else
            request.body.rewind
            File.open(filename, "wb") { |f| f.write(request.body.read) }
            clear_gem_specs_and_update_gem_indices
            "#{spec.original_name} pushed. Have a nice day."
          end
        else
          "Invalid gem"
          status 403
        end
      end

      # YANK
      delete "/api/v1/gems" do
        requirements = params.dup
        name         = requirements.delete("gem_name")
        version      = requirements.delete("version")
        # TODO: check required params present
        platform     = requirements.delete("platform")
        candidates   = Gem::Specification.find_all_by_name(name, "=#{version}")
        gems_to_yank = if platform.nil? || platform == ""
                         candidates
                       else
                         candidates.select { |spec| spec.platform == platform }
                       end
        unless gems_to_yank.empty?
          gems_to_yank.each { |spec| FileUtils.rm(path_to_gem(spec.file_name)) }
          clear_gem_specs_and_update_gem_indices
          gems_to_yank.map { |spec| spec.original_name }.join(", ") + " yanked. Have a nice day."
        else
          "No matching gems found here"
          status 404
        end
      end
    end
  end
end
