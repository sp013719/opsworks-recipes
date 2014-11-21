execute "pip" do
    command "/usr/bin/pip git+https://github.com/TrendMicroDCS/omelet.git@dcs-hybridcloud#egg=omelet"
    user :root
    action :run
end
