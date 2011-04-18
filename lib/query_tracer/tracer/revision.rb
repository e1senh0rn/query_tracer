module QueryTracer
  module Tracer

    module Revision
      # Detect the current code revision and memoize it for the future.
      def self.current
        return nil unless QueryTracer::Configuration.show_revision
        
        begin
          # Do we have the code revision memoized?
          unless defined?(@@current_code_revision)
            @@current_code_revision = if File.exists?("#{Rails.root}/REVISION")
              # Capistrano-deployed application, we know where to get current revision
              File.read("#{Rails.root}/REVISION").chomp.strip
            else
              # Try to use git
              rev = `git rev-parse HEAD 2>/dev/null`.chomp.strip
              rev.empty? ? nil : rev
            end
          end
        rescue
          nil
        end
        humanized_revision
      end
      
      def self.humanized_revision
        if @@current_code_revision
          "Rev[#{@@current_code_revision}]"
        end
      end

    end

  end
end