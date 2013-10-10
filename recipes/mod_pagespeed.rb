remote_file "#{Chef::Config[:file_cache_path]}/mod-pagespeed." + node["apache2"]["mod_pagespeed"]["link_extension"] do
  source node["apache2"]["mod_pagespeed"]["package_link"]
  mode 0644
  action :create_if_missing
end

# switch between dpkg&yum, since the package resource needs version number.
case node["platform_family"]
when "debian"
  dpkg_package "mod_pagespeed" do
    source "#{Chef::Config[:file_cache_path]}/mod-pagespeed." + node["apache2"]["mod_pagespeed"]["link_extension"]
    action :install
  end
when "rhel"
  yum_package "mod_pagespeed" do
    source "#{Chef::Config[:file_cache_path]}/mod-pagespeed." + node["apache2"]["mod_pagespeed"]["link_extension"]
    action :install
  end
end

apache_module "pagespeed" do
  conf true
end
