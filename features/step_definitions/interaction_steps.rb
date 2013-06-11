Given /^a profile named "([^\"]*)" on "([^\"]*)"$/ do |name, area|
  step 'I run rubysurvivor'
  step 'I answer "y" to "create one?"'
  step 'I choose "' + area + '" for "area"'
  step 'I answer "' + name + '" to "name"'
  step 'I should see "generated"'
end

Given /^no profile at "([^\"]*)"$/ do |path|
  RubySurvivor::Config.path_prefix = path
  FileUtils.rm_rf("#{path}/rubysurvivor")
end

Given /^current directory is "([^\"]*)"$/ do |path|
  RubySurvivor::Config.path_prefix = path
end

When /^I run rubysurvivor$/ do
  @io = MockIO.new
  @io.start do |io|
    RubySurvivor::Config.out_stream = io
    RubySurvivor::Config.in_stream = io
    RubySurvivor::Game.new.start
  end
end

When /^I run rubysurvivor with options "([^\"]*)"$/ do |options|
  RubySurvivor::Config.reset
  @io = MockIO.new
  @io.start do |io|
    RubySurvivor::Runner.new(options.split, io, io).run
  end
end

When /^I answer "([^\"]*)" to "([^\"]*)"$/ do |answer, question|
  @io.gets_until_include(question)
  @io.puts(answer)
end

When /^I choose "([^\"]*)" for "([^\"]*)"$/ do |choice, phrase|
  answer = nil
  content = @io.gets_until_include(phrase)
  content.split("\n").each do |line|
    if line.include?(choice) && line =~ /\[(\d)\]/
      answer = $1
    end
  end
  if answer
    @io.puts(answer)
  else
    raise "Unable to find choice #{choice} in #{content}"
  end
end

When /^I wait until it says "([^\"]*)"$/ do |phrase|
  @io.gets_until_include(phrase)
end

Then /^I should see "([^\"]*)"$/ do |phrase|
  @io.gets_until_include(phrase).should include(phrase)
end

Then /^I should not see "([^\"]*)" before "([^\"]*)"$/ do |first_phrase, second_phrase|
  @io.gets_until_include(second_phrase).should_not include(first_phrase)
end
