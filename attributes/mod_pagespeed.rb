case platform_family
when "rhel"
	default["apache2"]["mod_pagespeed"]["link_extension"] = "rpm"
when "debian"
	default["apache2"]["mod_pagespeed"]["link_extension"] = "deb"
else
	Chef::Log.warm "Google does not provide a package for this platform, yet."
end

if node['kernel']['machine'] == "x86_64"
then
	if platform_family?("rhel")
		default["apache2"]["mod_pagespeed"]["link_arch"] = "x86_64"
	else
		default["apache2"]["mod_pagespeed"]["link_arch"] = "amd64"
	end
else
	default["apache2"]["mod_pagespeed"]["link_arch"] = "i386"
end

default["apache2"]["mod_pagespeed"]["package_link"] = "https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_" + default["apache2"]["mod_pagespeed"]["link_arch"] + "." + default["apache2"]["mod_pagespeed"]["link_extension"]