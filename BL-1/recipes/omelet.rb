include_recipe "python"

python_pip "omelet" do
    source "git+https://github.com/TrendMicroDCS/omelet.git@dcs-hybridcloud#egg=omelet"
    action :install
end
