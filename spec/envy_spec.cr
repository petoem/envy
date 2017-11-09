require "./spec_helper"

describe Envy do
  it "load hash" do
    ENV["ENVY_TEST"] = "1234"
    Envy.load({"ENVY_TEST" => "something else", "APP_DB" => "myawesomedb"})
    ENV["ENVY_TEST"].should eq("1234")
    ENV["APP_DB"].should eq("myawesomedb")
  end

  it "load! hash" do
    ENV["ENVY_TEST"] = "1234"
    Envy.load!({"ENVY_TEST" => "something else", "APP_DB" => "myawesomedb"})
    ENV["ENVY_TEST"].should eq("something else")
    ENV["APP_DB"].should eq("myawesomedb")
  end

  it "load .env file" do
    ENV["A_KEY"] = "one value"
    Envy.load "spec/.env"
    ENV["A_KEY"].should eq("one value")
    ENV["ANOTHER_LINE"].should eq("some_value")
  end

  it "load! .env file" do
    ENV["A_KEY"] = "one value"
    Envy.load! "spec/.env"
    ENV["A_KEY"].should eq("value")
    ENV["ANOTHER_LINE"].should eq("some_value")
  end

  it "parse" do
    env_hash = {"CRYSTAL_ENV"          => "development",
                "A_KEY"                => "value",
                "ANOTHER_LINE"         => "some_value",
                "EMPTY_VALUE"          => "",
                "REMOVE_DOUBLE_QUOTES" => "double",
                "EQUAL_SIGNS"          => "sign==one=",
                "RETAIN_INNER_QUOTES"  => "{ \"foo\": \"bar\" }",
                "SPACE_SHIP"           => "some spaced out ship",
                "UPCASE_KEY"           => "https://db/path",
                "EXPORT_THIS_MAIL"     => "hello@world.tld"}
    Envy.parse("spec/.env").should eq(env_hash)
  end
end
