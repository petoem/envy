require "./envy/*"

module Envy
  extend self
  DEFAULT_ENV_FILENAME = ".env"

  {% for name, comp in {load: :"||=", load!: :"="} %}
  def {{name.id}}(*filename : String)
    filename.each do |file|
      env_vars = parse file
      {{name.id}} env_vars
    end
    {{name.id}} parse(DEFAULT_ENV_FILENAME) if filename.size.zero?
  end

  def {{name.id}}(hash : Hash(String, String))
    hash.each do |key, value|
      ENV[key] {{comp.id}} value
    end
  end
  {% end %}

  def parse(filename = String) : Hash(String, String)
    env_vars = {} of String => String
    File.each_line File.expand_path(filename) do |line|
      line = line.strip
      next if line.blank?
      next if line.starts_with? '#'
      next unless line.includes? '='
      line = line.lchop("export").strip if line.starts_with? "export"
      key, value = line.split '=', 2
      env_vars[key.upcase] = value.strip '"'
    end
    env_vars
  rescue
    puts "ENVY - Failed to load #{filename}"
    {} of String => String
  end
end
