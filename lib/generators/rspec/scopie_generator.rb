module Rspec
  module Generators
    class ScopieGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def create_scopie_spec
        template 'scopie_spec.rb', File.join('spec/scopies', class_path, "#{file_name}_scopie_spec.rb")
      end
    end
  end
end
