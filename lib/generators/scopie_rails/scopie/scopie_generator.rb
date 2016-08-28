module ScopieRails
  module Generators
    class ScopieGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def create_scopie
        template 'scopie.rb', File.join('app/scopies', class_path, "#{file_name}_scopie.rb")
      end

      hook_for :test_framework
    end
  end
end
