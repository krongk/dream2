module ApplicationHelper

	#translate time
	def translate_time(time)
		now = Time.now
		re = ''
		dif = now - time
		if dif >= 86400
			re = time.strftime("%Y-%m-%d %H:%M")
		else
			hours = (dif/3600).to_i
			dif = dif%3600
			minutes = (dif/60).to_i
			seconds = (dif%60).to_i
			re = "#{hours}小时" if hours > 0
			re += "#{minutes}分钟前" 
		end
		return re
	end
end