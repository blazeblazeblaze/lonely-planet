require './lib/program'

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
  c.failure_color = :magenta
  c.tty = true
  c.color = true
end

