#heroku link: https://salty-garden-84094.herokuapp.com/
require 'sinatra'
require "sinatra/reloader" if development?

enable :sessions

secret = (rand 1..9).to_i

def inc_counter
  session[:counter] ||= 0
  session[:counter] += 1
end



get '/' do
  "Guess a number between 1 and 10 by adding your guess to the end of the adress.com/game/.<br>
  For example, if your guess is <b>1</b>, your url should be address.com/game/1<b>1</b>"
end

not_found do
redirect '/'
end


get '/game/:guess' do
  session[:guess] = params[:guess]
  guess = params["guess"].to_i
  # The program will then ask (using the command line) to guess the number

  inc_counter

  # The program will check to see if the number matches.
  if (guess == secret) and (session[:counter] < 3) then
    # If it does, the player wins and they're congratulated
    "That's right! It was #{guess}!"
    # If it doesn't, they're offered another chance to guess the number
  elsif session[:counter] > 3 then
    "You run out of attempts. <b>/reset</b> to try again."
  else
    "Sorry, it is not. #{secret}<br>#{session['counter']}<br>You have #{4-session['counter']}"
  end
end
get '/reset' do
  session[:counter] = nil
  redirect '/'
end
