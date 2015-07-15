guard :rspec, cmd: 'spring rspec' do
  x = "spec/features/goal_spec.rb"
  watch(%r{^app/}) { x }
  watch(%r{^spec/}) { x }
  watch('config/routes.rb') { x }
end
