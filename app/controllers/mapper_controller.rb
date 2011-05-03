class MapperController < ApplicationController
	def sites
		sites = []
		dirs = Dir.new('public/sites')
		dirs.each do |dir|
			sites << 'sites/'+dir if dir[-6..-1] != '_thumb' && dir[0..0] != '.' 
		end
		@sites = []
		sites.each do |site|
			d = Dir.new(RAILS_ROOT+'/public/'+site)	
			images = []
			d.each do |file|
				images << file if file[-3..-1] && file[-3..-1].downcase == 'jpg'
			end
			@sites << [site,images.length]
		end
	end

	def best
		@path = params[:path]
		@images = Image.paginate :all, :conditions => ['path LIKE ?',@path+'%'], :per_page => 20, :page => params[:page]
	#	@images = images.sort_by do |i| 
	#		if (i.hits > 0)
	#			-1*i.points/i.hits
	#		else
	#			0
	#		end
	#	end
	end

end
