Given(/^There exists (\d+) evaluation records in the database for instructor (.+)$/) do |n, name|
  prng = Random.new

  instructor = Instructor.create(name: name)
  (1..n.to_i).each do |i|
    Evaluation.create(
      term: '2015C',
      subject: 'CSCE',
      course: '110',
      section: (500 + i).to_s,
      instructor: instructor,
      enrollment: prng.rand(20..50),
      item1_mean: prng.rand(3.0..5.0).round(2),
      item2_mean: prng.rand(3.0..5.0).round(2),
      item3_mean: prng.rand(3.0..5.0).round(2),
      item4_mean: prng.rand(3.0..5.0).round(2),
      item5_mean: prng.rand(3.0..5.0).round(2),
      item6_mean: prng.rand(3.0..5.0).round(2),
      item7_mean: prng.rand(3.0..5.0).round(2),
      item8_mean: prng.rand(3.0..5.0).round(2)
    )
  end
end

When(/^User visits the evaluation index page$/) do
  visit '/evaluation'
end

When(/^User vists the instructor index page$/) do
  visit '/instructor'
end

When(/^Clicks on the name of instructor (.+)$/) do |name|
  click_link(name, match: :first)
end

Then(/^User should see a table of (\d+) data rows$/) do |n|
  expect(page).to have_css("tbody tr", count: n.to_i)
end

Then(/^User should see courses page for (.+)$/) do |name|
  expect(page).to have_content(name)
  expect(page).to have_css("tbody tr")
end

Then(/^User should see a link for instructor (.+)$/) do |name|
  expect(page).to have_link(name)
end

