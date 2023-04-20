# frozen_string_literal: true

SimpleCov.start :rails do
  add_filter "/app\/channels/"
  add_filter "/app\/jobs/"
  add_filter "/app\/mailers/"
  add_filter "/app\/controllers\/application_controller.rb"
end
SimpleCov.minimum_coverage 100
SimpleCov.refuse_coverage_drop
SimpleCov.merge_timeout 1200
