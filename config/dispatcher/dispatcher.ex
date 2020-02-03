defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  ### --- CUSTOM MICRO SERVICE --- ###

  match "/random/*path" do
    Proxy.forward conn, path, "http://trivia/random/"
  end

  match "/questions/*path" do
    Proxy.forward conn, path, "http://trivia/questions/"
  end

  match "/question/*path" do
    Proxy.forward conn, path, "http://trivia/question/"
  end

  match "/fill/*path" do
    Proxy.forward conn, path, "http://trivia/fill/"
  end

  ### --- CUSTOM MICRO SERVICE --- ###

  match "/resource/trivias/*path" do
    Proxy.forward conn, path, "http://resource/trivias/"
  end

  match "/resource/categories/*path" do
    Proxy.forward conn, path, "http://resource/categories/"
  end

  ### -- TRIVIA CRON SERVICE --- ###

  match "/add-trivia/*path" do
    Proxy.forward conn, path, "http://cron/add-trivia/"
  end

  match "/trivia-count/*path" do
    Proxy.forward conn, path, "http://cron/trivia-count/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
