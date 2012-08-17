# -*- encoding : utf-8 -*-
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Learn more: http://github.com/javan/whenever

every 1.day, :at => '12:00 pm' do
  runner 'Blog.get_new_posts'
end

every 1.day, :at => '18:00 pm' do
  runner 'Blog.get_new_posts'
end

every 1.day, :at => '23:59 pm' do
  runner 'Blog.get_new_posts'
end