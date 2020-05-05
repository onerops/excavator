module AppHelper
  extend self

  def load_file( path )
    File.read( File.expand_path( path, Rails.root.join("spec","data") ) )
  end

 # not guaranteed to be unique, useful for generating passwords
  def random_string(length = 10)
    chars = ['A'..'Z', 'a'..'z', '0'..'9'].map{|r|r.to_a}.flatten
    (0...length).map{ chars[rand(chars.size)] }.join
  end

  def random_int(length = 10)
    chars = ['0'..'9'].map{|r|r.to_a}.flatten
    (0...length).map{ chars[rand(chars.size)] }.join.to_i
  end

end
