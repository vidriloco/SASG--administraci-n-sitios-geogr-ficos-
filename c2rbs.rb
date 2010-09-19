#! /usr/bin/ruby
#
# Script que convierte una lista de coordenadas en coordenadas para ruby spatial
#

f=File.open("datos.txt")
nf=File.new("destino.txt", "w")

f.readlines.each do |line|
  nf << "\n#{line}\n" and next if(line.start_with? "--")
  
  line.split(" ").map do |c| 
    c.split(",").each_slice(3) { |lat, lon, alt| nf << "[#{lat},#{lon}]," } 
  end
  
 # nf << coords.inject("") do |memo, coord|
#    coord.split(",").map { |c| "[#{c[0]},#{c[1]}]" }
 # end
    
end